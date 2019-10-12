package org.elastos.trinity.runtime;

import android.net.Uri;
import android.support.v4.app.FragmentManager;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Set;

public class IntentManager {
    public static final int MAX_INTENT_NUMBER = 20;

    private LinkedHashMap<String, ArrayList<IntentInfo>> intentList = new LinkedHashMap();
    private LinkedHashMap<Long, IntentInfo> intentContextList = new LinkedHashMap();
    private LinkedHashMap<String, ArrayList<Long>> intentIdList = new LinkedHashMap();

    private AppManager appManager;

    private static IntentManager intentManager;

    IntentManager(AppManager appManager) {
        this.appManager = appManager;
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

    public void sendIntent(IntentInfo info) throws Exception {
        String[] ids = appManager.dbAdapter.getIntentFilter(info.action);
        if (ids.length < 1) {
            throw new Exception(info.action + " isn't support!");
        }

        String toId = ids[0];
        FragmentManager manager = appManager.activity.getSupportFragmentManager();
        WebViewFragment fragment = (WebViewFragment)manager.findFragmentByTag(toId);
        if ((fragment != null) && (fragment.basePlugin.isIntentReady())) {
            putIntentContext(info);
            appManager.start(toId);
            fragment.basePlugin.onReceiveIntent(info);
        }
        else {
            putIntentToList(toId, info);
            appManager.start(toId);
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

            IntentInfo info = new IntentInfo(action, null, "systyem", currentTime, null);
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

}
