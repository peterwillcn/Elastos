package org.elastos.trinity.runtime.contactnotifier;

import org.elastos.trinity.runtime.AppManager;
import org.elastos.trinity.runtime.WebViewActivity;
import org.elastos.trinity.runtime.passwordmanager.PasswordManager;

public class ContactNotifier {
    static ContactNotifier instance = null;
    AppManager appManager = null;

    public interface OnInvitationAcceptedListener {
        void onInvitationAccepted(Contact contact);
    }

    public ContactNotifier() {
        ContactNotifier.instance = this;
    }

    public static ContactNotifier getSharedInstance() {
        return instance;
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
    public String getCarrierAddress() {
        return "";
    }

    /**
     * Retrieve a previously added contact from his DID.
     *
     * @param did The contact's DID.
     */
    public Contact resolveContact(String did) {
        return null;
    }

    /**
     * Remove an existing contact. This contact stops seeing user's online status, can't send notification
     * any more.
     *
     * @param did DID of the contact to remove
     */
    public void removeContact(String did) {

    }

    /**
     * Listen to changes in contacts online status.
     *
     * @param onStatusChanged Called every time a contact becomes online or offline.
     * @param onError Called in case or error while registering this listener.
     */
    // TODO setOnlineStatusListener(onStatusChanged:(contact: Contact, status: OnlineStatus)=>void, onError?:(error: string)=>void);

    /**
     * Changes the online status mode, that decides if user's contacts can see his online status or not.
     *
     * @param onlineStatusMode Whether contacts can see user's online status or not.
     */
    public void setOnlineStatusMode(OnlineStatusMode onlineStatusMode) {

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
    public void sendInvitation(String carrierAddress) {

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
    }

    /**
     * Configures the way invitations are accepted: manually, or automatically.
     *
     * @param mode Whether invitations should be accepted manually or automatically.
     */
    public void setInvitationRequestsMode(InvitationRequestsMode mode) {

    }
}
