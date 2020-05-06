package org.elastos.trinity.runtime.contactnotifier.db;

import android.database.Cursor;

public class SentInvitation {
    public String did;
    public String carrierAddress;

    /**
     * Creates a SentInvitation object from a SENT_INVITATIONS row.
     */
    static SentInvitation fromDatabaseCursor(Cursor cursor) {
        SentInvitation invitation = new SentInvitation();
        invitation.did = cursor.getString(cursor.getColumnIndex(DatabaseHelper.DID));
        invitation.carrierAddress = cursor.getString(cursor.getColumnIndex(DatabaseHelper.CARRIER_ADDRESS));
        return invitation;
    }
}
