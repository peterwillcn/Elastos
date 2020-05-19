import SQLite

public class Contact {
    private var notifier: ContactNotifier? = nil
    
    private static let didSessionDIDField = Expression<String>(CNDatabaseHelper.DID_SESSION_DID)
    private static let didField = Expression<String>(CNDatabaseHelper.DID)
    private static let carrierUserIdField = Expression<String>(CNDatabaseHelper.CARRIER_USER_ID)
    private static let notificationsBlockedField = Expression<Bool>(CNDatabaseHelper.NOTIFICATIONS_BLOCKED)
    private static let addedDateField = Expression<Int64>(CNDatabaseHelper.ADDED_DATE)

    public var did: String = ""
    public var carrierUserID: String = ""
    public var notificationsBlocked: Bool = false
    
    private init() {
    }

    /**
     * Creates a contact object from a CONTACTS_TABLE row.
     */
    public static func fromDatabaseRow(notifier: ContactNotifier, row: Row) -> Contact {
        let contact = Contact()
        contact.notifier = notifier
        contact.did = row[didField]
        contact.carrierUserID = row[carrierUserIdField]
        contact.notificationsBlocked = row[notificationsBlockedField]
        return contact
    }

    public func toJSONObject() -> NSDictionary {
        let obj = NSMutableDictionary()
        obj["did"] = did
        obj["carrierUserID"] = carrierUserID
        obj["notificationsBlocked"] = notificationsBlocked
        return obj
    }

    /**
     * Sends a notification to the notification manager of a distant friend's Trinity instance.
     *
     * @param notificationRequest The notification content.
     */
    public func sendRemoteNotification(notificationRequest: RemoteNotificationRequest) {
        notifier!.carrierHelper!.sendRemoteNotification(contactCarrierUserID: carrierUserID, notificationRequest: notificationRequest) { succeeded, reason in
            // Nothing to do here for now, no matter if succeeded or not.
        }
    }

    /**
     * Allow or disallow receiving remote notifications from this contact.
     *
     * @param allowNotifications True to receive notifications, false to reject them.
     */
    public func setAllowNotifications(_ allowNotifications: Bool) {
        self.notificationsBlocked = !allowNotifications
        notifier!.dbAdapter!.updateContactNotificationsBlocked(didSessionDID: notifier!.didSessionDID, did: did, shouldBlockNotifications: notificationsBlocked)
    }

    /**
     * Tells whether the contact is currently online or not.
     */
    public func getOnlineStatus() -> OnlineStatus {
        return notifier!.onlineStatusFromCarrierStatus(notifier!.carrierHelper!.getFriendOnlineStatus(friendId: carrierUserID))
    }
}
