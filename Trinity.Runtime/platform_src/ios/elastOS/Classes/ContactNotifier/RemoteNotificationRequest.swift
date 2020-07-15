
public class RemoteNotificationRequest {
    /** Identification key used to overwrite a previous notification if it has the same key. */
    public var key: String? = nil
    /** Package ID of the sending app. */
    public var appId: String? = nil
    /** Title to be displayed as the main message on the notification. */
    public var title: String? = nil
    /** Intent URL emitted when the notification is clicked. */
    public var url: String? = nil

    public static func fromJSONObject(_ obj: Dictionary<String, Any>) -> RemoteNotificationRequest? {
        guard obj.keys.contains("key") && obj.keys.contains("title") else {
            return nil
        }
        
        let notif = RemoteNotificationRequest()
        
        notif.key = obj["key"] as? String
        
        if obj.keys.contains("appId") {
            notif.appId = obj["appId"] as? String
        }
        
        notif.title = obj["title"] as? String
        
        if obj.keys.contains("url") {
            notif.url = obj["url"] as? String
        }
        
        return notif
    }
}
