public class Contact {
    private var notifier: ContactNotifier

    public var did: String
    public var carrierUserID: String
    public var notificationsBlocked: boolean

    /**
     * Creates a contact object from a CONTACTS_TABLE row.
     */
    public static func fromDatabaseCursor(notifier: ContactNotifier, cursor: Cursor) {
        let contact = Contact()
        contact.notifier = notifier
        contact.did = cursor.getString(cursor.getColumnIndex(DatabaseHelper.DID))
        contact.carrierUserID = cursor.getString(cursor.getColumnIndex(DatabaseHelper.CARRIER_USER_ID))
        contact.notificationsBlocked = cursor.getInt(cursor.getColumnIndex(DatabaseHelper.NOTIFICATIONS_BLOCKED)) == 1
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
        notifier.carrierHelper.sendRemoteNotification(carrierUserID, notificationRequest, (succeeded, reason)->{
            // Nothing to do here for now, no matter if succeeded or not.
        });
    }

    /**
     * Allow or disallow receiving remote notifications from this contact.
     *
     * @param allowNotifications True to receive notifications, false to reject them.
     */
    public func setAllowNotifications(allowNotifications: boolean) {
        self.notificationsBlocked = !allowNotifications;
        notifier.dbAdapter.updateContactNotificationsBlocked(notifier.didSessionDID, did, this.notificationsBlocked)
    }

    /**
     * Tells whether the contact is currently online or not.
     */
    public func getOnlineStatus() -> OnlineStatus {
        return notifier.onlineStatusFromCarrierStatus(notifier.carrierHelper.getFriendOnlineStatus(carrierUserID))
    }
}
