/**
 * Mode for accepting peers invitation requests.
 * Default: MANUALLY_ACCEPT
 */
public enum InvitationRequestsMode: Int {
    /** Manually accept all incoming requests. */
    case MANUALLY_ACCEPT = 0
    /** Automatically accept all incoming requests as new contacts. */
    case AUTO_ACCEPT = 1
    /** Automatically reject all incoming requests. */
    case AUTO_REJECT = 2
}
