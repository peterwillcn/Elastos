package org.elastos.trinity.runtime.didsessions;

import org.json.JSONException;
import org.json.JSONObject;

public class IdentityAvatar {
    String contentType;
    byte[] base64ImageData;

    public IdentityAvatar(String contentType, byte[] base64ImageData) {
        this.contentType = contentType;
        this.base64ImageData = base64ImageData;
    }

    public JSONObject asJsonObject() {
        try {
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("contentType", contentType);
            jsonObj.put("base64ImageData", base64ImageData);
            return jsonObj;
        } catch (JSONException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static IdentityAvatar fromJsonObject(JSONObject jsonObj) {
        if (!jsonObj.has("contentType") || !jsonObj.has("base64ImageData"))
            return null;

        try {
            IdentityAvatar avatar = new IdentityAvatar(
                    jsonObj.getString("contentType"),
                    (byte[]) jsonObj.get("base64ImageData"));

            return avatar;
        } catch (JSONException e) {
            e.printStackTrace();
            return null;
        }
    }
}