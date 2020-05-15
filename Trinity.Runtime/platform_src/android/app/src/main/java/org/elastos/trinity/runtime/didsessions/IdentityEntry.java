package org.elastos.trinity.runtime.didsessions;

import org.json.JSONException;
import org.json.JSONObject;

public class IdentityEntry {
    public String didStoreId;
    public String didString;
    public String name;
    public IdentityAvatar avatar;

    IdentityEntry(String didStoreId, String didString, String name) {
        this(didStoreId, didString, name, null);
    }

    public IdentityEntry(String didStoreId, String didString, String name, IdentityAvatar avatar) {
        this.didStoreId = didStoreId;
        this.didString = didString;
        this.name = name;
        this.avatar = avatar;
    }

    public JSONObject asJsonObject() {
        try {
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("didStoreId", didStoreId);
            jsonObj.put("didString", didString);
            jsonObj.put("name", name);

            if (avatar != null) {
                jsonObj.put("avatar", avatar.asJsonObject());
            }

            return jsonObj;
        } catch (JSONException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static IdentityEntry fromJsonObject(JSONObject jsonObj) {
        if (!jsonObj.has("didStoreId") || !jsonObj.has("didString") || !jsonObj.has("name"))
            return null;

        try {
            IdentityEntry identity = new IdentityEntry(
                    jsonObj.getString("didStoreId"),
                    jsonObj.getString("didString"),
                    jsonObj.getString("name"));

            if (jsonObj.has("avatar")) {
                identity.avatar = IdentityAvatar.fromJsonObject(jsonObj.getJSONObject("avatar"));
            }

            return identity;
        } catch (JSONException e) {
            e.printStackTrace();
            return null;
        }
    }
}