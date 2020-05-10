public class RemoteNotificationCommand : CarrierCommand {
    private var helper: CarrierHelper
    private var contactCarrierUserID: String
    private var notificationRequest: RemoteNotificationRequest
    private var completionListener: CarrierHelper.OnCommandExecuted

    init(helper: CarrierHelper, contactCarrierUserID: String, notificationRequest: RemoteNotificationRequest, completionListener: CarrierHelper.OnCommandExecuted) {
        self.helper = helper
        self.contactCarrierUserID = contactCarrierUserID
        self.notificationRequest = notificationRequest
        self.completionListener = completionListener
    }

    public override func executeCommand() {
        Log.i(ContactNotifier.LOG_TAG, "Executing remote contact notification command")
        do {
            // Package our remote command
            JSONObject request = new JSONObject();
            request.put("command", "remotenotification");
            request.put("source", "contact_notifier_plugin"); // purely informative
            request.put("key", notificationRequest.key);
            request.put("title", notificationRequest.title);

            if (notificationRequest.url != null)
                request.put("url", notificationRequest.url);

            helper.carrierInstance.sendFriendMessage(contactCarrierUserID, request.toString());

            completionListener.onCommandExecuted(true, null);
        }
        catch (Exception e) {
            e.printStackTrace();
            completionListener.onCommandExecuted(false, e.getLocalizedMessage());
        }
    }
}
