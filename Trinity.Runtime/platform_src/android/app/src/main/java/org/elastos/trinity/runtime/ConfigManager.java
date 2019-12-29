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

    private LinkedHashMap<String, String> configPreferences = new LinkedHashMap();
    private Context context = null;

    ConfigManager(AppManager appManager) {
//        this.appManager = appManager;
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

        JSONObject json = Utility.getJsonFromFile(inputStream);

        Iterator preferences = json.keys();
        while (preferences.hasNext()) {
            String key = (String)preferences.next();
            String preference = json.getString(key);
            configPreferences.put(key, preference);
        }
    }

    public String getPreferenceValue(String key) {
        return configPreferences.get(key);
    }

}
