package org.elastos.trinity.runtime.contactnotifier;

import android.content.Context;
import android.content.SharedPreferences;
import android.util.Log;

import org.elastos.carrier.Carrier;
import org.elastos.carrier.ConnectionStatus;
import org.elastos.carrier.FriendInfo;
import org.elastos.carrier.PresenceStatus;
import org.elastos.carrier.exceptions.CarrierException;
import org.elastos.trinity.runtime.AppManager;
import org.elastos.trinity.runtime.contactnotifier.comm.CarrierHelper;
import org.elastos.trinity.runtime.contactnotifier.db.DatabaseAdapter;
import org.elastos.trinity.runtime.contactnotifier.db.SentInvitation;

import java.util.ArrayList;
import java.util.HashMap;

// TODO: PROBLEM - CARRIER NOT READY WHEN ELASTOS STARTS AND DIRECTLY ADDING A FRIEND
// TODO: PROBLEM - SHOULD INITIALIZE THE NOTIFIER AT ELASTOS START, NOT AT FIRST API CALL, TO SAVE TIME AND START LISTENING

public class ContactNotifier {
    public static final String LOG_TAG = "ContactNotifier";

    private static final String ONLINE_STATUS_MODE_PREF_KEY = "onlinestatusmode";
    private static final String INVITATION_REQUESTS_MODE_PREF_KEY = "invitationrequestsmode";

    private static HashMap<String, ContactNotifier> instances = new HashMap<>(); // Sandbox DIDs - One did session = one instance

    private Context context;
    String didSessionDID;
    DatabaseAdapter dbAdapter;
    CarrierHelper carrierHelper;

    private ArrayList<OnOnlineStatusListener> onOnlineStatusChangedListeners = new ArrayList<>();
    private ArrayList<OnInvitationAcceptedListener> onInvitationAcceptedListeners = new ArrayList<>();

    public interface OnInvitationAcceptedListener {
        void onInvitationAccepted(Contact contact);
    }

    public interface OnOnlineStatusListener {
        void onStatusChanged(Contact contact, OnlineStatus status);
    }

    private ContactNotifier(Context context, String didSessionDID) throws CarrierException {
        this.context = context;
        this.didSessionDID = didSessionDID;
        this.dbAdapter = new DatabaseAdapter(this, context);
        this.carrierHelper = new CarrierHelper(this, didSessionDID, context);

        listenToCarrierHelperEvents();
    }

    public static ContactNotifier getSharedInstance(Context context, String did) throws CarrierException {
        if (instances.containsKey(did))
            return instances.get(did);
        else {
            ContactNotifier instance = new ContactNotifier(context, did);
            instances.put(did, instance);
            return instance;
        }
    }

    /**
     * Returns DID-session specific carrier address for the current user. This is the address
     * that can be shared with future contacts so they can send invitation requests.
     *
     * @returns The currently active carrier address on which user can be reached by (future) contacts.
     */
    public String getCarrierAddress() throws CarrierException {
        return carrierHelper.getOrCreateAddress();
    }

    /**
     * Retrieve a previously added contact from his DID.
     *
     * @param did The contact's DID.
     */
    public Contact resolveContact(String did) {
        if (did == null)
            return null;

        return dbAdapter.getContactByDID(didSessionDID, did);
    }

    /**
     * Remove an existing contact. This contact stops seeing user's online status, can't send notification
     * any more.
     *
     * @param did DID of the contact to remove
     */
    public void removeContact(String did) {
        dbAdapter.removeContact(didSessionDID, did);
    }

    /**
     * Listen to changes in contacts online status.
     *
     * @param onOnlineStatusChanged Called every time a contact becomes online or offline.
     */
    public void addOnlineStatusListener(OnOnlineStatusListener onOnlineStatusChanged) {
        this.onOnlineStatusChangedListeners.add(onOnlineStatusChanged);
    }

    /**
     * Changes the online status mode, that decides if user's contacts can see his online status or not.
     *
     * @param onlineStatusMode Whether contacts can see user's online status or not.
     */
    public void setOnlineStatusMode(OnlineStatusMode onlineStatusMode) {
        getPrefs().edit().putInt(ONLINE_STATUS_MODE_PREF_KEY, onlineStatusMode.mValue).apply();
        carrierHelper.setOnlineStatusMode(onlineStatusMode);
    }

    /**
     * Returns the current online status mode.
     */
    public OnlineStatusMode getOnlineStatusMode() {
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
    public void sendInvitation(String targetDID, String carrierAddress) throws Exception {
        carrierHelper.sendInvitation(carrierAddress, (succeeded, reason)->{
            if (succeeded) {
                dbAdapter.addSentInvitation(didSessionDID, targetDID, carrierAddress);
            }
        });
    }

    /**
     * Accepts an invitation sent by a remote peer. After accepting an invitation, a new contact is saved
     * with his did and carrier addresses. After that, this contact can be resolved as a contact object
     * from his did string.
     *
     * @param invitationId Received invitation id that we're answering for.
     *
     * @returns The generated contact
     */
    public Contact acceptInvitation(String invitationId) {
        // TODO
        return null;
    }

    /**
     * Registers a listener to know when a previously sent invitation has been accepted.
     * Currently, it's only possible to know when an invitation was accepted, but not when
     * it was rejected.
     *
     * @param onInvitationAcceptedListener Called whenever an invitation has been accepted.
     */
    public void addOnInvitationAcceptedListener(OnInvitationAcceptedListener onInvitationAcceptedListener) {
        this.onInvitationAcceptedListeners.add(onInvitationAcceptedListener);
    }

    /**
     * Configures the way invitations are accepted: manually, or automatically.
     *
     * @param mode Whether invitations should be accepted manually or automatically.
     */
    public void setInvitationRequestsMode(InvitationRequestsMode mode) {
        getPrefs().edit().putInt(INVITATION_REQUESTS_MODE_PREF_KEY, mode.mValue).apply();
    }

    /**
     * Returns the way invitations are accepted.
     */
    public InvitationRequestsMode getInvitationRequestsMode() {
        int invitationRequestsModeAsInt = getPrefs().getInt(INVITATION_REQUESTS_MODE_PREF_KEY, InvitationRequestsMode.AUTO_ACCEPT.mValue);
        return InvitationRequestsMode.fromValue(invitationRequestsModeAsInt);
    }

    /**
     * DID Session sandboxed preferences
     */
    private SharedPreferences getPrefs() {
        return context.getSharedPreferences("CONTACT_NOTIFIER_PREFS_"+didSessionDID, Context.MODE_PRIVATE);
    }

    private void listenToCarrierHelperEvents() {
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
                                dbAdapter.addContact(didSessionDID, did, carrierUserId);
                                // TODO: send a local notification to tell user about this (xxx Added as friend!)
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
                    dbAdapter.addReceivedInvitation(didSessionDID, did, carrierUserId);
                    // TODO: send a local notification to tell user about this (accept xxx as friend?)
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
                        // TODO: send this remote notification as local notification (contact xxx is sharing yyy)
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

    private void updateFriendOnlineStatus(FriendInfo info) {
        // Resolve the contact and make sure this friend wants to be seen.
        Contact contact = dbAdapter.getContactByCarrierUserID(didSessionDID, info.getUserId());
        if (contact != null) {
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
    private SentInvitation findSentInvitationByFriendId(String friendId) {
        ArrayList<SentInvitation> invitations = dbAdapter.getAllSentInvitations(didSessionDID);
        for (SentInvitation invitation : invitations) {
            if (invitation.carrierAddress != null) {
                // Resolve user id associated with the invitation carrier address to be able to compare it
                String invitationUserID = Carrier.getIdFromAddress(invitation.carrierAddress);
                if (invitationUserID != null && invitationUserID.equals(friendId)) {
                    // We found a pending invitation that matches the given friend.
                    return invitation;
                }
            }
        }
        return null;
    }

    private void handleFriendInvitationAccepted(SentInvitation invitation, String friendId) {
        // TODO addcontact(invitation info (did))
        // TODO removeinvitation()
    }

    private void notifyOnlineStatusChanged(String friendId, ConnectionStatus status) {
        if (onOnlineStatusChangedListeners.size() == 0)
            return;

        // Resolve contact from friend ID
        Contact contact = dbAdapter.getContactByCarrierUserID(didSessionDID, friendId);
        if (contact != null) {
            for (OnOnlineStatusListener listener : onOnlineStatusChangedListeners) {
                listener.onStatusChanged(contact, onlineStatusFromCarrierStatus(status));
            }
        }
    }

    public OnlineStatus onlineStatusFromCarrierStatus(ConnectionStatus status) {
        switch (status) {
            case Connected:
                return OnlineStatus.ONLINE;
            case Disconnected:
                return OnlineStatus.OFFLINE;
        }

        // No clean info - considered as offline.
        return OnlineStatus.OFFLINE;
    }

    /**
     * NOTE: As carrier can't really hide user's visibility from the user side, we use the "presence status" information
     * to let friends plugins know whether user wants to show his presence or not. This is not a ready away or online status.
     */
    public PresenceStatus onlineStatusModeToPresenceStatus(OnlineStatusMode status) {
        switch (status) {
            case STATUS_IS_VISIBLE:
                return PresenceStatus.None;
            case STATUS_IS_HIDDEN:
                return PresenceStatus.Away;
        }

        // No clean info - considered as hidden.
        return PresenceStatus.Away;
    }
}
