public class ContactInvitationCommand : CarrierCommand {
    private let helper: CarrierHelper
    private let contactCarrierAddress: String
    private let completionListener: CarrierHelper.onCommandExecuted

    init(helper: CarrierHelper, contactCarrierAddress: String, completionListener: @escaping CarrierHelper.onCommandExecuted) {
        self.helper = helper
        self.contactCarrierAddress = contactCarrierAddress
        self.completionListener = completionListener
    }

    public func executeCommand() {
        Log.i(ContactNotifier.LOG_TAG, "Executing contact invitation command")
        do {
            // Let the receiver know who we are
            var invitationRequest = Dictionary<String, Any>()
            invitationRequest["did"] = helper.didSessionDID
            invitationRequest["source"] = "contact_notifier_plugin" // purely informative

            if let request = invitationRequest.toString() {
                try helper.carrierInstance!.addFriend(with: contactCarrierAddress, withGreeting: request)
                completionListener(true, nil)
            }
            else {
                completionListener(false, "Invalid friend invitation request object")
            }
        }
        catch (let error) {
            print(error)
            completionListener(false, error.localizedDescription)
        }
    }
}
