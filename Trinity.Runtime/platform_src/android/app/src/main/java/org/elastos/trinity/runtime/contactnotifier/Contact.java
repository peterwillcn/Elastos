package org.elastos.trinity.runtime.contactnotifier;

import android.database.Cursor;

import org.elastos.trinity.runtime.contactnotifier.db.DatabaseHelper;
import org.json.JSONException;
import org.json.JSONObject;

public class Contact {
    String did = null;
    String carrierAddress = null;

    /**
     * Creates a contact object from a CONTACTS_TABLE row.
     */
    public static Contact fromDatabaseCursor(Cursor cursor) {
        Contact contact = new Contact();
        contact.did = cursor.getString(cursor.getColumnIndex(DatabaseHelper.CONTACT_DID));
        contact.carrierAddress = cursor.getString(cursor.getColumnIndex(DatabaseHelper.CONTACT_CARRIER_ADDRESS));
        return contact;
    }

    public static Contact fromJSONObject(ContactNotifier notifier, JSONObject obj) {
        if (!obj.has("did") || !obj.has("carrierAddress"))
            return null;

        try {
            Contact contact = new Contact();
            contact.did = obj.getString("did");
            contact.carrierAddress = obj.getString("carrierAddress");
            return contact;
        }
        catch (JSONException e) {
            e.printStackTrace();
            return null;
        }
    }

    public JSONObject toJSONObject() {
        try {
            JSONObject obj = new JSONObject();
            obj.put("did", did);
            obj.put("carrierAddress", carrierAddress);
            return obj;
        }
        catch (JSONException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Sends a notification to the notification manager of a distant friend's Trinity instance.
     *
     * @param remoteNotification The notification content.
     *
     * @returns A promise that can be awaited and catched in case or error.
     */
    public void sendRemoteNotification(RemoteNotificationRequest remoteNotification) {
        // TODO
    }

    /**
     * Allow or disallow receiving remote notifications from this contact.
     *
     * @param allowNotifications True to receive notifications, false to reject them.
     */
    public void setAllowNotifications(boolean allowNotifications) {
        // TODO
    }

    /**
     * Tells whether the contact is currently online or not.
     */
    public OnlineStatus getOnlineStatus() {
        // TODO
        return OnlineStatus.OFFLINE;
    }
}
