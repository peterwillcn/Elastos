package org.elastos.trinity.runtime;

import android.content.Context;
import android.content.res.AssetManager;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.InputStream;
import java.util.Iterator;
import java.util.Locale;

public class PreferenceManager {
    private static PreferenceManager preferenceManager;

    private JSONObject defaultPreferences = new JSONObject();
    ManagerDBAdapter dbAdapter = null;

    PreferenceManager() {
        dbAdapter = AppManager.getShareInstance().getDBAdapter();
        try {
            parsePreferences();
        } catch (Exception e) {
            e.printStackTrace();
        }
        PreferenceManager.preferenceManager = this;
    }

    public static PreferenceManager getShareInstance() {
        if (PreferenceManager.preferenceManager == null) {
            PreferenceManager.preferenceManager = new PreferenceManager();
        }
        return PreferenceManager.preferenceManager;
    }

    public void parsePreferences() throws Exception {
        AssetManager manager = AppManager.getShareInstance().activity.getAssets();
        InputStream inputStream = manager.open("www/config/preferences.json");

        JSONObject json = Utility.getJsonFromFile(inputStream);

        Iterator keys = json.keys();
        while (keys.hasNext()) {
            String key = (String)keys.next();
            String value = json.get(key).toString();
            defaultPreferences.put(key, value);
        }
    }

    private String getDefaultValue(String key) throws Exception {
        String value = defaultPreferences.get(key).toString();
        return value;
    }

    public String getPreference(String key) throws Exception  {
        String defaultValue = getDefaultValue(key);
        if (defaultValue == null) {
            throw new Exception("getPreference error: no such preference!");
        }

        String value = dbAdapter.getPreference(key);
        if (value == null) {
            value = defaultValue;
        }
        else if (value == "native system") {
            value = Locale.getDefault().getLanguage();
        }

        return value;
    }

    public JSONObject getPreferences() throws Exception {
        JSONObject values = dbAdapter.getPreferences();
        Iterator keys = defaultPreferences.keys();
        while (keys.hasNext()) {
            String key = (String)keys.next();
            if (values.getString(key) == null) {
                String value = defaultPreferences.getString(key);
                values.put(key, value);
            }
        }
        return values;
    }

    public void setPreference(String key, String value) throws Exception {
        String defaultValue = getDefaultValue(key);
        if (defaultValue == null) {
            throw new Exception("setPreference error: no such preference!");
        }

        if (dbAdapter.setPreference(key, value) != 1) {
            throw new Exception("setPreference error: write db error!");
        }

//        if (key == "developer.mode") {
//            Boolean isMode = false;
//            if (value != null) {
//                isMode = Boolean.getBoolean(value);
//            }
//
//            if (isMode) {
//                CLIService.getShareInstance().start();
//            }
//            else {
//                CLIService.getShareInstance().stop();
//            }
//        }

        AppManager.getShareInstance().broadcastMessage(AppManager.MSG_TYPE_IN_REFRESH,
                "{\"action\":\"preferenceChanged\", \"" + key + "\":\""
                        + value + "\"}", "system");
    }

    public Boolean getDeveloperMode() {
        String value = null;
        try {
            value = getPreference("developer.mode");
        }
        catch (Exception e){
            e.printStackTrace();
        }

        if (value == null) {
            return false;
        }
        return Boolean.getBoolean(value);
    }

    public void setDeveloperMode(Boolean value) {
        try {
            setPreference("developer.mode", value.toString());
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }

    public String getCurrentLocale() throws Exception {
        String value = getPreference("locale.language");
        if (value.equals("native system")) {
            value = Locale.getDefault().getLanguage();
        }
        return value;
    }

    public void setCurrentLocale(String code) throws Exception {
        setPreference("locale.language", code);
        AppManager.getShareInstance().broadcastMessage(AppManager.MSG_TYPE_IN_REFRESH,
                "{\"action\":\"currentLocaleChanged\", \"code\":\"" + code + "\"}", AppManager.LAUNCHER);
    }
}
