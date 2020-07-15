package org.elastos.trinity.runtime;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.res.AssetManager;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TextView;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.InputStream;
import java.util.Iterator;
import java.util.LinkedHashMap;

public class ApiAuthorityManager {
    public static final String DANGER_LEVEL_HIGH = "high";
    public static final String DANGER_LEVEL_MEDIUM = "medium";
    public static final String DANGER_LEVEL_LOW = "low";

    private Activity activity = null;
    private static ApiAuthorityManager apiAuthorityManager;
    protected LinkedHashMap<String, ApiAuthorityInfo> infoList = new LinkedHashMap();
    MergeDBAdapter dbAdapter = null;;

    ApiAuthorityManager() {
        this.activity = AppManager.getShareInstance().activity;
        this.dbAdapter = AppManager.getShareInstance().getDBAdapter();

        try {
            parseJson();
        } catch (Exception e) {
            e.printStackTrace();
        }
        ApiAuthorityManager.apiAuthorityManager = this;
    }

    public static ApiAuthorityManager getShareInstance() {
        if (ApiAuthorityManager.apiAuthorityManager == null) {
            ApiAuthorityManager.apiAuthorityManager = new ApiAuthorityManager();
        }
        return ApiAuthorityManager.apiAuthorityManager;
    }

    public void parseJson() throws Exception {
        AssetManager manager = activity.getAssets();
        InputStream inputStream = manager.open("www/config/authority/api.json");

        JSONObject json = Utility.getJsonFromFile(inputStream);

        Iterator plugins = json.keys();
        while (plugins.hasNext()) {
            String plugin = (String) plugins.next();
            JSONObject jplugin = json.getJSONObject(plugin);
            Iterator apis = jplugin.keys();

            while (apis.hasNext()) {
                String api = (String) apis.next();
                JSONObject japi = jplugin.getJSONObject(api);

                String dangerLevel = japi.getString("danger_level");
                JSONObject title = japi.getJSONObject("title");
                JSONObject description = japi.getJSONObject("description");

                ApiAuthorityInfo info = new ApiAuthorityInfo(dangerLevel, title, description);
                infoList.put(plugin + "." + api, info);
            }
        }
    }

    public ApiAuthorityInfo getApiAuthorityInfo(String plugin, String api) {
        return infoList.get(plugin + "." + api);
    }

    private int getApiAuth(String appId, String plugin, String api) {
        int ret = this.dbAdapter.getApiAuth(appId, plugin, api);
        if (ret == AppInfo.AUTHORITY_NOEXIST) {
            ret = AppInfo.AUTHORITY_NOINIT;
        }
        return ret;
    }

    private void setApiAuth(String appId, String plugin, String api, int auth) {
        dbAdapter.setApiAuth(appId, plugin, api, auth);
    }

    private class LockObj {
        int authority = AppInfo.AUTHORITY_NOINIT;
    }

    private LockObj apiLock = new LockObj();

    public void alertApiAuth(AppInfo info, String plugin, String api, LockObj lock) {
        ApiAuthorityInfo authInfo = getApiAuthorityInfo(plugin, api);

        new ApiAuthorityDialog.Builder(activity)
            .setData(authInfo, info, plugin, api)
            .setOnAcceptClickedListener(() -> {
                try {
                    setApiAuth(info.app_id, plugin, api, AppInfo.AUTHORITY_ALLOW);
                }
                catch (Exception e) {
                    e.printStackTrace();
                }
                synchronized (lock) {
                    lock.authority = AppInfo.AUTHORITY_ALLOW;
                    lock.notify();
                }
            })
            .setOnDenyClickedListener(() -> {
                try {
                    setApiAuth(info.app_id, plugin, api, AppInfo.AUTHORITY_DENY);
                }
                catch (Exception e) {
                    e.printStackTrace();
                }
                synchronized (lock) {
                    lock.authority = AppInfo.AUTHORITY_DENY;
                    lock.notify();
                }
            })
            .show();
    }

    public synchronized int runAlertApiAuth(AppInfo appInfo, String plugin, String api, int originAuthority) {
        try {
            synchronized (apiLock) {
                apiLock.authority = getApiAuth(appInfo.app_id, plugin, api);
                if (apiLock.authority != originAuthority && apiLock.authority != AppInfo.AUTHORITY_NOINIT ) {
                    return apiLock.authority;
                }
                activity.runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        alertApiAuth(appInfo, plugin, api, apiLock);
                    }
                });

                if (apiLock.authority == originAuthority) {
                    apiLock.wait();
                }
            }
        } catch (InterruptedException e) {
            e.printStackTrace();
            return originAuthority;
        }
        return apiLock.authority;
    }

    private Boolean isInWhitelist(String appId) {
        return ConfigManager.getShareInstance().stringArrayContains("api.authority.whitelist", appId);
    }

    public int getApiAuthority(AppInfo appInfo, String plugin, String api) {
        if (isInWhitelist(appInfo.app_id)) {
            return AppInfo.AUTHORITY_ALLOW;
        }

        ApiAuthorityInfo info = getApiAuthorityInfo(plugin, api);
        if (info != null) {
//            setApiAuth(appInfo.app_id, plugin, api, AppInfo.AUTHORITY_NOINIT); //for test
            int authority = getApiAuth(appInfo.app_id, plugin, api);
            if (authority == AppInfo.AUTHORITY_NOINIT || authority == AppInfo.AUTHORITY_ASK) {
                authority = runAlertApiAuth(appInfo, plugin, api, authority);
            }
            return authority;
        }
        return AppInfo.AUTHORITY_ALLOW;
    }


    class ApiAuthorityInfo {
        String dangerLevel = "high";
        JSONObject title = null;
        JSONObject description = null;

        ApiAuthorityInfo(String dangerLevel, JSONObject title, JSONObject description) {
            this.dangerLevel = dangerLevel;
            this.title = title;
            this.description = description;
        }

        public String getLocalizedTitle()  {
            String local = PreferenceManager.getShareInstance().getStringValue("locale.language", "en");

            if (!this.title.has(local)) {
                local = "en";
            }

            String ret = "";
            try {
                ret = this.title.getString(local);
            }
            catch (JSONException e) {
                e.printStackTrace();
            }

            return ret;
        }

        public String getLocalizedDescription() {
            String local = PreferenceManager.getShareInstance().getStringValue("locale.language", "en");

            if (!this.description.has(local)) {
                local = "en";
            }

            String ret = "";
            try {
                ret = this.description.getString(local);
            }
            catch (JSONException e) {
                e.printStackTrace();
            }

            return ret;
        }
    }

}
