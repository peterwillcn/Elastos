package org.elastos.trinity.runtime.contactnotifier;

/**
 * Online status of a contact.
 */
public enum OnlineStatus {
    /** Contact is currently online. */
    OFFLINE(0),
    /** Contact is currently offline. */
    ONLINE(1);

    public int mValue;

    OnlineStatus(int value) {
        mValue = value;
    }

    public static OnlineStatus fromValue(int value) {
        for(OnlineStatus t : values()) {
            if (t.mValue == value) {
                return t;
            }
        }
        return OFFLINE;
    }
}
