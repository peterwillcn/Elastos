package org.elastos.trinity.runtime.contactnotifier.comm;

import android.util.Log;

import org.elastos.carrier.PresenceStatus;
import org.elastos.trinity.runtime.contactnotifier.ContactNotifier;
import org.elastos.trinity.runtime.contactnotifier.RemoteNotificationRequest;
import org.json.JSONObject;

public class SetPresenceCommand implements CarrierCommand {
    private CarrierHelper helper;
    private PresenceStatus status;

    SetPresenceCommand(CarrierHelper helper, PresenceStatus status) {
        this.helper = helper;
        this.status = status;
    }

    @Override
    public void executeCommand() {
        Log.i(ContactNotifier.LOG_TAG, "Executing presence status command");
        try {
            helper.carrierInstance.setPresence(status);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}