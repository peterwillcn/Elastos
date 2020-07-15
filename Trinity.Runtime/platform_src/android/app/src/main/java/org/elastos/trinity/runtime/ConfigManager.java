package org.elastos.trinity.runtime;

import android.content.Context;
import android.content.res.AssetManager;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.InputStream;

//For publish config
public class ConfigManager {
    private static ConfigManager configManager;

    private JSONObject configPreferences = null;
    private Context context = null;

    ConfigManager() {
        this.context = AppManager.getShareInstance().activity;

        try {
            parseConfig();
        } catch (Exception e) {
            e.printStackTrace();
        }
        ConfigManager.configManager = this;
    }

    public static ConfigManager getShareInstance() {
        if (ConfigManager.configManager == null) {
            ConfigManager.configManager = new ConfigManager();
        }
        return ConfigManager.configManager;
    }

    public void parseConfig() throws Exception {
        AssetManager manager = context.getAssets();
        InputStream inputStream = manager.open("www/config/config.json");

        configPreferences = Utility.getJsonFromFile(inputStream);
    }

    public String getStringValue(String key, String defaultValue) {
        try {
            String value = configPreferences.getString(key);
            if (value == null) {
                value = defaultValue;
            }
            return value;
        } catch (Exception e) {
            return defaultValue;
        }
    }

    public boolean getBooleanValue(String key, boolean defaultValue) {
        try {
            boolean value = configPreferences.getBoolean(key);
            return value;
        } catch (Exception e) {
            return defaultValue;
        }
    }

    public String[] getStringArrayValue(String key, String[] defaultValue) {
        try {
            JSONArray array = configPreferences.getJSONArray(key);
            if (array == null) {
                return defaultValue;
            }

            String[] value = new String[array.length()];
            for (int i = 0; i < array.length(); i++) {
                value[i] = array.getString(i);
            }
            return value;
        } catch (Exception e) {
            return defaultValue;
        }
    }

    public boolean stringArrayContains(String key, String value) {
        try {
            JSONArray array = configPreferences.getJSONArray(key);
            if (array != null) {
                for (int i = 0; i < array.length(); i++) {
                    if (value.equals(array.getString(i))) {
                        return true;
                    }
                }
            }
            return false;
        } catch (Exception e) {
            return false;
        }
    }

}
