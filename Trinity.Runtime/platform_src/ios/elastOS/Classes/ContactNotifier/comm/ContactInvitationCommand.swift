public class ContactInvitationCommand : CarrierCommand {
    private let helper: CarrierHelper
    private let contactCarrierAddress: String
    private let completionListener: CarrierHelper.onCommandExecuted

    init(helper: CarrierHelper, contactCarrierAddress: String, completionListener: CarrierHelper.onCommandExecuted) {
        self.helper = helper
        self.contactCarrierAddress = contactCarrierAddress
        self.completionListener = completionListener
    }

    public override func executeCommand() {
        Log.i(ContactNotifier.LOG_TAG, "Executing contact invitation command")
        do {
            // Let the receiver know who we are
            let invitationRequest = Dictionary()
            invitationRequest["did"] = helper.didSessionDID
            invitationRequest["source"] = "contact_notifier_plugin" // purely informative

            helper.carrierInstance.addFriend(contactCarrierAddress, invitationRequest.toString())

            completionListener.onCommandExecuted(true, null)
        }
        catch (let error) {
            print(error)
            completionListener.onCommandExecuted(false, e.getLocalizedMessage());
        }
    }
}
