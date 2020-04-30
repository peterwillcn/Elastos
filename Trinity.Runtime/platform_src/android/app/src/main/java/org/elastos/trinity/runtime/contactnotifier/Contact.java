package org.elastos.trinity.runtime.contactnotifier;

public class Contact {

    /**
     * Returns the permanent DID string of this contact.
     * This is contact's unique identifier.
     */
    public String getDID() {
        return "";
    }

    /**
     * Returns the carrier address of this contact. After a contact is added, we get his permanent
     * carrier friend ID (stored internally) and the changeable carrier address is not needed any more for communications.
     * Though, some use cases still need to retrieve that carrier address.
     */
    public String getCarrierAddress() {
        return "";
    }

    /**
     * Sends a notification to the notification manager of a distant friend's Trinity instance.
     *
     * @param remoteNotification The notification content.
     *
     * @returns A promise that can be awaited and catched in case or error.
     */
    public void sendRemoteNotification(RemoteNotificationRequest remoteNotification) {

    }

    /**
     * Allow or disallow receiving remote notifications from this contact.
     *
     * @param allowNotifications True to receive notifications, false to reject them.
     */
    public void setAllowNotifications(boolean allowNotifications) {

    }

    /**
     * Tells whether the contact is currently online or not.
     */
    public OnlineStatus getOnlineStatus() {
        return OnlineStatus.OFFLINE;
    }
}
