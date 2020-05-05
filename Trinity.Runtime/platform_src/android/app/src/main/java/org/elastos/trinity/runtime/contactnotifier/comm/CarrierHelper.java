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
import org.elastos.trinity.runtime.contactnotifier.ContactNotifier;

import java.util.ArrayList;
import java.util.logging.Logger;

public class CarrierHelper {
    static class DefaultCarrierOptions extends Carrier.Options {
        DefaultCarrierOptions(String path) {
            super();

            setOptions(path);
        }

        private void setOptions(String path) {
            setUdpEnabled(true);
            setPersistentLocation(path); // path is used to cache carrier data for better performance

            ArrayList<BootstrapNode> arrayList = new ArrayList<>();
            BootstrapNode node;

            node = new BootstrapNode();
            node.setIpv4("13.58.208.50");
            node.setPort("33445");
            node.setPublicKey("89vny8MrKdDKs7Uta9RdVmspPjnRMdwMmaiEW27pZ7gh");
            arrayList.add(node);

            node = new BootstrapNode();
            node.setIpv4("18.216.102.47");
            node.setPort("33445");
            node.setPublicKey("G5z8MqiNDFTadFUPfMdYsYtkUDbX5mNCMVHMZtsCnFeb");
            arrayList.add(node);

            node = new BootstrapNode();
            node.setIpv4("52.83.127.216");
            node.setPort("33445");
            node.setPublicKey("4sL3ZEriqW7pdoqHSoYXfkc1NMNpiMz7irHMMrMjp9CM");
            arrayList.add(node);

            node = new BootstrapNode();
            node.setIpv4("52.83.127.85");
            node.setPort("33445");
            node.setPublicKey("CDkze7mJpSuFAUq6byoLmteyGYMeJ6taXxWoVvDMexWC");
            arrayList.add(node);

            node = new BootstrapNode();
            node.setIpv4("18.216.6.197");
            node.setPort("33445");
            node.setPublicKey("H8sqhRrQuJZ6iLtP2wanxt4LzdNrN2NNFnpPdq1uJ9n2");
            arrayList.add(node);

            node = new BootstrapNode();
            node.setIpv4("52.83.171.135");
            node.setPort("33445");
            node.setPublicKey("5tuHgK1Q4CYf4K5PutsEPK5E3Z7cbtEBdx7LwmdzqXHL");
            arrayList.add(node);

            setBootstrapNodes(arrayList);
        }
    }

    static class DefaultCarrierHandler extends AbstractCarrierHandler {
        @Override
        public void onConnection(Carrier carrier, ConnectionStatus status) {
            Log.i(ContactNotifier.LOG_TAG, "Carrier connection status: " + status);

            if(status == ConnectionStatus.Connected) {
                // Do something
            }
        }

        @Override
        public void onFriendRequest(Carrier carrier,
                                    String userId,
                                    UserInfo info,
                                    String hello) {
            Log.i(ContactNotifier.LOG_TAG, "Carrier received friend request. Peer UserId: " + userId);
            try {
                carrier.acceptFriend(userId);
            }
            catch (CarrierException e) {
                e.printStackTrace();
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
            Log.i(ContactNotifier.LOG_TAG, "Carrier friend connect. peer UserId: " + friendId);
            Log.i(ContactNotifier.LOG_TAG, "Friend status:" + status);

            if(status == ConnectionStatus.Connected) {
                // Do something
            } else {
                // Do something
            }
        }

        @Override
        public void onFriendMessage(Carrier carrier, String from, byte[] message, boolean isOffline) {
            Log.i(ContactNotifier.LOG_TAG, "Message from userId: " + from);
            Log.i(ContactNotifier.LOG_TAG, "Message: " + new String(message));
        }
    }

    private static final String HELLO_MESSAGE = "elastOS contact notifier plugin invitation";

    private String didSessionDID = null;
    private Context context = null;
    private Carrier carrierInstance = null;

    public CarrierHelper(String didSessionDID, Context context) throws CarrierException {
        this.context = context;
        this.didSessionDID = didSessionDID;

        initialize();
    }

    private void initialize() throws CarrierException {
        // Initial setup
        Carrier.Options options = new DefaultCarrierOptions(context.getFilesDir().getAbsolutePath()+"/contactnotifier/"+didSessionDID);
        CarrierHandler handler = new DefaultCarrierHandler();

        // Create or get an our carrier instance instance
        carrierInstance = Carrier.createInstance(options, handler);

        // Start the service
        carrierInstance.start(1000); // Start carrier. Wait 500 milliseconds between each check of carrier status (polling)
    }

    public String getOrCreateAddress() throws CarrierException {
        return carrierInstance.getAddress();
    }

    public void sendInvitation(String contactCarrierAddress) throws CarrierException {
        carrierInstance.addFriend(contactCarrierAddress, HELLO_MESSAGE);
    }
}