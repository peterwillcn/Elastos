public class RemoteNotificationCommand : CarrierCommand {
    private var helper: CarrierHelper
    private var contactCarrierUserID: String
    private var notificationRequest: RemoteNotificationRequest
    private var completionListener: CarrierHelper.onCommandExecuted

    init(helper: CarrierHelper, contactCarrierUserID: String, notificationRequest: RemoteNotificationRequest, completionListener: @escaping CarrierHelper.onCommandExecuted) {
        self.helper = helper
        self.contactCarrierUserID = contactCarrierUserID
        self.notificationRequest = notificationRequest
        self.completionListener = completionListener
    }

    public func executeCommand() {
        Log.i(ContactNotifier.LOG_TAG, "Executing remote contact notification command")
        do {
            // Package our remote command
            var request = Dictionary<String, Any>()
            request["command"] = "remotenotification"
            request["source"] = "contact_notifier_plugin" // purely informative
            request["key"] = notificationRequest.key
            request["title"] = notificationRequest.title

            if (notificationRequest.url != nil) {
                request["url"] = notificationRequest.url!
            }

            helper.carrierInstance.sendFriendMessage(to: contactCarrierUserID, withString: request.toString())

            completionListener(true, nil)
        }
        catch (let error) {
            print(error)
            completionListener(false, error.localizedDescription)
        }
    }
}
