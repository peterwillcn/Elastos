public class AcceptFriendCommand : CarrierCommand {
    private let helper: CarrierHelper
    private let contactCarrierUserID: String
    private let completionListener: CarrierHelper.onCommandExecuted

    init(helper: CarrierHelper, contactCarrierUserID: String, completionListener: CarrierHelper.onCommandExecuted) {
        self.helper = helper
        self.contactCarrierUserID = contactCarrierUserID
        self.completionListener = completionListener
    }

    public override func executeCommand() {
        Log.i(ContactNotifier.LOG_TAG, "Executing accept friend command")
        do {
            helper.carrierInstance.acceptFriend(contactCarrierUserID);

            completionListener.onCommandExecuted(true, null);
        }
        catch (let error) {
            print(error)
            completionListener.onCommandExecuted(false, e.getLocalizedMessage());
        }
    }
}
