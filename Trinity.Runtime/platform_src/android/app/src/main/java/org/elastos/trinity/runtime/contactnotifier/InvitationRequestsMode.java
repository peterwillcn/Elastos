package org.elastos.trinity.runtime.contactnotifier;

/**
 * Mode for accepting peers invitation requests.
 * Default: MANUALLY_ACCEPT
 */
public enum InvitationRequestsMode {
    /** Manually accept all incoming requests. */
    MANUALLY_ACCEPT(0),
    /** Automatically accept all incoming requests as new contacts. */
    AUTO_ACCEPT(1);

    public int mValue;

    InvitationRequestsMode(int value) {
        mValue = value;
    }

    public static InvitationRequestsMode fromValue(int value) {
        for(InvitationRequestsMode t : values()) {
            if (t.mValue == value) {
                return t;
            }
        }
        return MANUALLY_ACCEPT;
    }
}
