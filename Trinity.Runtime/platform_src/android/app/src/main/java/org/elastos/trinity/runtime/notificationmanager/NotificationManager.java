package org.elastos.trinity.runtime.notificationmanager;

import android.content.Context;
import android.util.Log;
import android.widget.Toast;

import org.elastos.trinity.runtime.notificationmanager.db.DatabaseAdapter;

import java.util.ArrayList;


public class NotificationManager {
    public static final String LOG_TAG = "NotificationManager";

    private Context context;
    DatabaseAdapter dbAdapter;

    private static NotificationManager instance;

    private ArrayList<NotificationListener> onNotificationListeners = new ArrayList<>();

    public interface NotificationListener {
        void onNotification(Notification notification);
    }

    public NotificationManager(Context context) {
        this.context = context;
        this.dbAdapter = new DatabaseAdapter(this, context);

        Log.i(LOG_TAG, "Creating NotificationManager ");

        NotificationManager.instance = this;
    }

    public static NotificationManager getSharedInstance() {
        return instance;
    }

    /**
     * Remove an existing notification.
     *
     * @param notificationId Notification ID to remove
     */
    public void clearNotification(String notificationId) throws Exception {
        dbAdapter.clearNotification(notificationId);
    }

    /**
     * Get all notifications.
     */
    public ArrayList<Notification> getNotifications() throws Exception {
        return dbAdapter.getNotifications();
    }

    /**
     * Sends a contact request to a peer. This contact will receive a notification about this request
     * and can choose to accept the invitation or not.
     *
     * In case the invitation is accepted, both peers become friends on carrier and in this contact notifier and can
     * start sending remote notifications to each other.
     *
     * Use invitation accepted listener API to get informed of changes.
     *
     * @param notificationRequest Target carrier address. Usually shared privately or publicly by the future contact.
     */
    public void sendNotification(NotificationRequest notificationRequest, String appId) throws Exception {
        Notification notification = dbAdapter.addNotification(notificationRequest.key, notificationRequest.title,
                                    notificationRequest.url, notificationRequest.emitter, appId);
        notifyNotification(notification);

        Toast.makeText(this.context,notificationRequest.title, Toast.LENGTH_SHORT).show();
    }

    /**
     * Registers a listener to know when a previously sent invitation has been accepted.
     * Currently, it's only possible to know when an invitation was accepted, but not when
     * it was rejected.
     *
     * @param onNotificationListener Called whenever an notification has been sent.
     */
    public void setNotificationListener(NotificationListener onNotificationListener) {
        this.onNotificationListeners.add(onNotificationListener);
    }

    private void notifyNotification(Notification notification) {
        if (onNotificationListeners.size() == 0)
            return;

        if (notification != null) {
            for (NotificationListener listener : onNotificationListeners) {
                listener.onNotification(notification);
            }
        }
    }
}
