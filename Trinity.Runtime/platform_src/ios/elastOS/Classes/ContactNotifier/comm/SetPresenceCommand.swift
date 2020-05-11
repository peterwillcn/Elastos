public class SetPresenceCommand : CarrierCommand {
    private let helper: CarrierHelper
    private let status: PresenceStatus

    init(helper: CarrierHelper, status: PresenceStatus) {
        self.helper = helper
        self.status = status
    }

    public override func executeCommand() {
        Log.i(ContactNotifier.LOG_TAG, "Executing presence status command")
        do {
            helper.carrierInstance.setPresence(status)
        }
        catch (let error) {
            print(error)
        }
    }
}
