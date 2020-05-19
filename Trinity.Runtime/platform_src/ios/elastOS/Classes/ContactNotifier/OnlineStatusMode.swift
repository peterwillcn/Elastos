/**
 * Whether others can see this user's online status.
 * Default: STATUS_IS_VISIBLE
 */
public enum OnlineStatusMode: Int {
    /** User's contacts can see if he is online or offline. */
    case STATUS_IS_VISIBLE = 0
    /** User's contacts always see user as offline. */
    case STATUS_IS_HIDDEN = 1
}
