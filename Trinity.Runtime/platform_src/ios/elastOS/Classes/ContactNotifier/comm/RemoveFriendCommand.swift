package org.elastos.trinity.runtime.contactnotifier.comm;

import android.util.Log;

import org.elastos.trinity.runtime.contactnotifier.ContactNotifier;
import org.elastos.trinity.runtime.contactnotifier.RemoteNotificationRequest;
import org.json.JSONObject;

public class RemoveFriendCommand implements CarrierCommand {
    private CarrierHelper helper;
    private String contactCarrierUserID;
    private CarrierHelper.OnCommandExecuted completionListener;

    RemoveFriendCommand(CarrierHelper helper, String contactCarrierUserID, CarrierHelper.OnCommandExecuted completionListener) {
        this.helper = helper;
        this.contactCarrierUserID = contactCarrierUserID;
        this.completionListener = completionListener;
    }

    @Override
    public void executeCommand() {
        Log.i(ContactNotifier.LOG_TAG, "Executing remove friend command");
        try {
            helper.carrierInstance.removeFriend(contactCarrierUserID);

            completionListener.onCommandExecuted(true, null);
        }
        catch (Exception e) {
            e.printStackTrace();
            completionListener.onCommandExecuted(false, e.getLocalizedMessage());
        }
    }
}