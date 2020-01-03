package org.elastos.trinity.runtime;

import android.content.Context;
import android.content.res.AssetManager;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.InputStream;
import java.util.Iterator;
import java.util.LinkedHashMap;

public class ConfigManager {
    private static ConfigManager configManager;

    private JSONObject configPreferences = null;
    private Context context = null;

    ConfigManager(AppManager appManager) {
        this.context = appManager.activity;

        try {
            parsePreferences();
        } catch (Exception e) {
            e.printStackTrace();
        }
        ConfigManager.configManager = this;
    }

    public static ConfigManager getShareInstance() {
        if (ConfigManager.configManager == null) {
            ConfigManager.configManager = new ConfigManager(AppManager.getShareInstance());
        }
        return ConfigManager.configManager;
    }

    public void parsePreferences() throws Exception {
        AssetManager manager = context.getAssets();
        InputStream inputStream = manager.open("www/config/preferences.json");

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

}
