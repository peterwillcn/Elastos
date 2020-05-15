package org.elastos.trinity.runtime;

import android.content.Context;
import android.content.res.AssetManager;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.InputStream;
import java.util.Iterator;
import java.util.LinkedHashMap;

public class PermissionManager {

    private Context context = null;
    protected LinkedHashMap<String, PermissionGroup> groupList = new LinkedHashMap();
    protected LinkedHashMap<String, String> appList = new LinkedHashMap();
    private static PermissionManager permissionManager;

    public PermissionManager(Context context) {
        this.context = context;
        try {
            parsePermissionGroup();
            parseAppPermission();
        } catch (Exception e) {
            e.printStackTrace();
        }
        PermissionManager.permissionManager = this;
    }

    public static PermissionManager getShareInstance() {
        return PermissionManager.permissionManager;
    }

    public LinkedHashMap<String, PermissionGroup> getGroupList() {
        return groupList;
    }

    public void parsePermissionGroup()  throws Exception {
        AssetManager manager = context.getAssets();
        InputStream inputStream = manager.open("www/config/permission/group.json");

        JSONObject json = Utility.getJsonFromFile(inputStream);

        Iterator groups = json.keys();
        while (groups.hasNext()) {
            String group = (String) groups.next();
            JSONObject jgroup = json.getJSONObject(group);
            Iterator plugins = jgroup.keys();
            PermissionGroup permissionGroup = new PermissionGroup(group);
                groupList.put(group, permissionGroup);
            while (plugins.hasNext()) {
                String plugin = (String) plugins.next();

                if (plugin.equals("*")) {
                    permissionGroup.setDefaultValue(true);
                    break;
                }

                if (plugin.startsWith("$")) {
                    permissionGroup.addBaseGroup(plugin.substring(1));
                    continue;
                }

                JSONArray array = jgroup.getJSONArray(plugin);
                Boolean defaultValue = false;
                if (plugin.startsWith("-")) {
                    plugin = plugin.substring(1);
                    defaultValue = true;
                }
                else if (plugin.startsWith("+")) {
                    plugin = plugin.substring(1);
                }

                PermissionGroup.PluginPermission pluginPermission = permissionGroup.addPlugin(plugin, defaultValue);

                for (int i = 0; i < array.length(); i++) {
                    String api = array.getString(i);
                    if (api.equals("*")) {
                        pluginPermission.setDefaultValue(!defaultValue);
                        break;
                    }
                    pluginPermission.setApiPermission(api, !defaultValue);
                }
            }
        }
    }

    public void parseAppPermission()  throws Exception {
        AssetManager manager = context.getAssets();
        InputStream inputStream = manager.open("www/config/permission/app.json");

        JSONObject json = Utility.getJsonFromFile(inputStream);

        Iterator apps = json.keys();
        while (apps.hasNext()) {
            String app = (String) apps.next();
            String group = json.getString(app);
            appList.put(app, group);
        }
    }

    public PermissionGroup getPermissionGroup(String app) {
        String group = appList.get(app);
        if (group == null) {
            group = "user";
        }

        PermissionGroup permissionGroup = groupList.get(group);
        if (permissionGroup == null) {
            permissionGroup = groupList.get("user");
        }

        return permissionGroup;
    }
}
