
// TODO: When did sessions are ready, call ContactNotifier.getSharedInstance() as soon as a DID session starts, to initialize carrier early.

import ElastosCarrierSDK

public typealias onInvitationAccepted = (_ contact: Contact) -> Void
public typealias onStatusChanged = (_ contact: Contact, _ status: OnlineStatus) -> Void

public protocol OnInvitationAcceptedByUsListener {
    func onInvitationAccepted(contact: Contact)
    func onNotExistingInvitation()
    func onError(reason: String?)
}

public class ContactNotifier {
    public static let LOG_TAG = "ContactNotifier"

    private static let ONLINE_STATUS_MODE_PREF_KEY = "onlinestatusmode"
    private static let INVITATION_REQUESTS_MODE_PREF_KEY = "invitationrequestsmode"

    private static var instances = Dictionary<String, ContactNotifier>()  // Sandbox DIDs - One did session = one instance

    var didSessionDID: String
    var dbAdapter: CNDatabaseAdapter? = nil
    var carrierHelper: CarrierHelper? = nil

    private var onOnlineStatusChangedListeners = Array<onStatusChanged>()
    private var onInvitationAcceptedListeners = Array<onInvitationAccepted>()

    private init(didSessionDID: String) throws {
        self.didSessionDID = didSessionDID
        self.dbAdapter = CNDatabaseAdapter(notifier: self)
        self.carrierHelper = try CarrierHelper(notifier: self, didSessionDID: didSessionDID)

        Log.i(ContactNotifier.LOG_TAG, "Creating contact notifier instance for DID session \(didSessionDID)")

        listenToCarrierHelperEvents()
    }

    public static func getSharedInstance(did: String) throws -> ContactNotifier {
        if (instances.keys.contains(did)) {
            return instances[did]!
        }
        else {
            let instance = try ContactNotifier(didSessionDID: did)
            instances[did] = instance
            return instance
        }
    }

    /**
     * Returns DID-session specific carrier address for the current user. This is the address
     * that can be shared with future contacts so they can send invitation requests.
     *
     * @returns The currently active carrier address on which user can be reached by (future) contacts.
     */
    public func getCarrierAddress() throws -> String {
        return try carrierHelper!.getOrCreateAddress()
    }

    /**
     * Retrieve a previously added contact from his DID.
     *
     * @param did The contact's DID.
     */
    public func resolveContact(did: String?, completion: (_ contact: Contact?)->Void) {
        guard did != nil else {
            completion(nil)
            return
        }

        do {
            try dbAdapter!.getContactByDID(didSessionDID: didSessionDID, contactDID: did!, completion: completion)
        }
        catch {
            completion(nil)
        }
    }

    /**
     * Remove an existing contact. This contact stops seeing user's online status, can't send notification
     * any more.
     *
     * @param did DID of the contact to remove
     */
    public func removeContact(did: String) throws {
        resolveContact(did: did) { contact in
            guard contact != nil else {
                Log.w(ContactNotifier.LOG_TAG, "No contact found with DID \(did)")
                return
            }
            
            // Remove from carrier
            carrierHelper!.removeFriend(contactCarrierUserID: contact!.carrierUserID) { succeeded, reason in
                // Remove from database
                self.dbAdapter!.removeContact(didSessionDID: self.didSessionDID, contactDID: did)
            }
        }
    }

    /**
     * Listen to changes in contacts online status.
     *
     * @param onOnlineStatusChanged Called every time a contact becomes online or offline.
     */
    public func addOnlineStatusListener(_ onOnlineStatusChanged: @escaping onStatusChanged) {
        self.onOnlineStatusChangedListeners.append(onOnlineStatusChanged)
    }

    /**
     * Changes the online status mode, that decides if user's contacts can see his online status or not.
     *
     * @param onlineStatusMode Whether contacts can see user's online status or not.
     */
    public func setOnlineStatusMode(_ onlineStatusMode: OnlineStatusMode) {
        saveToPrefs(key: ContactNotifier.ONLINE_STATUS_MODE_PREF_KEY, value: onlineStatusMode.rawValue)
        carrierHelper!.setOnlineStatusMode(onlineStatusMode)
    }

    /**
     * Returns the current online status mode.
     */
    public func getOnlineStatusMode() -> OnlineStatusMode {
        let onlineStatusModeAsInt = getPrefsInt(key: ContactNotifier.ONLINE_STATUS_MODE_PREF_KEY, defaultValue: OnlineStatusMode.STATUS_IS_VISIBLE.rawValue)
        return OnlineStatusMode(rawValue: onlineStatusModeAsInt) ?? OnlineStatusMode.STATUS_IS_VISIBLE
    }

    /**
     * Sends a contact request to a peer. This contact will receive a notification about this request
     * and can choose to accept the invitation or not.
     *
     * In case the invitation is accepted, both peers become friends on carrier and in this contact notifier and can
     * start sending remote notifications to each other.
     *
     * Use invitation accepted listener API to get informed of changes.
     *
     * @param carrierAddress Target carrier address. Usually shared privately or publicly by the future contact.
     */
    public func sendInvitation(targetDID: String, carrierAddress: String) throws {
        carrierHelper!.sendInvitation(contactCarrierAddress: carrierAddress) { succeeded, reason in
            if succeeded {
                self.dbAdapter!.addSentInvitation(didSessionDID: self.didSessionDID, targetDID: targetDID, targetCarrierAddress: carrierAddress)
            }
        }
    }

    /**
     * Accepts an invitation sent by a remote peer. After accepting an invitation, a new contact is saved
     * with his did and carrier addresses. After that, this contact can be resolved as a contact object
     * from his did string.
     *
     * @param invitationId Received invitation id (database) that we're answering for.
     */
    public func acceptInvitation(invitationId: String, listener: OnInvitationAcceptedByUsListener) {
        // Retrieved the received invitation info from a given ID
        dbAdapter!.getReceivedInvitationById(didSessionDID: didSessionDID, invitationID: invitationId) { invitation in
            
            guard invitation != nil else {
                // No such invitation exists.
                listener.onNotExistingInvitation()
                return
            }

            // Accept the invitation on carrier
            do {
                carrierHelper!.acceptFriend(contactCarrierUserID: invitation!.carrierUserID) { succeeded, reason in
                    if succeeded {
                        // Add the contact to our database
                        Log.d(ContactNotifier.LOG_TAG, "Accepting a friend invitation. Adding contact locally")
                        do {
                            try self.dbAdapter!.addContact(didSessionDID: self.didSessionDID, did: invitation!.did, carrierUserID: invitation!.carrierUserID) { contact in
                                guard contact != nil else {
                                    listener.onError(reason: "Contact could not be added")
                                    return
                                }
                                
                                // Delete the pending invitation request
                                self.dbAdapter!.removeReceivedInvitation(didSessionDID: self.didSessionDID, invitationId: invitationId)

                                listener.onInvitationAccepted(contact: contact!)
                            }
                        }
                        catch (let error) {
                            listener.onError(reason: error.localizedDescription)
                        }
                    }
                    else {
                        listener.onError(reason: reason)
                    }
                }
            }
            catch (let error) {
                print(error)
            }
        }
    }

    /**
     * Rejects an invitation sent by a remote peer. This inviation is permanently deleted.
     * The invitation is rejected only locally. The sender is not aware of it.
     *
     * @param invitationId Received invitation id.
     */
    public func rejectInvitation(invitationId: String) {
        // Retrieved the received invitation info from a given ID
        dbAdapter!.getReceivedInvitationById(didSessionDID: didSessionDID, invitationID: invitationId) { invitation in
            guard invitation != nil else {
                // No such invitation exists.
                return
            }

            do {
                // Delete the invitation
                dbAdapter!.removeReceivedInvitation(didSessionDID: didSessionDID, invitationId: invitationId)
            }
            catch (let error) {
                print(error)
            }
        }
    }

    /**
     * Registers a listener to know when a previously sent invitation has been accepted.
     * Currently, it's only possible to know when an invitation was accepted, but not when
     * it was rejected.
     *
     * @param onInvitationAcceptedListener Called whenever an invitation has been accepted.
     */
    public func addOnInvitationAcceptedListener(onInvitationAcceptedListener: @escaping onInvitationAccepted) {
        self.onInvitationAcceptedListeners.append(onInvitationAcceptedListener)
    }

    private func notifyInvitationAcceptedByFriend(contact: Contact?) {
        guard onInvitationAcceptedListeners.count > 0 else {
            return
        }

        if contact != nil {
            for listener in onInvitationAcceptedListeners {
                listener(contact!)
            }
        }
    }

    /**
     * Configures the way invitations are accepted: manually, or automatically.
     *
     * @param mode Whether invitations should be accepted manually or automatically.
     */
    public func setInvitationRequestsMode(_ mode: InvitationRequestsMode) {
        saveToPrefs(key: ContactNotifier.INVITATION_REQUESTS_MODE_PREF_KEY, value: mode.rawValue)
    }

    /**
     * Returns the way invitations are accepted.
     */
    public func getInvitationRequestsMode() -> InvitationRequestsMode {
        let invitationRequestsModeAsInt = getPrefsInt(key: ContactNotifier.INVITATION_REQUESTS_MODE_PREF_KEY, defaultValue: InvitationRequestsMode.AUTO_ACCEPT.rawValue)
        return InvitationRequestsMode(rawValue: invitationRequestsModeAsInt) ?? InvitationRequestsMode.AUTO_ACCEPT
    }

    /**
     * DID Session sandboxed preferences
     */
    private func getUserDefaults() -> UserDefaults {
        return UserDefaults(suiteName: "CONTACT_NOTIFIER_PREFS_\(didSessionDID)")!
    }
    
    private func saveToPrefs(key: String, value: Int) {
        getUserDefaults().set(value, forKey: key)
    }
    
    private func getPrefsInt(key: String, defaultValue: Int) -> Int {
        if getUserDefaults().object(forKey: key) == nil {
            return defaultValue
        } else {
            return getUserDefaults().integer(forKey: key)
        }
    }
    
    private func listenToCarrierHelperEvents() {
        class CarrierEventHandler : OnCarrierEventListener {
            let notifier: ContactNotifier
            
            init(notifier: ContactNotifier) {
                self.notifier = notifier
            }
            
            func onFriendRequest(_ did: String, _ carrierUserId: String) {
                // Received an invitation from a potential contact.

                // If friend acceptation mode is set to automatic, we directly accept this invitation.
                // Otherwise, we let the contact notifier know this and it will send a notification to user.
                if (notifier.getInvitationRequestsMode() == .AUTO_ACCEPT) {
                    Log.i(ContactNotifier.LOG_TAG, "Auto-accepting friend invitation")

                    do {
                        notifier.carrierHelper!.acceptFriend(contactCarrierUserID: carrierUserId) { succeeded, reason in
                            if succeeded {
                                Log.d(ContactNotifier.LOG_TAG, "Adding contact locally")
                                try? self.notifier.dbAdapter!.addContact(didSessionDID: self.notifier.didSessionDID, did: did, carrierUserID: carrierUserId) { contact in
                                    let targetUrl = "https://scheme.elastos.org/viewfriend?did=\(did)"
                                    // TODO: resolve DID document, find firstname if any, and adjust the notification to include the firstname
                                    self.notifier.sendLocalNotification(relatedRemoteDID: did,key: "newcontact-\(did)", title: "Someone was just added as a new contact. Touch to view his/her profile.", url: targetUrl)
                                }
                            }
                        }
                    }
                    catch (let error) {
                        print(error)
                    }
                }
                else if (notifier.getInvitationRequestsMode() == InvitationRequestsMode.AUTO_REJECT) {
                    // Just forget this request, as user doesn't want to be bothered.
                }
                else {
                    // MANUALLY_ACCEPT - Manual approval
                    notifier.dbAdapter!.addReceivedInvitation(didSessionDID: notifier.didSessionDID, contactDID: did, contactCarrierUserId: carrierUserId) { invitationID in
                        let targetUrl = "https://scheme.elastos.org/viewfriendinvitation?did=(did)&invitationid=\(invitationID)"
                        // TODO: resolve DID document, find firstname if any, and adjust the notification to include the firstname
                        notifier.sendLocalNotification(relatedRemoteDID: did,key: "contactreq-\(did)", title: "Someone wants to add you as a contact. Touch to view more details.", url: targetUrl)
                    }
                }
            }
            
            func onFriendOnlineStatusChange(_ info: FriendInfo) {
                notifier.updateFriendOnlineStatus(info: info)
            }
            
            func onFriendPresenceStatusChange(_ info: FriendInfo) {
                notifier.updateFriendOnlineStatus(info: info)
            }
            
            func onRemoteNotification(_ friendId: String, _ remoteNotification: RemoteNotificationRequest) {
                // Try to resolve this friend id as a contact
                notifier.dbAdapter!.getContactByCarrierUserID(didSessionDID: notifier.didSessionDID, carrierUserID: friendId) { contact in
                    if contact != nil {
                        // Make sure this contact is not blocked by us
                        if !contact!.notificationsBlocked {
                            notifier.sendLocalNotification(relatedRemoteDID: contact!.did,key: remoteNotification.key!, title: remoteNotification.title!, url: remoteNotification.url)
                        }
                        else {
                            Log.w(ContactNotifier.LOG_TAG, "Not delivering remote notification because contact is blocked")
                        }
                    }
                    else {
                        Log.w(ContactNotifier.LOG_TAG, "Remote notification received from unknown contact. Friend ID = \(friendId)")
                    }
                }
            }
        }
        
        carrierHelper!.setCarrierEventListener(CarrierEventHandler(notifier: self))
    }

    private func updateFriendOnlineStatus(info: FriendInfo) {
        // Resolve the contact and make sure this friend wants to be seen.
        dbAdapter!.getContactByCarrierUserID(didSessionDID: didSessionDID, carrierUserID: info.userId!) { contact in
            if contact != nil {
                if info.presence == .None {
                    notifyOnlineStatusChanged(friendId: info.userId!, status: info.status)
                }
                else {
                    // User doesn't want to be seen
                    notifyOnlineStatusChanged(friendId: info.userId!, status: .Disconnected)
                }
            }
            else {
                // If we receive an online status information from a friend but this friend is not in our contact list yet,
                // AND this friend is in our sent invitations list, this means the friend has accepted our previous invitation.
                // This is the only way to get this information from carrier. So in such case, we can add hims as a real contact
                // now, and remove the sent invitation.
                findSentInvitationByFriendId(friendId: info.userId!) { invitation in
                    if invitation != nil {
                        try? handleFriendInvitationAccepted(invitation: invitation!, friendId: info.userId!)
                    }
                }
            }
        }
            
    }

    /**
     * When a friend accepts our invitation, the only way to know it is to match all friends userIds with our pending
     * invitation carrier addresses manually. Not convenient, but that's the only way for now.
     */
    private func findSentInvitationByFriendId(friendId: String, completion: ((SentInvitation?)->Void)) {
        dbAdapter!.getAllSentInvitations(didSessionDID: didSessionDID) { invitations in
            guard invitations != nil else {
                completion(nil)
                return
            }
            
            for invitation in invitations! {
                if invitation.carrierAddress != nil {
                    // Resolve user id associated with the invitation carrier address to be able to compare it
                    let invitationUserID = Carrier.getUserIdFromAddress(invitation.carrierAddress)
                    if invitationUserID != nil && invitationUserID == friendId {
                        // We found a pending invitation that matches the given friend.
                        completion(invitation)
                        return
                    }
                }
            }
            completion(nil)
        }
    }

    /**
     * A potential friend to whom we've sent an invitation earlier has accepted it. So we can now consider it as
     * a "contact".
     */
    private func handleFriendInvitationAccepted(invitation: SentInvitation, friendId: String) throws {
        Log.d(ContactNotifier.LOG_TAG, "Friend has accepted our invitation. Adding contact locally")

        // Add carrier friend as a contact
        try dbAdapter!.addContact(didSessionDID: didSessionDID, did: invitation.did, carrierUserID: friendId) { contact in
            // Delete the pending invitation request
            dbAdapter!.removeSentInvitationByAddress(didSessionDID: didSessionDID, carrierAddress: invitation.carrierAddress)

            // Notify the listeners
            notifyInvitationAcceptedByFriend(contact: contact)

            let targetUrl = "https://scheme.elastos.org/viewfrien?did=\(invitation.did)"
            // TODO: resolve DID document, find firstname if any, and adjust the notification to include the firstname
            sendLocalNotification(relatedRemoteDID: invitation.did,key: "friendaccepted-"+invitation.did, title: "Your friend has accepted your invitation. Touch to view details.", url: targetUrl)
        }
    }

    private func notifyOnlineStatusChanged(friendId: String, status: CarrierConnectionStatus) {
        if onOnlineStatusChangedListeners.count == 0 {
            return
        }

        // Resolve contact from friend ID
        dbAdapter!.getContactByCarrierUserID(didSessionDID: didSessionDID, carrierUserID: friendId) { contact in
            if contact != nil {
                for listener in onOnlineStatusChangedListeners {
                    listener(contact!, onlineStatusFromCarrierStatus(status))
                }
            }
        }
    }

    public func onlineStatusFromCarrierStatus(_ status: CarrierConnectionStatus) -> OnlineStatus{
        switch (status) {
        case .Connected:
            return .ONLINE
        case .Disconnected:
            return .OFFLINE
        }

        // No clean info - considered as offline.
        return .OFFLINE
    }

    /**
     * NOTE: As carrier can't really hide user's visibility from the user side, we use the "presence status" information
     * to let friends plugins know whether user wants to show his presence or not. This is not a ready away or online status.
     */
    public func onlineStatusModeToPresenceStatus(_ status: OnlineStatusMode) -> CarrierPresenceStatus {
        switch (status) {
        case .STATUS_IS_VISIBLE:
            return .None
        case .STATUS_IS_HIDDEN:
            return .Away
        }

        // No clean info - considered as hidden.
        return .Away
    }

    func sendLocalNotification(relatedRemoteDID: String, key: String, title: String, url: String?) {
        /* TODO WHEN NOTIF PLUGIN IS DONE let testNotif = NotificationRequest()
        testNotif.key = key
        testNotif.title = title
        testNotif.emitter = relatedRemoteDID
        testNotif.url = url
        do {
            // NOTE: appid can't be null because the notification manager uses it for several things.
            // TODO - NOT READY YET NotificationManager.getSharedInstance().sendNotification(testNotif, "system")
        } catch (let error) {
            print(error)
        }*/
    }
}
