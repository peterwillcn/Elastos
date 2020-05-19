package org.elastos.trinity.runtime.contactnotifier;

/**
 * Whether others can see this user's online status.
 * Default: STATUS_IS_VISIBLE
 */
public enum OnlineStatusMode {
    /** User's contacts can see if he is online or offline. */
    STATUS_IS_VISIBLE(0),
    /** User's contacts always see user as offline. */
    STATUS_IS_HIDDEN(1);

    public int mValue;

    OnlineStatusMode(int value) {
        mValue = value;
    }

    public static OnlineStatusMode fromValue(int value) {
        for(OnlineStatusMode t : values()) {
            if (t.mValue == value) {
                return t;
            }
        }
        return STATUS_IS_VISIBLE;
    }
}
