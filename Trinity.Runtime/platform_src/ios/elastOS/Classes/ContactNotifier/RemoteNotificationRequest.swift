
public class RemoteNotificationRequest {
    /** Identification key used to overwrite a previous notification if it has the same key. */
    public var key: String? = nil
    /** Package ID of the sending app. */
    public var appId: String? = nil
    /** Title to be displayed as the main message on the notification. */
    public var title: String? = nil
    /** Intent URL emitted when the notification is clicked. */
    public var url: String? = nil

    public static func fromJSONObject(obj: NSDictionary) -> RemoteNotificationRequest {
        let notif = RemoteNotificationRequest()
        if (obj.has("key"))
            notif.key = obj.getString("key");
        if (obj.has("appId"))
            notif.appId = obj.getString("appId");
        if (obj.has("title"))
            notif.title = obj.getString("title");
        if (obj.has("url"))
            notif.url = obj.getString("url");
        return notif
    }
}
