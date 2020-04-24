package org.elastos.trinity.runtime.passwordmanager;

import org.json.JSONException;
import org.json.JSONObject;

/**
 * Root type for all password information. This type is abstract and should not be used
 * directly.
 */
public class PasswordInfo {
    /**
     * Unique key, used to identity the password info among other.
     */
    String key;

    /**
     * Password type, that defines the format of contained information.
     */
    PasswordType type;

    /**
     * Name used while displaying this info. Either set by users in the password manager app
     * or by apps, when saving passwords automatically.
     */
    String displayName;

    /**
     * List of any kind of app-specific additional information for this password entry.
     */
    JSONObject custom;

    PasswordInfo(String key, PasswordType type, String displayName) {
        this.key = key;
        this.type = type;
        this.displayName = displayName;
    }

    public JSONObject asJsonObject() {
        try {
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("key", key);
            jsonObj.put("type", type.mValue);
            jsonObj.put("displayName", displayName);
            jsonObj.put("custom", custom);
            return jsonObj;
        } catch (JSONException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static PasswordInfo fromJsonObject(JSONObject jsonObj) {
        if (!jsonObj.has("key") || !jsonObj.has("type") || !jsonObj.has("displayName"))
            return null;

        try {
            PasswordInfo info = new PasswordInfo(
                    jsonObj.getString("key"),
                    PasswordType.fromValue(jsonObj.getInt("type")),
                    jsonObj.getString("displayName"));

            if (jsonObj.has("custom")) {
                info.custom = jsonObj.getJSONObject("custom");
            }

            return info;
        } catch (JSONException e) {
            e.printStackTrace();
            return null;
        }
    }
}