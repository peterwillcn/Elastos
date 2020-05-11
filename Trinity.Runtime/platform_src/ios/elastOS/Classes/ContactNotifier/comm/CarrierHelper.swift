import ElastosCarrierSDK

public protocol OnCarrierEventListener {
    func onFriendRequest(_ did: String, _ userId: String)
    func onFriendOnlineStatusChange(_ info: FriendInfo)
    func onFriendPresenceStatusChange(_ info: FriendInfo)
    func onRemoteNotification(_ friendId: String, _ remoteNotification: RemoteNotificationRequest)
}

public class CarrierHelper {
    var didSessionDID: String
    private var notifier: ContactNotifier
    var carrierInstance: Carrier
    private var commandQueue = Array<CarrierCommand>() // List of commands to execute. We use a queue in case we have to wait for our carrier instance to be ready (a few seconds)
    private var onCarrierEventListener: OnCarrierEventListener

    public typealias onCommandExecuted = (_ succeeded: Bool, _ reason: String?) -> Void

    public init(notifier: ContactNotifier, didSessionDID: String) throws {
        self.notifier = notifier
        self.didSessionDID = didSessionDID

        try initialize()
    }

    private func initialize() throws {
        // Initial setup
        let dataPath = NSHomeDirectory() + "/Documents/data/"
        let options = DefaultCarrierOptions(path: dataPath+"/contactnotifier/"+didSessionDID)
        
        class CarrierHandler : CarrierDelegate {
            func connectionStatusDidChange(_ carrier: Carrier, _ status: CarrierConnectionStatus) {
                Log.i(ContactNotifier.LOG_TAG, "Carrier connection status: \(status)")

                if(status == .Connected) {
                    // We are now connected to carrier network, we can start to send friend requests, or messages
                    self.checkRunQueuedCommands()
                }
            }
            
            func didReceiveFriendRequest(_ carrier: Carrier, _ userId: String, _ userInfo: CarrierUserInfo, _ hello: String) {
                Log.i(ContactNotifier.LOG_TAG, "Carrier received friend request. Peer UserId: \(userId)");

                // First make sure this is a elastOS contact notifier plugin request, and that we understand the data
                // packaged in the hello string.
                do {
                    if let invitationRequest = hello.toDict() { // JSON stirng to JSON object
                        let contactDID = invitationRequest["did"] as? String

                        Log.i(ContactNotifier.LOG_TAG, "Received friend request from DID \(String(describing: contactDID)) with carrier userId: " + userId);

                        onCarrierEventListener.onFriendRequest(contactDID, userId)
                    }
                    else {
                        // Invitation is not understood, forget it.
                        Log.w(ContactNotifier.LOG_TAG, "Invitation received from carrier userId \(userId) but hello string can't be understood: \(hello)")
                    }
                }
                catch (let error) {
                    // Invitation is not understood, forget it.
                    Log.w(ContactNotifier.LOG_TAG, "Invitation received from carrier userId \(userId) but hello string can't be understood: \(hello)")
                }
            }
            
            func newFriendAdded(_ carrier: Carrier, _ info: CarrierFriendInfo) {
                Log.i(ContactNotifier.LOG_TAG, "Carrier friend added. Peer UserId: " + info.getUserId())
            }
            
            func friendConnectionDidChange(_ carrier: Carrier, _ friendId: String, _ status: CarrierConnectionStatus) {
                Log.i(ContactNotifier.LOG_TAG, "Carrier friend connection status changed - peer UserId: \(friendId)")
                Log.i(ContactNotifier.LOG_TAG, "Friend status: \(status)")

                do {
                    let info = try? carrier.getFriendInfo(friendId)
                    onCarrierEventListener.onFriendOnlineStatusChange(info)
                }
                catch (let error) {
                    print(error)
                    // Nothing
                }
            }
            
            func friendPresenceDidChange(_ carrier: Carrier, _ friendId: String, _ newPresence: CarrierPresenceStatus) {
                do {
                    let info = try? carrier.getFriendInfo(friendId)
                    onCarrierEventListener.onFriendPresenceStatusChange(info)
                }
                catch (let error) {
                    print(error)
                    // Nothing
                }
            }
            
            func didReceiveFriendMessage(_ carrier: Carrier, _ from: String, _ data: Data, _ isOffline: Bool) {
                let dataAsStr = String(data: data, encoding: .utf8)
                
                Log.i(ContactNotifier.LOG_TAG, "Message from userId: \(from)")
                Log.i(ContactNotifier.LOG_TAG, "Message: \(String(describing: dataAsStr)))"

                // Try to read this as JSON. If not json, this is an invalid command
                do {
                    let request = dataAsStr?.toDict()
                    handleReceivedMessageCommand(friendId: from, request: request)
                }
                catch (let error) {
                    Log.i(ContactNotifier.LOG_TAG, "Invalid command for the contact notifier")
                    print(error)
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
                        Log.w(ContactNotifier.LOG_TAG, "Unknown command: \(command)")
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

                onCarrierEventListener.onRemoteNotification(friendId, remoteNotification)
            }
        }

        // Create or get an our carrier instance instance
        carrierInstance = Carrier.createInstance(options, CarrierHandler())

        // Start the service
        carrierInstance.start(iterateInterval: 5000) // Start carrier. Wait N milliseconds between each check of carrier status (polling)
    }

    public func setCarrierEventListener(_ listener: OnCarrierEventListener) {
        self.onCarrierEventListener = listener
    }

    public func getOrCreateAddress() throws -> String{
        return carrierInstance.getAddress()
    }

    public func sendInvitation(contactCarrierAddress: String, completionListener: onCommandExecuted) {
        queueCommand(ContactInvitationCommand(helper: self, contactCarrierAddress: contactCarrierAddress, completionListener: completionListener))
    }

    public func acceptFriend(contactCarrierUserID: String, completionListener: onCommandExecuted) {
        queueCommand(AcceptFriendCommand(helper: self, contactCarrierUserID: contactCarrierUserID, completionListener: completionListener))
    }

    public func sendRemoteNotification(contactCarrierUserID: String, notificationRequest: RemoteNotificationRequest, completionListener: onCommandExecuted) {
        queueCommand(RemoteNotificationCommand(self, contactCarrierUserID, notificationRequest, completionListener))
    }

    public func setOnlineStatusMode(_ onlineStatusMode: OnlineStatusMode) {
        queueCommand(SetPresenceCommand(self, notifier.onlineStatusModeToPresenceStatus(onlineStatusMode)))
    }

    public func removeFriend(contactCarrierUserID: String, completionListener: onCommandExecuted) {
        queueCommand(RemoveFriendCommand(helper: self, contactCarrierUserID: contactCarrierUserID, completionListener: completionListener))
    }

    public func getFriendOnlineStatus(friendId: String) -> CarrierConnectionStatus {
        do {
            if (!carrierInstance.isReady()) {
                return .Disconnected
            }

            return try carrierInstance.getFriendInfo(friendId).status
        }
        catch (let error) {
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
        guard carrierInstance.isReady() else {
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
