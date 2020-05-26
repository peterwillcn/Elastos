 /*
  * Copyright (c) 2020 Elastos Foundation
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
  * in the Software without restriction, including without limitation the rights
  * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  * copies of the Software, and to permit persons to whom the Software is
  * furnished to do so, subject to the following conditions:
  *
  * The above copyright notice and this permission notice shall be included in all
  * copies or substantial portions of the Software.
  *
  * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  * SOFTWARE.
  */


package org.elastos.trinity.runtime;

import android.content.Context;

import org.json.JSONObject;

import java.util.ArrayList;

public class MergeDBAdapter {
    private Context context = null;
    ManagerDBAdapter baseDBAdapter = null;
    ManagerDBAdapter userDBAdapter = null;

    public MergeDBAdapter(Context context) {
        this.context = context;
        this.baseDBAdapter = new ManagerDBAdapter(context);
    }

    public void setUserDBAdapter(String path) {
        if (path != null) {
            userDBAdapter = new ManagerDBAdapter(context, path);
        }
        else {
            userDBAdapter = null;
        }
    }

    public boolean addAppInfo(AppInfo info, Boolean isShare) {
        if (info != null) {
            if (isShare || info.built_in == 1 || userDBAdapter == null) {
                return baseDBAdapter.addAppInfo(info);
            }
            else {
                return userDBAdapter.addAppInfo(info);
            }
        }
        else {
            return false;
        }
    }

    public AppInfo getAppInfo(String id) {
        AppInfo info = null;
        if (userDBAdapter != null) {
            info = userDBAdapter.getAppInfo(id);
        }
        if (info == null) {
            info = baseDBAdapter.getAppInfo(id);
        }
        else {
            info.share = false;
        }
        return info;
    }

    public AppInfo[] getAppInfos() {
        ArrayList<AppInfo> list = new ArrayList<AppInfo>();
        AppInfo[] infos = new AppInfo[0];
        if (userDBAdapter != null) {
            infos = userDBAdapter.getAppInfos();
        }


        for (AppInfo info: infos) {
            info.share = false;
            list.add(info);
        }

        AppInfo[] baseInfos = baseDBAdapter.getAppInfos();
        for (AppInfo baseInfo: baseInfos) {
            Boolean needAdd = true;
            for (AppInfo info: infos) {
                if (baseInfo.app_id.equals(info.app_id)) {
                    needAdd = false;
                    break;
                }
            }
            if (needAdd) {
                list.add(baseInfo);
            }
        }

        infos = new AppInfo[list.size()];
        return list.toArray(infos);
    }

    public AppInfo getLauncherInfo() {
        return baseDBAdapter.getLauncherInfo();
    }

    public int changeBuiltInToNormal(String appId) {
        return baseDBAdapter.changeBuiltInToNormal(appId);
    }

    public int updatePluginAuth(long tid, String plugin, int authority) {
        if (userDBAdapter != null) {
            return userDBAdapter.updatePluginAuth(tid, plugin, authority);
        }
        else {
            return 0;
        }
    }

    public int updateURLAuth(long tid, String url, int authority) {
        if (userDBAdapter != null) {
            return userDBAdapter.updateURLAuth(tid, url, authority);
        }
        else {
            return 0;
        }
    }

    public int updateIntentAuth(long tid, String url, int authority) {
        if (userDBAdapter != null) {
            return userDBAdapter.updateIntentAuth(tid, url, authority);
        }
        else {
            return 0;
        }
    }

    public int removeAppInfo(AppInfo info, Boolean isShare) {
        if (userDBAdapter != null && !isShare) {
            return userDBAdapter.removeAppInfo(info);
        }
        else {
            return baseDBAdapter.removeAppInfo(info);
        }
    }

    public String[] getIntentFilter(String action) {
        ArrayList<String> list = new ArrayList<String>();
        String[] ids = null;
        if (userDBAdapter != null) {
            ids = userDBAdapter.getIntentFilter(action);
        }

        String[] baseIds = baseDBAdapter.getIntentFilter(action);

        for (String id: ids) {
            list.add(id);
        }

        for (String baseId: baseIds) {
            Boolean needAdd = true;
            for (String id: ids) {
                if (baseId.equals(id)) {
                    needAdd = false;
                    break;
                }
            }
            if (needAdd) {
                list.add(baseId);
            }
        }

        ids = new String[list.size()];
        return list.toArray(ids);
    }

    public long setSetting(String id, String key, Object value) throws Exception {
        if (userDBAdapter != null) {
            return userDBAdapter.setSetting(id, key, value);
        }
        else {
            return baseDBAdapter.setSetting(id, key, value);
        }
    }

    public JSONObject getSetting(String id, String key) throws Exception {
        if (userDBAdapter != null) {
            return userDBAdapter.getSetting(id, key);
        }
        else {
            return baseDBAdapter.getSetting(id, key);
        }
    }

    public JSONObject getSettings(String id) throws Exception {
        if (userDBAdapter != null) {
            return userDBAdapter.getSettings(id);
        }
        else {
            return baseDBAdapter.getSettings(id);
        }
    }

    public long setPreference(String key, Object value) throws Exception {
        if (userDBAdapter != null) {
            return userDBAdapter.setPreference(key, value);
        }
        else {
            return baseDBAdapter.setPreference(key, value);
        }
    }

    public void resetPreferences() {
        if (userDBAdapter != null) {
            userDBAdapter.resetPreferences();
        }
        else {
            baseDBAdapter.resetPreferences();
        }
    }

    public JSONObject getPreference(String key) throws Exception {
        if (userDBAdapter != null) {
            return userDBAdapter.getPreference(key);
        }
        else {
            return baseDBAdapter.getPreference(key);
        }
    }

    public JSONObject getPreferences() throws Exception {
        if (userDBAdapter != null) {
            return userDBAdapter.getPreferences();
        }
        else {
            return baseDBAdapter.getPreferences();
        }
    }

    public int getApiAuth(String appId, String plugin, String api) {
        if (userDBAdapter != null) {
            return userDBAdapter.getApiAuth(appId, plugin, api);
        }
        else {
            return baseDBAdapter.getApiAuth(appId, plugin, api);
        }
    }

    public long setApiAuth(String appId, String plugin, String api, int auth) {
        if (userDBAdapter != null) {
            return userDBAdapter.setApiAuth(appId, plugin, api, auth);
        }
        else {
            return baseDBAdapter.setApiAuth(appId, plugin, api, auth);
        }
    }

    public void resetApiDenyAuth(String appId)  {
        if (userDBAdapter != null) {
            userDBAdapter.resetApiDenyAuth(appId);
        }
        else {
            baseDBAdapter.resetApiDenyAuth(appId);
        }
    }
}
