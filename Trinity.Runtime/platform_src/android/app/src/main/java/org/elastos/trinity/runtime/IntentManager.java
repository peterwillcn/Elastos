package org.elastos.trinity.runtime;

import android.content.Context;
import android.content.res.AssetManager;
import android.net.Uri;
import android.support.v4.app.FragmentManager;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Set;

public class IntentManager {
    public static final int MAX_INTENT_NUMBER = 20;

    private LinkedHashMap<String, ArrayList<IntentInfo>> intentList = new LinkedHashMap();
    private LinkedHashMap<Long, IntentInfo> intentContextList = new LinkedHashMap();
    private LinkedHashMap<String, ArrayList<Long>> intentIdList = new LinkedHashMap();

    private LinkedHashMap<String, IntentPermission> permissionList = new LinkedHashMap();
    private Context context = null;

    private AppManager appManager;

    private static IntentManager intentManager;

    IntentManager(AppManager appManager) {
        this.appManager = appManager;
        this.context = appManager.activity;

        try {
            parseIntentPermission();
        } catch (Exception e) {
            e.printStackTrace();
        }
        IntentManager.intentManager = this;
    }

    public static IntentManager getShareInstance() {
        return IntentManager.intentManager;
    }

    private void putIntentToList(String app_id, IntentInfo info) {
        ArrayList<IntentInfo> infos = intentList.get(app_id);
        if (infos == null) {
            infos = new ArrayList<IntentInfo>();
            intentList.put(app_id, infos);
        }
        infos.add(info);
    }

    public void setIntentReady(String id)  throws Exception {
        ArrayList<IntentInfo> infos = intentList.get(id);
        if ((infos == null) || (infos.size() < 1)) {
            return;
        }

        for (int i = 0; i < infos.size(); i++) {
            IntentInfo info = infos.get(i);
            sendIntent(info);
        }
        infos.clear();
        intentList.remove(id);
    }

    private synchronized void putIntentContext(IntentInfo info) {
        IntentInfo intentInfo = intentContextList.get(info.intentId);
        while (intentInfo != null) {
            info.intentId++;
            intentInfo = intentContextList.get(info.intentId);
        }

        intentContextList.put(info.intentId, info);
        ArrayList<Long> ids = intentIdList.get(info.fromId);
        if (ids != null) {
            while (ids.size() > MAX_INTENT_NUMBER) {
                long intentId = ids.get(0);
                ids.remove(0);
                intentContextList.remove(intentId);
            }
        }
        else {
            ids = new ArrayList<Long>();
            intentIdList.put(info.fromId, ids);
        }
        ids.add(info.intentId);
    }

    public String[] getIntentFilter(String action) throws Exception {
        String[] ids = appManager.dbAdapter.getIntentFilter(action);
        ArrayList<String>list = new ArrayList<String>();

        for (int i = 0; i < ids.length; i++) {
            if (this.getIntentReceiverPermission(action, ids[i])) {
                list.add(ids[i]);
            }
        }

        if (list.isEmpty()) {
            throw new Exception(action + " isn't support!");
        }

        ids = new String[list.size()];
        return list.toArray(ids);
    }

    public void sendIntent(IntentInfo info) throws Exception {
        if (info.toId == null) {
            String[] ids = getIntentFilter(info.action);

            if (!this.getIntentSenderPermission(info.action, info.fromId)) {
                throw new Exception(info.action + " isn't permission!");
            }

            info.toId = ids[0];
        }

        FragmentManager manager = appManager.activity.getSupportFragmentManager();
        WebViewFragment fragment = (WebViewFragment)manager.findFragmentByTag(info.toId);
        if ((fragment != null) && (fragment.basePlugin.isIntentReady())) {
            putIntentContext(info);
            appManager.start(info.toId);
            fragment.basePlugin.onReceiveIntent(info);
        }
        else {
            putIntentToList(info.toId, info);
            appManager.start(info.toId);
        }
    }

    public void sendIntentByUri(Uri uri) throws Exception {
        List<String> list = uri.getPathSegments();
        if (list.size() > 0) {
            String[] paths = new String[list.size()];
            list.toArray(paths);
            String action = paths[0];
            Set<String> set = uri.getQueryParameterNames();
            long currentTime = System.currentTimeMillis();

            IntentInfo info = new IntentInfo(action, null, "systyem", null, currentTime, null);
            if (set.size() > 0) {
                info.params = "{";
                for (String name : set) {
                    if (!info.params.equals("{")) {
                        info.params += ",";
                    }
                    info.params += "\"" + name + "\":\"" + uri.getQueryParameter(name) + "\"";
                }
                info.params += "}";
            }
            else {
                if (list.size() == 2) {
                    info.params = "{\"jwt\":\"" + paths[1] + "\"}";
                }
            }

            if (info.params != null) {
                sendIntent(info);
            }
        }
    }


    public void sendIntentResponse(String action, String result, long intentId, String fromId) throws Exception {
        IntentInfo info = intentContextList.get(intentId);
        if (info == null) {
            throw new Exception(intentId + " isn't support!");
        }

        FragmentManager manager = appManager.activity.getSupportFragmentManager();
        WebViewFragment fragment = (WebViewFragment)manager.findFragmentByTag(info.fromId);
        if (fragment != null) {
            appManager.start(info.fromId);
            info.params = result;
            info.fromId = fromId;
            fragment.basePlugin.onReceiveIntentResponse(info);
        }

        intentContextList.remove(intentId);
    }

    public void parseIntentPermission() throws Exception {
        AssetManager manager = context.getAssets();
        InputStream inputStream = manager.open("www/config/permission/intent.json");

        JSONObject json = Utility.getJsonFromFile(inputStream);

        Iterator intents = json.keys();
        while (intents.hasNext()) {
            String intent = (String) intents.next();
            IntentPermission intentPermission = new IntentPermission(intent);

            JSONObject jintent = json.getJSONObject(intent);
            JSONArray array = jintent.getJSONArray("sender");
            for (int i = 0; i < array.length(); i++) {
                String appId = array.getString(i);
                intentPermission.addSender(appId);
            }
            array = jintent.getJSONArray("receiver");
            for (int i = 0; i < array.length(); i++) {
                String appId = array.getString(i);
                intentPermission.addReceiver(appId);
            }

            permissionList.put(intent, intentPermission);
        }
    }

    public boolean getIntentSenderPermission(String intent, String appId) {
        IntentPermission intentPermission = permissionList.get(intent);
        if (intentPermission == null) {
            return true;
        }

        return intentPermission.senderIsAllow(appId);
    }

    public boolean getIntentReceiverPermission(String intent, String appId) {
        IntentPermission intentPermission = permissionList.get(intent);
        if (intentPermission == null) {
            return true;
        }

        return intentPermission.receiverIsAllow(appId);
    }
}
