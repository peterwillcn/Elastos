import ElastosCarrierSDK

public class SetPresenceCommand : CarrierCommand {
    private let helper: CarrierHelper
    private let status: CarrierPresenceStatus

    init(helper: CarrierHelper, status: CarrierPresenceStatus) {
        self.helper = helper
        self.status = status
    }

    public func executeCommand() {
        Log.i(ContactNotifier.LOG_TAG, "Executing presence status command")
        do {
            helper.carrierInstance.setSelfPresence(status)
        }
        catch (let error) {
            print(error)
        }
    }
}
