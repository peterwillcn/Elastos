
// TODO: When did sessions are ready, call ContactNotifier.getSharedInstance() as soon as a DID session starts, to initialize carrier early.

public class ContactNotifier {
    public static let LOG_TAG = "ContactNotifier"

    private static let ONLINE_STATUS_MODE_PREF_KEY = "onlinestatusmode"
    private static let INVITATION_REQUESTS_MODE_PREF_KEY = "invitationrequestsmode"

    private static let instances = Dictionary<String, ContactNotifier>()  // Sandbox DIDs - One did session = one instance

    var didSessionDID: String
    var dbAdapter: DatabaseAdapter
    var carrierHelper: CarrierHelper

    private let onOnlineStatusChangedListeners = Array<OnOnlineStatusListener>()
    private let onInvitationAcceptedListeners = Array<OnInvitationAcceptedByFriendListener>()

    typealias onInvitationAccepted = (_ contact: Contact) -> Void

    public protocol OnInvitationAcceptedByUsListener {
        func onInvitationAccepted(contact: Contact)
        func onNotExistingInvitation()
        func onError(reason: String)
    }

    typealias onStatusChanged = (_ contact: Contact, _ status: OnlineStatus) -> Void

    private init(didSessionDID: String) throws {
        self.didSessionDID = didSessionDID
        self.dbAdapter = DatabaseAdapter(self)
        self.carrierHelper = CarrierHelper(self, didSessionDID)

        Log.i(LOG_TAG, "Creating contact notifier instance for DID session \(didSessionDID)")

        listenToCarrierHelperEvents()
    }

    public static func getSharedInstance(did: String) throws -> ContactNotifier {
        if (instances.containsKey(did)) {
            return instances.get(did)
        }
        else {
            let instance = ContactNotifier(did)
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
        return carrierHelper.getOrCreateAddress()
    }

    /**
     * Retrieve a previously added contact from his DID.
     *
     * @param did The contact's DID.
     */
    public func resolveContact(did: String) -> Contact {
        guard did != nil else {
            return nil
        }

        return dbAdapter.getContactByDID(didSessionDID, did)
    }

    /**
     * Remove an existing contact. This contact stops seeing user's online status, can't send notification
     * any more.
     *
     * @param did DID of the contact to remove
     */
    public func removeContact(did: String) throws {
        let contact = resolveContact(did)
        guard contact != nil else {
            throw "No contact found with DID \(did)"
        }

        // Remove from carrier
        carrierHelper.removeFriend(contact.carrierUserID, (succeeded, reason)->{
            // Remove from database
            dbAdapter.removeContact(didSessionDID, did)
        })
    }

    /**
     * Listen to changes in contacts online status.
     *
     * @param onOnlineStatusChanged Called every time a contact becomes online or offline.
     */
    public func addOnlineStatusListener(onOnlineStatusChanged: OnOnlineStatusListener) {
        self.onOnlineStatusChangedListeners.add(onOnlineStatusChanged)
    }

    /**
     * Changes the online status mode, that decides if user's contacts can see his online status or not.
     *
     * @param onlineStatusMode Whether contacts can see user's online status or not.
     */
    public func setOnlineStatusMode(onlineStatusMode: OnlineStatusMode) {
        getPrefs().edit().putInt(ONLINE_STATUS_MODE_PREF_KEY, onlineStatusMode.mValue).apply();
        carrierHelper.setOnlineStatusMode(onlineStatusMode);
    }

    /**
     * Returns the current online status mode.
     */
    public func getOnlineStatusMode() -> OnlineStatusMode {
        int onlineStatusModeAsInt = getPrefs().getInt(ONLINE_STATUS_MODE_PREF_KEY, OnlineStatusMode.STATUS_IS_VISIBLE.mValue);
        return OnlineStatusMode.fromValue(onlineStatusModeAsInt);
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
        carrierHelper.sendInvitation(carrierAddress, (succeeded, reason)->{
            if (succeeded) {
                dbAdapter.addSentInvitation(didSessionDID, targetDID, carrierAddress)
            }
        })
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
        let invitation = dbAdapter.getReceivedInvitationById(didSessionDID, invitationId)
        guard invitation != nil else {
            // No such invitation exists.
            listener.onNotExistingInvitation()
            return
        }

        // Accept the invitation on carrier
        do {
            carrierHelper.acceptFriend(invitation.carrierUserID, (succeeded, reason)->{
                if (succeeded) {
                    // Add the contact to our database
                    Log.d(LOG_TAG, "Accepting a friend invitation. Adding contact locally")
                    let contact = dbAdapter.addContact(didSessionDID, invitation.did, invitation.carrierUserID)

                    // Delete the pending invitation request
                    dbAdapter.removeReceivedInvitation(didSessionDID, invitationId)

                    listener.onInvitationAccepted(contact)
                }
                else {
                    listener.onError(reason)
                }
            });
        }
        catch (let error) {
            print(error)
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
        let invitation = dbAdapter.getReceivedInvitationById(didSessionDID, invitationId)
        guard invitation != nil else {
            // No such invitation exists.
            return
        }

        do {
            // Delete the invitation
            dbAdapter.removeReceivedInvitation(didSessionDID, invitationId)
        }
        catch (let error) {
            print(error)
        }
    }

    /**
     * Registers a listener to know when a previously sent invitation has been accepted.
     * Currently, it's only possible to know when an invitation was accepted, but not when
     * it was rejected.
     *
     * @param onInvitationAcceptedListener Called whenever an invitation has been accepted.
     */
    public func addOnInvitationAcceptedListener(onInvitationAcceptedListener: OnInvitationAcceptedByFriendListener) {
        self.onInvitationAcceptedListeners.add(onInvitationAcceptedListener)
    }

    private func notifyInvitationAcceptedByFriend(contact: Contact) {
        guard onInvitationAcceptedListeners.size() > 0 else {
            return
        }

        if contact != nil {
            for listener in onInvitationAcceptedListeners {
                listener.onInvitationAccepted(contact)
            }
        }
    }

    /**
     * Configures the way invitations are accepted: manually, or automatically.
     *
     * @param mode Whether invitations should be accepted manually or automatically.
     */
    public func setInvitationRequestsMode(mode: InvitationRequestsMode) {
        getPrefs().edit().putInt(INVITATION_REQUESTS_MODE_PREF_KEY, mode.mValue).apply()
    }

    /**
     * Returns the way invitations are accepted.
     */
    public func getInvitationRequestsMode() -> InvitationRequestsMode {
        int invitationRequestsModeAsInt = getPrefs().getInt(INVITATION_REQUESTS_MODE_PREF_KEY, InvitationRequestsMode.AUTO_ACCEPT.mValue)
        return InvitationRequestsMode(rawValue: invitationRequestsModeAsInt)
    }

    /**
     * DID Session sandboxed preferences
     */
    private func getPrefs() -> SharedPreferences {
        return context.getSharedPreferences("CONTACT_NOTIFIER_PREFS_"+didSessionDID, Context.MODE_PRIVATE)
    }

    private func listenToCarrierHelperEvents() {
        class CarrierEventListener : OnCarrierEventListener {
            
        }
        
        carrierHelper.setCarrierEventListener(new CarrierHelper.OnCarrierEventListener() {
            @Override
            public void onFriendRequest(String did, String carrierUserId) {
                // Received an invitation from a potential contact.

                // If friend acceptation mode is set to automatic, we directly accept this invitation.
                // Otherwise, we let the contact notifier know this and it will send a notification to user.
                if (getInvitationRequestsMode() == InvitationRequestsMode.AUTO_ACCEPT) {
                    Log.i(ContactNotifier.LOG_TAG, "Auto-accepting friend invitation");

                    try {
                        carrierHelper.acceptFriend(carrierUserId, (succeeded, reason)->{
                            if (succeeded) {
                                Log.d(LOG_TAG, "Adding contact locally");
                                dbAdapter.addContact(didSessionDID, did, carrierUserId);
                                String targetUrl = "https://scheme.elastos.org/viewfriend?did="+did;
                                // TODO: resolve DID document, find firstname if any, and adjust the notification to include the firstname
                                sendLocalNotification(did,"newcontact-"+did, "Someone was just added as a new contact. Touch to view his/her profile.", targetUrl);
                            }
                        });
                    }
                    catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                else if (getInvitationRequestsMode() == InvitationRequestsMode.AUTO_REJECT) {
                    // Just forget this request, as user doesn't want to be bothered.
                }
                else {
                    // MANUALLY_ACCEPT - Manual approval
                    long invitationID = dbAdapter.addReceivedInvitation(didSessionDID, did, carrierUserId);
                    String targetUrl = "https://scheme.elastos.org/viewfriendinvitation?did="+did+"&invitationid="+invitationID;
                    // TODO: resolve DID document, find firstname if any, and adjust the notification to include the firstname
                    sendLocalNotification(did,"contactreq-"+did, "Someone wants to add you as a contact. Touch to view more details.", targetUrl);
                }
            }

            @Override
            public void onFriendOnlineStatusChange(FriendInfo info) {
                updateFriendOnlineStatus(info);
            }

            @Override
            public void onFriendPresenceStatusChange(FriendInfo info) {
                updateFriendOnlineStatus(info);
            }

            @Override
            public void onRemoteNotification(String friendId, RemoteNotificationRequest remoteNotification) {
                // Try to resolve this friend id as a contact
                Contact contact = dbAdapter.getContactByCarrierUserID(didSessionDID, friendId);
                if (contact != null) {
                    // Make sure this contact is not blocked by us
                    if (!contact.notificationsBlocked) {
                        sendLocalNotification(contact.did,remoteNotification.key, remoteNotification.title, remoteNotification.url);
                    }
                    else {
                        Log.w(ContactNotifier.LOG_TAG, "Not delivering remote notification because contact is blocked");
                    }
                }
                else {
                    Log.w(ContactNotifier.LOG_TAG, "Remote notification received from unknown contact. Friend ID = "+friendId);
                }
            }
        });
    }

    private func updateFriendOnlineStatus(info: FriendInfo) {
        // Resolve the contact and make sure this friend wants to be seen.
        let contact = dbAdapter.getContactByCarrierUserID(didSessionDID, info.getUserId());
        if contact != nil {
            if (info.getPresence() == PresenceStatus.None) {
                notifyOnlineStatusChanged(info.getUserId(), info.getConnectionStatus());
            }
            else {
                // User doesn't want to be seen
                notifyOnlineStatusChanged(info.getUserId(), ConnectionStatus.Disconnected);
            }
        }
        else {
            // If we receive an online status information from a friend but this friend is not in our contact list yet,
            // AND this friend is in our sent invitations list, this means the friend has accepted our previous invitation.
            // This is the only way to get this information from carrier. So in such case, we can add hims as a real contact
            // now, and remove the sent invitation.
            SentInvitation invitation = findSentInvitationByFriendId(info.getUserId());
            if (invitation != null) {
                handleFriendInvitationAccepted(invitation, info.getUserId());
            }
        }
    }

    /**
     * When a friend accepts our invitation, the only way to know it is to match all friends userIds with our pending
     * invitation carrier addresses manually. Not convenient, but that's the only way for now.
     */
    private func findSentInvitationByFriendId(friendId: String) -> SentInvitation {
        ArrayList<SentInvitation> invitations = dbAdapter.getAllSentInvitations(didSessionDID);
        for invitation in invitations {
            if (invitation.carrierAddress != nil) {
                // Resolve user id associated with the invitation carrier address to be able to compare it
                let invitationUserID = Carrier.getIdFromAddress(invitation.carrierAddress)
                if invitationUserID != nil && invitationUserID == friendId {
                    // We found a pending invitation that matches the given friend.
                    return invitation;
                }
            }
        }
        return null;
    }

    /**
     * A potential friend to whom we've sent an invitation earlier has accepted it. So we can now consider it as
     * a "contact".
     */
    private func handleFriendInvitationAccepted(invitation: SentInvitation, friendId: String) {
        Log.d(LOG_TAG, "Friend has accepted our invitation. Adding contact locally")

        // Add carrier friend as a contact
        let contact = dbAdapter.addContact(didSessionDID, invitation.did, friendId)

        // Delete the pending invitation request
        dbAdapter.removeSentInvitationByAddress(didSessionDID, invitation.carrierAddress);

        // Notify the listeners
        notifyInvitationAcceptedByFriend(contact)

        let targetUrl = "https://scheme.elastos.org/viewfrien?did=\(invitation.did)"
        // TODO: resolve DID document, find firstname if any, and adjust the notification to include the firstname
        sendLocalNotification(invitation.did,"friendaccepted-"+invitation.did, "Your friend has accepted your invitation. Touch to view details.", targetUrl);
    }

    private func notifyOnlineStatusChanged(friendId: String, status: ConnectionStatus) {
        if onOnlineStatusChangedListeners.size() == 0 {
            return
        }

        // Resolve contact from friend ID
        if let contact = dbAdapter.getContactByCarrierUserID(didSessionDID, friendId) {
            for listener : onOnlineStatusChangedListeners {
                listener.onStatusChanged(contact, onlineStatusFromCarrierStatus(status))
            }
        }
    }

    public func onlineStatusFromCarrierStatus(status: ConnectionStatus) -> OnlineStatus{
        switch (status) {
            case Connected:
                return OnlineStatus.ONLINE
            case Disconnected:
                return OnlineStatus.OFFLINE
        }

        // No clean info - considered as offline.
        return OnlineStatus.OFFLINE
    }

    /**
     * NOTE: As carrier can't really hide user's visibility from the user side, we use the "presence status" information
     * to let friends plugins know whether user wants to show his presence or not. This is not a ready away or online status.
     */
    public func onlineStatusModeToPresenceStatus(status: OnlineStatusMode) -> PresenceStatus {
        switch (status) {
            case STATUS_IS_VISIBLE:
                return PresenceStatus.None
            case STATUS_IS_HIDDEN:
                return PresenceStatus.Away
        }

        // No clean info - considered as hidden.
        return PresenceStatus.Away
    }

    func sendLocalNotification(relatedRemoteDID: String, key: String, title: String, url: String) {
        let testNotif = NotificationRequest()
        testNotif.key = key
        testNotif.title = title
        testNotif.emitter = relatedRemoteDID
        testNotif.url = url
        do {
            // NOTE: appid can't be null because the notification manager uses it for several things.
            // TODO - NOT READY YET NotificationManager.getSharedInstance().sendNotification(testNotif, "system")
        } catch (let error) {
            print(e)
        }
    }
}
