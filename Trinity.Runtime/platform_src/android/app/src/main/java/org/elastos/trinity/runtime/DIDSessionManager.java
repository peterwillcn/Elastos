package org.elastos.trinity.runtime;

import androidx.annotation.NonNull;

import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONStringer;

import java.io.Serializable;
import java.util.ArrayList;

public class DIDSessionManager {
    private WebViewActivity activity;
    private static DIDSessionManager instance;

    static class IdentityEntry {
        String didStoreId;
        String didString;
        String name;

        IdentityEntry(String didStoreId, String didString, String name) {
            this.didStoreId = didStoreId;
            this.didString = didString;
            this.name = name;
        }

        public JSONObject asJsonObject() {
            try {
                JSONObject jsonObj = new JSONObject();
                jsonObj.put("didStoreId", didStoreId);
                jsonObj.put("didString", didString);
                jsonObj.put("name", name);
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
                return new IdentityEntry(
                        jsonObj.getString("didStoreId"),
                        jsonObj.getString("didString"),
                        jsonObj.getString("name"));
            } catch (JSONException e) {
                e.printStackTrace();
                return null;
            }
        }
    }

    DIDSessionManager(WebViewActivity activity) {
        this.activity = activity;
        DIDSessionManager.instance = this;
    }

    public static DIDSessionManager getSharedInstance() {
        return instance;
    }

    public void addIdentityEntry(IdentityEntry entry) throws Exception {
        activity.appManager.getDBAdapter().addDIDSessionIdentityEntry(entry);
    }

    public void deleteIdentityEntry(String didString) throws Exception {
        activity.appManager.getDBAdapter().deleteDIDSessionIdentityEntry(didString);
    }

    public ArrayList<IdentityEntry> getIdentityEntries() throws Exception {
        return activity.appManager.getDBAdapter().getDIDSessionIdentityEntries();
    }

    public IdentityEntry getSignedInIdentity() throws Exception {
        return activity.appManager.getDBAdapter().getDIDSessionSignedInIdentity();
    }

    public void signIn(IdentityEntry identityToSignIn) throws Exception {
        // Make sure there is no signed in identity already
        DIDSessionManager.IdentityEntry signedInIdentity = DIDSessionManager.getSharedInstance().getSignedInIdentity();
        if (signedInIdentity != null)
            throw new Exception("Unable to sign in. Please first sign out from the currently signed in identity");

        activity.appManager.getDBAdapter().setDIDSessionSignedInIdentity(identityToSignIn);
    }

    public void signOut() throws Exception {
        activity.appManager.getDBAdapter().setDIDSessionSignedInIdentity(null);
    }
}
