/*
* Copyright (c) 2018-2020 Elastos Foundation
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

/**
 * This plugin handles connectivity and base exchanges with remote contacts, using DID and Carrier.
 * It runs a carrier instance (one per DID session) that can receive contact invitation requests, accept them,
 * resolve contact carrier address, send notifications to contact, etc.
 * 
 * This plugin does not manage contacts profiles and other higher level features. It must be seen as a convenience
 * native communication channel with remote peers/contacts.
 * 
 * This plugin is also not meant to enable chat capabilities between contacts. The more they can do here is to share
 * notifications, and those notifications rely on third party capsules/apps.
 * 
 * This plugin also does the following things in background:
 * 
 * Handle received contact invitations: 
 *      Received invitations are stored in a database and trigger local notifications such as "CONTACT is inviting you".
 *      Clicking such notification is normally handled by the launcher app, in order to accept the invitation.
 * 
 * Handle confirmed invitation:
 *      After a contact accepted an invitation request, this plugin gets the acknowledgment and displays a local
 *      notification such as "CONTACT has accepted your invitation"
 * 
 * Listen to incoming notifications:
 *      Listens to incoming remote notifications, and displays a local notification.
 * 
 * <br><br>
 * Usage:
 * <br>
 * declare let contactNotifier: ContactNotifierPlugin.ContactNotifier;
 */
declare namespace ContactNotifierPlugin {
    type RemoteNotificationRequest = {
        /** Identification key used to overwrite a previous notification if it has the same key. */
        key: string,
        /** Package ID of the sending app. */
        appId: string,
        /** Title to be displayed as the main message on the notification. */
        title: string,
        /** Intent URL emitted when the notification is clicked. */
        url?: string
    }

    interface Contact {
        /**
         * Returns the permanent DID string of this contact. 
         * This is contact's unique identifier.
         */
        getDID(): string;

        /** 
         * Returns the carrier address of this contact. After a contact is added, we get his permanent 
         * carrier friend ID (stored internally) and the changeable carrier address is not needed any more for communications.
         * Though, some use cases still need to retrieve that carrier address.
         */
        getCarrierAddress(): string;

        /**
         * Sends a notification to the notification manager of a distant friend's Trinity instance.
         * 
         * @param remoteNotification The notification content.
         * 
         * @returns A promise that can be awaited and catched in case or error.
         */
        sendRemoteNotification(remoteNotification: RemoteNotificationRequest): Promise<void>;

        /**
         * Allow or disallow receiving remote notifications from this contact.
         * 
         * @param allowNotifications True to receive notifications, false to reject them.
         */
        setAllowNotifications(allowNotifications: boolean);

        /**
         * Tells whether the contact is currently online or not.
         */
        getOnlineStatus(): Promise<OnlineStatus>;
    }

    /**
     * Whether others can see this user's online status.
     * Default: STATUS_IS_VISIBLE
     */
    const enum OnlineStatusMode {
        /** User's contacts can see if he is online or offline. */
        STATUS_IS_VISIBLE = 0,
        /** User's contacts always see user as offline. */
        STATUS_IS_HIDDEN = 1
    }

    /**
     * Online status of a contact.
     */
    const enum OnlineStatus {
        /** Contact is currently online. */
        OFFLINE = 0,
        /** Contact is currently offline. */
        ONLINE = 1
    }

    /**
     * Mode for accepting peers invitation requests.
     * Default: MANUALLY_ACCEPT
     */
    const enum InvitationRequestsMode {
        /** Manually accept all incoming requests. */
        MANUALLY_ACCEPT = 0,
        /** Automatically accept all incoming requests as new contacts. */
        AUTO_ACCEPT = 1
    }

    interface ContactNotifier {
        /**
         * Returns DID-session specific carrier address for the current user. This is the address
         * that can be shared with future contacts so they can send invitation requests.
         * 
         * @returns The currently active carrier address on which user can be reached by (future) contacts.
         */
        getCarrierAddress(): Promise<string>;
    
        /**
         * Retrieve a previously added contact from his DID.
         * 
         * @param did The contact's DID.
         */
        resolveContact(did: string): Promise<Contact>;

        /**
         * Remove an existing contact. This contact stops seeing user's online status, can't send notification
         * any more.
         * 
         * @param did DID of the contact to remove
         */
        removeContact(did: string);

        /**
         * Listen to changes in contacts online status.
         * 
         * @param onStatusChanged Called every time a contact becomes online or offline.
         * @param onError Called in case or error while registering this listener.
         */
        setOnlineStatusListener(onStatusChanged:(contact: Contact, status: OnlineStatus)=>void, onError?:(error: string)=>void);

        /**
         * Changes the online status mode, that decides if user's contacts can see his online status or not.
         * 
         * @param onlineStatusMode Whether contacts can see user's online status or not. 
         */
        setOnlineStatusMode(onlineStatusMode: OnlineStatusMode);

        /**
         * Returns the current online status mode.
         */
        getOnlineStatusMode(): Promise<OnlineStatusMode>;

        /**
         * Sends a contact request to a peer. This contact will receive a notification about this request 
         * and can choose to accept the invitation or not.
         * 
         * In case the invitation is accepted, both peers become friends on carrier and in this contact notifier and can
         * start sending remote notifications to each other.
         * 
         * Use invitation accepted listener API to get informed of changes.
         * 
         * @param did Target contact DID. 
         * @param carrierAddress Target carrier address. Usually shared privately or publicly by the future contact.
         */
        sendInvitation(did: string, carrierAddress: string);

        /**
         * Accepts an invitation sent by a remote peer. After accepting an invitation, a new contact is saved
         * with his did and carrier addresses. After that, this contact can be resolved as a contact object
         * from his did string.
         * 
         * @param invitationId Received invitation id that we're answering for.
         * 
         * @returns The generated contact
         */
        acceptInvitation(invitationId: string): Promise<Contact>;

        /**
         * Registers a listener to know when a previously sent invitation has been accepted.
         * Currently, it's only possible to know when an invitation was accepted, but not when
         * it was rejected.
         * 
         * @param onInvitationAccepted Called whenever an invitation has been accepted.
         */
        setOnInvitationAcceptedListener(onInvitationAccepted: (contact: Contact)=>void);

        /**
         * Configures the way invitations are accepted: manually, or automatically.
         * 
         * @param mode Whether invitations should be accepted manually or automatically.
         */
        setInvitationRequestsMode(mode: InvitationRequestsMode);

        /**
         * Returns the way invitations are accepted.
         */
        getInvitationRequestsMode(): Promise<InvitationRequestsMode>;
    }
}