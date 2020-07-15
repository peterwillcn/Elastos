package org.elastos.trinity.runtime;

import java.util.ArrayList;
import java.util.LinkedHashMap;

public class PermissionGroup {
    private ArrayList<String> baseGroups = null;
    protected LinkedHashMap<String, PluginPermission> pluginList = new LinkedHashMap();
    private String name;
    public Boolean defaultValue = false;

    public PermissionGroup(String name) {
        this.name = name;
    }

    public void setDefaultValue(Boolean defaultValue) {
        this.defaultValue = defaultValue;
    }

    public void addBaseGroup(String group) {
        if (baseGroups == null) {
            baseGroups = new ArrayList<String>();
        }
        baseGroups.add(group);
    }

    public PluginPermission addPlugin(String plugin, Boolean defaultValue) {
        PluginPermission pluginPermission = pluginList.get(plugin);
        if (pluginPermission == null) {
            pluginPermission = new PluginPermission(defaultValue);
            pluginList.put(plugin, pluginPermission);
        }
        return pluginPermission;
    }

    public Boolean getApiPermission(String plugin, String api) {
        Boolean ret = defaultValue;
        PluginPermission pluginPermission = pluginList.get(plugin);
        if (pluginPermission != null) {
            ret = pluginPermission.getApiPermission(api);
        }

        if (ret != true) {
            ret = getBasePermission(plugin, api);
        }

        return ret;
    }

    public Boolean getBasePermission(String plugin, String api) {
        if (baseGroups != null) {
            for(int i = 0;i < baseGroups.size(); i ++){
                String name = baseGroups.get(i);
                PermissionGroup baseGroup = PermissionManager.getShareInstance().groupList.get(name);
                if (baseGroup != null) {
                    Boolean ret = baseGroup.getApiPermission(plugin, api);
                    if (ret == true) {
                        return true;
                    }
                }
            }
        }

        return false;
    }

    public class PluginPermission {
        LinkedHashMap<String, Boolean> apiList = new LinkedHashMap();
        public Boolean defaultValue = false;

        public PluginPermission(Boolean defaultValue) {
            this.defaultValue = defaultValue;
        }

        public void setDefaultValue(Boolean defaultValue) {
            this.defaultValue = defaultValue;
        }

        public Boolean getApiPermission(String api) {
            if (apiList.isEmpty()) {
                return defaultValue;
            }

            Boolean permission = apiList.get(api);
            if (permission == null) {
                return defaultValue;
            }

            return permission;
        }

        public void setApiPermission(String api, Boolean permission) {
            apiList.put(api, permission);
        }
    }
}
