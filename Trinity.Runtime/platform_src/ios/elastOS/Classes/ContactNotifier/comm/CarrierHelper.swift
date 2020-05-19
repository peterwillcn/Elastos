import ElastosCarrierSDK

protocol OnCarrierEventListener {
    func onFriendRequest(_ did: String, _ userId: String)
    func onFriendOnlineStatusChange(_ info: FriendInfo)
    func onFriendPresenceStatusChange(_ info: FriendInfo)
    func onRemoteNotification(_ friendId: String, _ remoteNotification: RemoteNotificationRequest)
}

public class CarrierHelper {
    var didSessionDID: String
    private var notifier: ContactNotifier
    var carrierInstance: Carrier? = nil
    private var commandQueue = Array<CarrierCommand>() // List of commands to execute. We use a queue in case we have to wait for our carrier instance to be ready (a few seconds)
    private var onCarrierEventListener: OnCarrierEventListener? = nil
    private var carrierDelegate: CarrierDelegate? = nil

    public typealias onCommandExecuted = (_ succeeded: Bool, _ reason: String?) -> Void

    public init(notifier: ContactNotifier, didSessionDID: String) throws {
        self.notifier = notifier
        self.didSessionDID = didSessionDID
        
        try initialize()
    }

    private func initialize() throws {
        // Initial setup
        let options = DefaultCarrierOptions.createOptions(didSessionDID: didSessionDID)
        
        class CarrierHandler : CarrierDelegate {
            let helper: CarrierHelper
            
            init(helper: CarrierHelper) {
                self.helper = helper
            }
            
            func connectionStatusDidChange(_ carrier: Carrier, _ status: CarrierConnectionStatus) {
                Log.i(ContactNotifier.LOG_TAG, "Carrier connection status: \(status)")

                if(status == .Connected) {
                    // We are now connected to carrier network, we can start to send friend requests, or messages
                    helper.checkRunQueuedCommands()
                }
            }
            
            func didReceiveFriendRequest(_ carrier: Carrier, _ userId: String, _ userInfo: CarrierUserInfo, _ hello: String) {
                Log.i(ContactNotifier.LOG_TAG, "Carrier received friend request. Peer UserId: \(userId)");

                // First make sure this is a elastOS contact notifier plugin request, and that we understand the data
                // packaged in the hello string.
                if let invitationRequest = hello.toDict() { // JSON stirng to JSON object
                    if let contactDID = invitationRequest["did"] as? String {
                        Log.i(ContactNotifier.LOG_TAG, "Received friend request from DID \(String(describing: contactDID)) with carrier userId: " + userId);

                        helper.onCarrierEventListener?.onFriendRequest(contactDID, userId)
                    }
                    else {
                        Log.w(ContactNotifier.LOG_TAG, "Invitation received from carrier userId \(userId) but no contact DID is given.")
                    }
                }
                else {
                    // Invitation is not understood, forget it.
                    Log.w(ContactNotifier.LOG_TAG, "Invitation received from carrier userId \(userId) but hello string can't be understood: \(hello)")
                }
            }
            
            func didReceiveFriendInviteRequest(_ carrier: Carrier, _ from: String, _ data: String) {
                Log.i(ContactNotifier.LOG_TAG, "Did receive friend invite request from: \(from)")
            }
            
            func newFriendAdded(_ carrier: Carrier, _ info: CarrierFriendInfo) {
                Log.i(ContactNotifier.LOG_TAG, "Carrier friend added. Peer UserId: \(String(describing: info.userId))")
            }
            
            func friendConnectionDidChange(_ carrier: Carrier, _ friendId: String, _ status: CarrierConnectionStatus) {
                Log.i(ContactNotifier.LOG_TAG, "Carrier friend connection status changed - peer UserId: \(friendId)")
                Log.i(ContactNotifier.LOG_TAG, "Friend status: \(status)")

                if let info = try? carrier.getFriendInfo(friendId) {
                    helper.onCarrierEventListener?.onFriendOnlineStatusChange(info)
                }
            }
            
            func friendPresenceDidChange(_ carrier: Carrier, _ friendId: String, _ newPresence: CarrierPresenceStatus) {
                if let info = try? carrier.getFriendInfo(friendId) {
                    helper.onCarrierEventListener?.onFriendPresenceStatusChange(info)
                }
            }
            
            func didReceiveFriendMessage(_ carrier: Carrier, _ from: String, _ data: Data, _ isOffline: Bool) {
                let dataAsStr = String(data: data, encoding: .utf8)
                
                Log.i(ContactNotifier.LOG_TAG, "Message from userId: \(from)")
                Log.i(ContactNotifier.LOG_TAG, "Message: \(String(describing: dataAsStr))")

                // Try to read this as JSON. If not json, this is an invalid command
                if let request = dataAsStr?.toDict() {
                    handleReceivedMessageCommand(friendId: from, request: request)
                }
                else {
                    Log.i(ContactNotifier.LOG_TAG, "Received friend message but unable to read it as json")
                }
            }
            
            private func handleReceivedMessageCommand(friendId: String, request: Dictionary<String, Any>) {
                if !request.keys.contains("command") {
                    Log.w(ContactNotifier.LOG_TAG, "Command received as JSON, but no command field inside")
                    return
                }

                let command = request["command"] as? String

                switch (command) {
                    case "remotenotification":
                        handleReceivedRemoteNotification(friendId: friendId, request: request)
                        break;
                    default:
                        Log.w(ContactNotifier.LOG_TAG, "Unknown command: \(String(describing: command))")
                }
            }

            private func handleReceivedRemoteNotification(friendId: String, request: Dictionary<String, Any>) {
                if !request.keys.contains("key") || !request.keys.contains("title") {
                    Log.w(ContactNotifier.LOG_TAG, "Invalid remote notification command received: missing mandatory fields")
                    return
                }

                guard let remoteNotification = RemoteNotificationRequest.fromJSONObject(request) else {
                    // Couldn't parse as a proper notification.
                    Log.w(ContactNotifier.LOG_TAG, "Invalid remote notification command received: format not understood")
                    return
                }

                helper.onCarrierEventListener?.onRemoteNotification(friendId, remoteNotification)
            }
        }

        carrierDelegate = CarrierHandler(helper: self) // Retain a reference on carrier delegate as carrier FWK does not, and this leads to a crash.
        carrierInstance = try Carrier.createInstance(options: options, delegate: carrierDelegate!)

        // Start the service
        try carrierInstance!.start(iterateInterval: 5000) // Start carrier. Wait N milliseconds between each check of carrier status (polling)
    }
    
    func setCarrierEventListener(_ listener: OnCarrierEventListener) {
        self.onCarrierEventListener = listener
    }

    public func getOrCreateAddress() throws -> String{
        return carrierInstance!.getAddress()
    }

    public func sendInvitation(contactCarrierAddress: String, completionListener: @escaping onCommandExecuted) {
        queueCommand(ContactInvitationCommand(helper: self, contactCarrierAddress: contactCarrierAddress, completionListener: completionListener))
    }

    public func acceptFriend(contactCarrierUserID: String, completionListener: @escaping onCommandExecuted) {
        queueCommand(AcceptFriendCommand(helper: self, contactCarrierUserID: contactCarrierUserID, completionListener: completionListener))
    }

    public func sendRemoteNotification(contactCarrierUserID: String, notificationRequest: RemoteNotificationRequest, completionListener: @escaping onCommandExecuted) {
        queueCommand(RemoteNotificationCommand(helper: self, contactCarrierUserID: contactCarrierUserID, notificationRequest: notificationRequest, completionListener: completionListener))
    }

    public func setOnlineStatusMode(_ onlineStatusMode: OnlineStatusMode) {
        queueCommand(SetPresenceCommand(helper: self, status: notifier.onlineStatusModeToPresenceStatus(onlineStatusMode)))
    }

    public func removeFriend(contactCarrierUserID: String, completionListener: @escaping onCommandExecuted) {
        queueCommand(RemoveFriendCommand(helper: self, contactCarrierUserID: contactCarrierUserID, completionListener: completionListener))
    }

    public func getFriendOnlineStatus(friendId: String) -> CarrierConnectionStatus {
        do {
            if (!carrierInstance!.isReady()) {
                return .Disconnected
            }

            return try carrierInstance!.getFriendInfo(friendId).status
        }
        catch {
            return .Disconnected
        }
    }

    private func queueCommand(_ command: CarrierCommand) {
        commandQueue.append(command)
        checkRunQueuedCommands()
    }

    /**
     * Checks if we are connected to carrier and if so, sends the queued commands.
     */
    private func checkRunQueuedCommands() {
        guard carrierInstance!.isReady() else {
            return
        }

        while commandQueue.count > 0 {
            if let command = commandQueue.first {
                command.executeCommand()
                
                // Even if the command execution fails, we remove it from the queue. We don't want to be stuck forever on a
                // corrupted command. In such case for now, we would loose the command though, which is not perfect and should be
                // improved to be more robust.
                commandQueue.removeFirst()
            }
        }
    }
}
