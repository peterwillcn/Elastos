package org.elastos.trinity.runtime.contactnotifier;

import org.json.JSONException;
import org.json.JSONObject;

public class RemoteNotificationRequest {
    /** Identification key used to overwrite a previous notification if it has the same key. */
    String key = null;
    /** Package ID of the sending app. */
    String appId = null;
    /** Title to be displayed as the main message on the notification. */
    String title = null;
    /** Intent URL emitted when the notification is clicked. */
    String url = null;

    public static RemoteNotificationRequest fromJSONObject(JSONObject obj) {
        try {
            RemoteNotificationRequest notif = new RemoteNotificationRequest();
            if (obj.has("key"))
                notif.key = obj.getString("key");
            if (obj.has("appId"))
                notif.appId = obj.getString("appId");
            if (obj.has("title"))
                notif.title = obj.getString("title");
            if (obj.has("url"))
                notif.url = obj.getString("url");
            return notif;
        }
        catch (JSONException e) {
            e.printStackTrace();
            return null;
        }
    }
}
