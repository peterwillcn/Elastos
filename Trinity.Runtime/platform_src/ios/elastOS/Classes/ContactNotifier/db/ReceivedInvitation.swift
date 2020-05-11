public class ReceivedInvitation {
    public var iid: Int // Invitation unique ID
    public var did: String
    public var carrierUserID: String

    /**
     * Creates a ReceivedInvitation object from a RECEIVED_INVITATIONS row.
     */
    static func fromDatabaseCursor(cursor: Cursor) -> ReceivedInvitation {
        let invitation = ReceivedInvitation()
        invitation.iid = cursor.getInt(cursor.getColumnIndex(DatabaseHelper.INVITATION_ID));
        invitation.did = cursor.getString(cursor.getColumnIndex(DatabaseHelper.DID));
        invitation.carrierUserID = cursor.getString(cursor.getColumnIndex(DatabaseHelper.CARRIER_USER_ID));
        return invitation
    }
}
