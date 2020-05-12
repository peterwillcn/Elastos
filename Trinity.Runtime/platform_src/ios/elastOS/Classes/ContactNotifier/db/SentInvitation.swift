import SQLite

public class SentInvitation {
    public var did: String
    public var carrierAddress: String
    
    public static let didField = Expression<String>(CNDatabaseHelper.DID)
    public static let carrierUserIdField = Expression<String>(CNDatabaseHelper.CARRIER_USER_ID)
    public static let carrierAddressField = Expression<String>(CNDatabaseHelper.CARRIER_ADDRESS)
    
    init() {
        did = ""
        carrierAddress = ""
    }

    /**
     * Creates a SentInvitation object from a SENT_INVITATIONS row.
     */
    static func fromDatabaseCursor(row: Row) -> SentInvitation {
        let invitation = SentInvitation()
        invitation.did = row[didField]
        invitation.carrierAddress = row[carrierAddressField]
        return invitation
    }
}
