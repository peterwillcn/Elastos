package org.elastos.trinity.runtime.contactnotifier.comm;

import android.content.Context;
import android.util.Log;

import org.elastos.carrier.AbstractCarrierHandler;
import org.elastos.carrier.Carrier;
import org.elastos.carrier.CarrierHandler;
import org.elastos.carrier.ConnectionStatus;
import org.elastos.carrier.FriendInfo;
import org.elastos.carrier.UserInfo;
import org.elastos.carrier.exceptions.CarrierException;
import org.elastos.trinity.runtime.contactnotifier.Contact;
import org.elastos.trinity.runtime.contactnotifier.ContactNotifier;
import org.elastos.trinity.runtime.contactnotifier.InvitationRequestsMode;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.Iterator;

public class CarrierHelper {
    String didSessionDID;
    private ContactNotifier notifier;
    private Context context;
    Carrier carrierInstance;
    private ArrayList<CarrierCommand> commandQueue = new ArrayList<>(); // List of commands to execute. We use a queue in case we have to wait for our carrier instance to be ready (a few seconds)
    private OnCarrierEventListener onCarrierEventListener;

    public interface OnCommandExecuted {
        void onCommandExecuted(boolean succeeded, String reason);
    }

    public interface OnCarrierEventListener {
        void onFriendRequest(String did, String userId);
        void onFriendOnlineStatusChange(String friendId, ConnectionStatus status);
    }

    public CarrierHelper(ContactNotifier notifier, String didSessionDID, Context context) throws CarrierException {
        this.notifier = notifier;
        this.context = context;
        this.didSessionDID = didSessionDID;

        initialize();
    }

    private void initialize() throws CarrierException {
        // Initial setup
        Carrier.Options options = new DefaultCarrierOptions(context.getFilesDir().getAbsolutePath()+"/contactnotifier/"+didSessionDID);

        // Create or get an our carrier instance instance
        carrierInstance = Carrier.createInstance(options, new AbstractCarrierHandler() {
            @Override
            public void onConnection(Carrier carrier, ConnectionStatus status) {
                Log.i(ContactNotifier.LOG_TAG, "Carrier connection status: " + status);

                if(status == ConnectionStatus.Connected) {
                    // We are now connected to carrier network, we can start to send friend requests, or messages
                    checkRunQueuedCommands();
                }
            }

            @Override
            public void onFriendRequest(Carrier carrier,
                                        String userId,
                                        UserInfo info,
                                        String hello) {
                Log.i(ContactNotifier.LOG_TAG, "Carrier received friend request. Peer UserId: " + userId);

                // First make sure this is a elastOS contact notifier plugin request, and that we understand the data
                // packaged in the hello string.
                try {
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

                onCarrierEventListener.onFriendOnlineStatusChange(friendId, status);
            }

            @Override
            public void onFriendMessage(Carrier carrier, String from, byte[] message, boolean isOffline) {
                Log.i(ContactNotifier.LOG_TAG, "Message from userId: " + from);
                Log.i(ContactNotifier.LOG_TAG, "Message: " + new String(message));

                // TODO: receive remote notifications here
            }
        });

        // Start the service
        carrierInstance.start(3000); // Start carrier. Wait N milliseconds between each check of carrier status (polling)
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
            it.remove();
        }
    }
}