package org.elastos.trinity.runtime.contactnotifier.db;

import android.database.Cursor;

public class ReceivedInvitation {
    public int iid; // Invitation unique ID
    public String did;
    public String carrierUserID;

    /**
     * Creates a ReceivedInvitation object from a RECEIVED_INVITATIONS row.
     */
    static ReceivedInvitation fromDatabaseCursor(Cursor cursor) {
        ReceivedInvitation invitation = new ReceivedInvitation();
        invitation.iid = cursor.getInt(cursor.getColumnIndex(DatabaseHelper.INVITATION_ID));
        invitation.did = cursor.getString(cursor.getColumnIndex(DatabaseHelper.DID));
        invitation.carrierUserID = cursor.getString(cursor.getColumnIndex(DatabaseHelper.CARRIER_USER_ID));
        return invitation;
    }
}
