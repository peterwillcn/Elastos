import ElastosCarrierSDK

public class CarrierHelper {
    var didSessionDID: String
    private var notifier: ContactNotifier
    var carrierInstance: Carrier
    private var commandQueue = Array<CarrierCommand>() // List of commands to execute. We use a queue in case we have to wait for our carrier instance to be ready (a few seconds)
    private var onCarrierEventListener: OnCarrierEventListener

    public typealias onCommandExecuted = (_ succeeded: boolean, _ reason: String) -> Void

    public protocol OnCarrierEventListener {
        func onFriendRequest(_ did: String, _ userId: String)
        func onFriendOnlineStatusChange(_ info: FriendInfo)
        func onFriendPresenceStatusChange(_ info: FriendInfo)
        func onRemoteNotification(_ friendId: String, _ remoteNotification: RemoteNotificationRequest)
    }

    public init(notifier: ContactNotifier, didSessionDID: String) throws {
        self.notifier = notifier;
        self.context = context;
        self.didSessionDID = didSessionDID;

        initialize()
    }

    private func initialize() throws {
        // Initial setup
        let options = DefaultCarrierOptions(context.getFilesDir().getAbsolutePath()+"/contactnotifier/"+didSessionDID)
        
        class CarrierHandler : CarrierDelegate {
            func connectionStatusDidChange(_ carrier: Carrier, _ newStatus: CarrierConnectionStatus) {
                Log.i(ContactNotifier.LOG_TAG, "Carrier connection status: \(status)")

                if(status == ConnectionStatus.Connected) {
                    // We are now connected to carrier network, we can start to send friend requests, or messages
                    self.checkRunQueuedCommands()
                }
            }
            
            func didReceiveFriendRequest(_ carrier: Carrier, _ userId: String, _ userInfo: CarrierUserInfo, _ hello: String) {
                Log.i(ContactNotifier.LOG_TAG, "Carrier received friend request. Peer UserId: \(userId)");

                // First make sure this is a elastOS contact notifier plugin request, and that we understand the data
                // packaged in the hello string.
                do {
                    JSONObject invitationRequest = new JSONObject(hello);

                    String contactDID = invitationRequest.getString("did"); // Will throw exception is not present

                    Log.i(ContactNotifier.LOG_TAG, "Received friend request from DID "+contactDID+" with carrier userId: " + userId);

                    onCarrierEventListener.onFriendRequest(contactDID, userId);
                }
                catch (JSONException e) {
                    // Invitation is not understood, forget it.
                    Log.w(ContactNotifier.LOG_TAG, "Invitation received from carrier userId "+userId+" but hello string can't be understood: "+hello);
                }
            }
        }

        // Create or get an our carrier instance instance
        carrierInstance = Carrier.createInstance(options, new AbstractCarrierHandler() {
        
            @Override
            public void onFriendAdded(Carrier carrier, FriendInfo info) {
                Log.i(ContactNotifier.LOG_TAG, "Carrier friend added. Peer UserId: " + info.getUserId());
            }

            @Override
            public void onFriendConnection(Carrier carrier,
                                           String friendId,
                                           ConnectionStatus status) {
                Log.i(ContactNotifier.LOG_TAG, "Carrier friend connection status changed - peer UserId: " + friendId);
                Log.i(ContactNotifier.LOG_TAG, "Friend status:" + status);

                try {
                    FriendInfo info = carrier.getFriend(friendId);
                    onCarrierEventListener.onFriendOnlineStatusChange(info);
                }
                catch (CarrierException e) {
                    e.printStackTrace();
                    // Nothing
                }
            }

            @Override
            public void onFriendPresence(Carrier carrier, String friendId, PresenceStatus presence) {
                try {
                    FriendInfo info = carrier.getFriend(friendId);
                    onCarrierEventListener.onFriendPresenceStatusChange(info);
                }
                catch (CarrierException e) {
                    e.printStackTrace();
                    // Nothing
                }
            }

            @Override
            public void onFriendMessage(Carrier carrier, String from, byte[] message, boolean isOffline) {
                Log.i(ContactNotifier.LOG_TAG, "Message from userId: " + from);
                Log.i(ContactNotifier.LOG_TAG, "Message: " + new String(message));

                // Try to read this as JSON. If not json, this is an invalid command
                try {
                    JSONObject request = new JSONObject(new String(message));
                    handleReceivedMessageCommand(from, request);
                }
                catch (JSONException e) {
                    Log.i(ContactNotifier.LOG_TAG, "Invalid command for the contact notifier");
                    e.printStackTrace();
                }
            }
        });

        // Start the service
        carrierInstance.start(5000); // Start carrier. Wait N milliseconds between each check of carrier status (polling)
    }

    public void setCarrierEventListener(OnCarrierEventListener listener) {
        this.onCarrierEventListener = listener;
    }

    public String getOrCreateAddress() throws CarrierException {
        return carrierInstance.getAddress();
    }

    public void sendInvitation(String contactCarrierAddress, OnCommandExecuted completionListener) {
        queueCommand(new ContactInvitationCommand(this, contactCarrierAddress, completionListener));
    }

    public void acceptFriend(String contactCarrierUserID, OnCommandExecuted completionListener) {
        queueCommand(new AcceptFriendCommand(this, contactCarrierUserID, completionListener));
    }

    public void sendRemoteNotification(String contactCarrierUserID, RemoteNotificationRequest notificationRequest, OnCommandExecuted completionListener) {
        queueCommand(new RemoteNotificationCommand(this, contactCarrierUserID, notificationRequest, completionListener));
    }

    public void setOnlineStatusMode(OnlineStatusMode onlineStatusMode) {
        queueCommand(new SetPresenceCommand(this, notifier.onlineStatusModeToPresenceStatus(onlineStatusMode)));
    }

    public void removeFriend(String contactCarrierUserID, OnCommandExecuted completionListener) {
        queueCommand(new RemoveFriendCommand(this, contactCarrierUserID, completionListener));
    }

    public ConnectionStatus getFriendOnlineStatus(String friendId) {
        try {
            if (!carrierInstance.isReady())
                return ConnectionStatus.Disconnected;

            return carrierInstance.getFriend(friendId).getConnectionStatus();
        }
        catch (CarrierException e) {
            return ConnectionStatus.Disconnected;
        }
    }

    private void queueCommand(CarrierCommand command) {
        commandQueue.add(command);
        checkRunQueuedCommands();
    }

    /**
     * Checks if we are connected to carrier and if so, sends the queued commands.
     */
    private void checkRunQueuedCommands() {
        if (!carrierInstance.isReady())
            return;

        Iterator<CarrierCommand> it = commandQueue.iterator();
        while (it.hasNext()) {
            CarrierCommand command = it.next();
            command.executeCommand();

            // Even if the command execution fails, we remove it from the queue. We don't want to be stuck forever on a
            // corrupted command. In such case for now, we would loose the command though, which is not perfect and should be
            // improved to be more robust.
            it.remove();
        }
    }

    private void handleReceivedMessageCommand(String friendId, JSONObject request) {
        if (!request.has("command")) {
            Log.w(ContactNotifier.LOG_TAG, "Command received as JSON, but no command field inside");
            return;
        }

        try {
            String command = request.getString("command");

            switch (command) {
                case "remotenotification":
                    handleReceivedRemoteNotification(friendId, request);
                    break;
                default:
                    Log.w(ContactNotifier.LOG_TAG, "Unknown command: "+command);
            }
        }
        catch (JSONException e) {
            e.printStackTrace();
            Log.w(ContactNotifier.LOG_TAG, "Invalid remote command received");
        }
    }

    private void handleReceivedRemoteNotification(String friendId, JSONObject request) {
        if (!request.has("key") || !request.has("title")) {
            Log.w(ContactNotifier.LOG_TAG, "Invalid remote notification command received: missing mandatory fields");
            return;
        }

        RemoteNotificationRequest remoteNotification = RemoteNotificationRequest.fromJSONObject(request);
        if (remoteNotification == null) {
            // Couldn't parse as a proper notification.
            Log.w(ContactNotifier.LOG_TAG, "Invalid remote notification command received: format not understood");
            return;
        }

        onCarrierEventListener.onRemoteNotification(friendId, remoteNotification);
    }
}
