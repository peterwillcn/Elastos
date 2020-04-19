package org.elastos.trinity.runtime;

import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
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

        // Make some services ready
        boolean darkMode = getBooleanValue("ui.darkmode", false);
        prepareUIStyling(darkMode);
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

        defaultPreferences = Utility.getJsonFromFile(inputStream);
        defaultPreferences.put("version", getVersion());
    }

    private Object getDefaultValue(String key) throws Exception {
        Object value = null;
        if (defaultPreferences.has(key)) {
            value = defaultPreferences.get(key);
        }
        return value;
    }

    public JSONObject getPreference(String key) throws Exception  {
        Object defaultValue = getDefaultValue(key);
        if (defaultValue == null) {
            throw new Exception("getPreference error: no such preference!");
        }

        JSONObject ret = dbAdapter.getPreference(key);

        if (ret == null) {
            ret = new JSONObject();
            ret.put("key", key);
            ret.put("value", defaultValue);
        }

        if (key.equals("locale.language") && ret.getString("value").equals("native system")) {
            ret.put("value", Locale.getDefault().getLanguage());
        }

        return ret;
    }

    public JSONObject getPreferences() throws Exception {
        JSONObject values = dbAdapter.getPreferences();
        Iterator keys = defaultPreferences.keys();
        while (keys.hasNext()) {
            String key = (String)keys.next();
            if (!values.has(key)) {
                Object value = defaultPreferences.get(key);
                values.put(key, value);
            }

            if (key.equals("locale.language") && values.getString(key).equals("native system")) {
                values.put(key, Locale.getDefault().getLanguage());
            }
        }
        return values;
    }

    final static String[] refuseSetPreferences = {
            "version"
    };

    private Boolean isAllowSetPreference(String key) {
        for (String item : PreferenceManager.refuseSetPreferences) {
            if (item.equals(key)) {
                return false;
            }
        }
        return true;
    }

    public void setPreference(String key, Object value) throws Exception {
        if (!isAllowSetPreference(key)) {
            throw new Exception("setPreference error: " + key + " can't be set!");
        }

        Object defaultValue = getDefaultValue(key);
        if (defaultValue == null) {
            throw new Exception("setPreference error: no such preference!");
        }

        if (dbAdapter.setPreference(key, value) < 1) {
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

        if (key.equals("ui.darkmode")) {
            prepareUIStyling((Boolean)value);
        }

        JSONObject data = new JSONObject();
        data.put("key", key);
        data.put("value", value);
        JSONObject json = new JSONObject();
        json.put("action", "preferenceChanged");
        json.put("data", data);
        AppManager.getShareInstance().broadcastMessage(AppManager.MSG_TYPE_IN_REFRESH,
                json.toString() , "system");
    }

    public Boolean getDeveloperMode() {
        return getBooleanValue("developer.mode", false);
    }

    public void setDeveloperMode(Boolean value) {
        try {
            setPreference("developer.mode", value);
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }

    public String getCurrentLocale() throws Exception {
        JSONObject value = getPreference("locale.language");
        String ret = value.getString("value");
        if (ret.equals("native system")) {
            ret = Locale.getDefault().getLanguage();
        }
        return ret;
    }

    public void setCurrentLocale(String code) throws Exception {
        setPreference("locale.language", code);
        JSONObject json = new JSONObject();
        json.put("action", "currentLocaleChanged");
        json.put("data", code);
        AppManager.getShareInstance().broadcastMessage(AppManager.MSG_TYPE_IN_REFRESH,
                json.toString(), AppManager.LAUNCHER);
    }

    public String getVersion() throws Exception {
        Context context = AppManager.getShareInstance().activity;
        PackageManager manager = context.getPackageManager();
        PackageInfo info = manager.getPackageInfo(context.getPackageName(), 0);
        return info.versionName;
    }

    public String getWalletNetworkType()  {
        return getStringValue("chain.network.type", "MainNet");
    }

    public String getWalletNetworkConfig()  {
        return getStringValue("chain.network.config", "");
    }

    public String getDIDResolver()  {
        return getStringValue("did.resolver", "http://api.elastos.io:20606");
    }

    public String getStringValue(String key, String defaultValue) {
        String value = null;
        try {
            JSONObject item = getPreference(key);
            value = item.getString("value");
        }
        catch (Exception e){
            e.printStackTrace();
        }

        if (value == null) {
            value = defaultValue;
        }

        return value;
    }

    public boolean getBooleanValue(String key, boolean defaultValue) {
        Boolean value = null;
        try {
            JSONObject item = getPreference(key);
            value = item.getBoolean("value");
        }
        catch (Exception e){
            e.printStackTrace();
        }

        if (value == null) {
            value = defaultValue;
        }

        return value;
    }

    public String[] getStringArrayValue(String key, String[] defaultValue) {
        String[] value = null;
        try {
            JSONObject item = getPreference(key);
            JSONArray array =  item.getJSONArray("value");
            if (array != null) {
                value = new String[array.length()];
                for (int i = 0; i < array.length(); i++) {
                    value[i] = array.getString(i);
                }
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }

        if (value == null) {
            value = defaultValue;
        }

        return value;
    }

    private void prepareUIStyling(boolean useDarkMode) {
        UIStyling.prepare(useDarkMode);
    }
}
