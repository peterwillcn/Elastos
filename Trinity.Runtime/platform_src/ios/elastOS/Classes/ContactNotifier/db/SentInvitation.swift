public class SentInvitation {
    public var did: String
    public var carrierAddress: String
    
    init() {
        did = ""
        carrierAddress = ""
    }

    /**
     * Creates a SentInvitation object from a SENT_INVITATIONS row.
     */
    static func fromDatabaseCursor(Cursor cursor) -> SentInvitation {
        let invitation = SentInvitation()
        invitation.did = cursor.getString(cursor.getColumnIndex(DatabaseHelper.DID));
        invitation.carrierAddress = cursor.getString(cursor.getColumnIndex(DatabaseHelper.CARRIER_ADDRESS));
        return invitation
    }
}
