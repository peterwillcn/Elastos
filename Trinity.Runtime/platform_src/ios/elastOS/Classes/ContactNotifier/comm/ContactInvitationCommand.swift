package org.elastos.trinity.runtime.contactnotifier.comm;

import android.util.Log;

import org.elastos.trinity.runtime.contactnotifier.ContactNotifier;
import org.json.JSONObject;

public class ContactInvitationCommand implements CarrierCommand {
    private CarrierHelper helper;
    private String contactCarrierAddress;
    private CarrierHelper.OnCommandExecuted completionListener;

    ContactInvitationCommand(CarrierHelper helper, String contactCarrierAddress, CarrierHelper.OnCommandExecuted completionListener) {
        this.helper = helper;
        this.contactCarrierAddress = contactCarrierAddress;
        this.completionListener = completionListener;
    }

    @Override
    public void executeCommand() {
        Log.i(ContactNotifier.LOG_TAG, "Executing contact invitation command");
        try {
            // Let the receiver know who we are
            JSONObject invitationRequest = new JSONObject();
            invitationRequest.put("did", helper.didSessionDID);
            invitationRequest.put("source", "contact_notifier_plugin"); // purely informative

            helper.carrierInstance.addFriend(contactCarrierAddress, invitationRequest.toString());

            completionListener.onCommandExecuted(true, null);
        }
        catch (Exception e) {
            e.printStackTrace();
            completionListener.onCommandExecuted(false, e.getLocalizedMessage());
        }
    }
}