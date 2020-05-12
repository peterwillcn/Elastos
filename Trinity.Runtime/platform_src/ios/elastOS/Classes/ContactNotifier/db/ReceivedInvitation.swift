import SQLite

public class ReceivedInvitation {
    public var iid: Int // Invitation unique ID
    public var did: String
    public var carrierUserID: String
    
    public static let invitationIdField = Expression<Int64>(CNDatabaseHelper.INVITATION_ID)
    public static let didField = Expression<String>(CNDatabaseHelper.DID)
    public static let carrierUserIdField = Expression<String>(CNDatabaseHelper.CARRIER_USER_ID)
    
    init() {
        iid = -1
        did = ""
        carrierUserID = ""
    }

    /**
     * Creates a ReceivedInvitation object from a RECEIVED_INVITATIONS row.
     */
    static func fromDatabaseCursor(row: Row) -> ReceivedInvitation {
        let invitation = ReceivedInvitation()
        invitation.iid = Int(row[invitationIdField])
        invitation.did = row[didField]
        invitation.carrierUserID = row[carrierUserIdField]
        return invitation
    }
}
