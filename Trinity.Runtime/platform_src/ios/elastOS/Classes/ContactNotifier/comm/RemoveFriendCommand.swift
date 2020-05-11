public class RemoveFriendCommand : CarrierCommand {
    private let helper: CarrierHelper
    private let contactCarrierUserID: String
    private let completionListener: CarrierHelper.onCommandExecuted

    init(helper: CarrierHelper, contactCarrierUserID: String, completionListener: @escaping CarrierHelper.onCommandExecuted) {
        self.helper = helper
        self.contactCarrierUserID = contactCarrierUserID
        self.completionListener = completionListener
    }

    public func executeCommand() {
        Log.i(ContactNotifier.LOG_TAG, "Executing remove friend command")
        do {
            try helper.carrierInstance.removeFriend(contactCarrierUserID)

            completionListener(true, nil)
        }
        catch (let error) {
            print(error)
            completionListener(false, error.localizedDescription)
        }
    }
}
