package org.elastos.trinity.runtime;

import java.util.ArrayList;
import java.util.LinkedHashMap;

public class PermissionGroup {

    protected LinkedHashMap<String, PluginPermission> pluginList = new LinkedHashMap();
    private String name;
    public Boolean defaultValue = false;

    public PermissionGroup(String name) {
        this.name = name;
    }

    public void setDefaultValue(Boolean defaultValue) {
        this.defaultValue = defaultValue;
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
        PluginPermission pluginPermission = pluginList.get(plugin);
        if (pluginPermission == null) {
            return defaultValue;
        }

        return pluginPermission.getApiPermission(api);
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
