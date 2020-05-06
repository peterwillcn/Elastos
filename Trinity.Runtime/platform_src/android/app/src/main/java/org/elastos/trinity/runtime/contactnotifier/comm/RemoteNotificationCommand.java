package org.elastos.trinity.runtime.contactnotifier.comm;

import android.util.Log;

import org.elastos.trinity.runtime.contactnotifier.ContactNotifier;
import org.elastos.trinity.runtime.contactnotifier.RemoteNotificationRequest;
import org.json.JSONObject;

public class RemoteNotificationCommand implements CarrierCommand {
    private CarrierHelper helper;
    private String contactCarrierUserID;
    private RemoteNotificationRequest notificationRequest;
    private CarrierHelper.OnCommandExecuted completionListener;

    RemoteNotificationCommand(CarrierHelper helper, String contactCarrierUserID, RemoteNotificationRequest notificationRequest, CarrierHelper.OnCommandExecuted completionListener) {
        this.helper = helper;
        this.contactCarrierUserID = contactCarrierUserID;
        this.notificationRequest = notificationRequest;
        this.completionListener = completionListener;
    }

    @Override
    public void executeCommand() {
        Log.i(ContactNotifier.LOG_TAG, "Executing remote contact notification command");
        try {
            // Package our remote command
            JSONObject request = new JSONObject();
            request.put("command", "remotenotification");
            request.put("source", "contact_notifier_plugin"); // purely informative
            request.put("key", notificationRequest.key);
            request.put("title", notificationRequest.title);

            if (notificationRequest.url != null)
                request.put("url", notificationRequest.url);

            helper.carrierInstance.sendFriendMessage(contactCarrierUserID, request.toString());

            completionListener.onCommandExecuted(true, null);
        }
        catch (Exception e) {
            e.printStackTrace();
            completionListener.onCommandExecuted(false, e.getLocalizedMessage());
        }
    }
}