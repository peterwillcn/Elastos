package org.elastos.trinity.runtime.contactnotifier.comm;

import android.util.Log;

import org.elastos.trinity.runtime.contactnotifier.ContactNotifier;
import org.json.JSONObject;

public class AcceptFriendCommand implements CarrierCommand {
    private CarrierHelper helper;
    private String contactCarrierUserID;
    private CarrierHelper.OnCommandExecuted completionListener;

    AcceptFriendCommand(CarrierHelper helper, String contactCarrierUserID, CarrierHelper.OnCommandExecuted completionListener) {
        this.helper = helper;
        this.contactCarrierUserID = contactCarrierUserID;
        this.completionListener = completionListener;
    }

    @Override
    public void executeCommand() {
        Log.i(ContactNotifier.LOG_TAG, "Executing accept friend command");
        try {
            helper.carrierInstance.acceptFriend(contactCarrierUserID);

            completionListener.onCommandExecuted(true, null);
        }
        catch (Exception e) {
            e.printStackTrace();
            completionListener.onCommandExecuted(false, e.getLocalizedMessage());
        }
    }
}