package org.elastos.trinity.runtime.notificationmanager;

import org.json.JSONException;
import org.json.JSONObject;

public class NotificationRequest {
    /** Identification key used to overwrite a previous notification if it has the same key. */
    public String key = null;
    /** Title to be displayed as the main message on the notification. */
    public String title = null;
    /** Intent URL emitted when the notification is clicked. */
    public String url = null;
    /** Contact DID emitting this notification, in case of a remotely received notification. */
    public String emitter = null;

    public static NotificationRequest fromJSONObject(JSONObject obj) {
        try {
            NotificationRequest notif = new NotificationRequest();
            if (obj.has("key"))
                notif.key = obj.getString("key");
            if (obj.has("title"))
                notif.title = obj.getString("title");
            if (obj.has("url"))
                notif.url = obj.getString("url");
            if (obj.has("emitter"))
                notif.emitter = obj.getString("emitter");
            return notif;
        }
        catch (JSONException e) {
            e.printStackTrace();
            return null;
        }
    }
}
