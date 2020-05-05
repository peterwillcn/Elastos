package org.elastos.trinity.runtime.contactnotifier;

import android.content.Context;
import android.content.SharedPreferences;

import org.elastos.carrier.exceptions.CarrierException;
import org.elastos.trinity.runtime.AppManager;
import org.elastos.trinity.runtime.contactnotifier.comm.CarrierHelper;
import org.elastos.trinity.runtime.contactnotifier.db.DatabaseAdapter;

import java.util.ArrayList;
import java.util.HashMap;

// TODO: PROBLEM - CARRIER NOT READY WHEN ELASTOS STARTS AND DIRECTLY ADDING A FRIEND
// TODO: PROBLEM - SHOULD INITIALIZE THE NOTIFIER AT ELASTOS START, NOT AT FIRST API CALL, TO SAVE TIME AND START LISTENING

public class ContactNotifier {
    public static final String LOG_TAG = "ContactNotifier";

    private static final String ONLINE_STATUS_MODE_PREF_KEY = "onlinestatusmode";
    private static final String INVITATION_REQUESTS_MODE_PREF_KEY = "invitationrequestsmode";

    private static HashMap<String, ContactNotifier> instances = new HashMap<>(); // Sandbox DIDs - One did session = one instance

    private Context context = null;
    private String didSessionDID = null;
    private AppManager appManager = null;
    private DatabaseAdapter dbAdapter = null;
    private CarrierHelper carrierHelper = null;

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
        this.dbAdapter = new DatabaseAdapter(context);
        this.carrierHelper = new CarrierHelper(didSessionDID, context);
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

    public void setAppManager(AppManager appManager) {
        this.appManager = appManager;
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
        return dbAdapter.getContact(didSessionDID, did);
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
    public void sendInvitation(String carrierAddress) throws CarrierException {
        carrierHelper.sendInvitation(carrierAddress);
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
        int invitationRequestsModeAsInt = getPrefs().getInt(INVITATION_REQUESTS_MODE_PREF_KEY, InvitationRequestsMode.MANUALLY_ACCEPT.mValue);
        return InvitationRequestsMode.fromValue(invitationRequestsModeAsInt);
    }

    /**
     * DID Session sandboxed preferences
     */
    private SharedPreferences getPrefs() {
        return context.getSharedPreferences("CONTACT_NOTIFIER_PREFS_"+didSessionDID, Context.MODE_PRIVATE);
    }
}
