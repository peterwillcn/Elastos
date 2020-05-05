package org.elastos.trinity.runtime.contactnotifier;

import android.content.Context;

import org.elastos.carrier.AbstractCarrierHandler;
import org.elastos.carrier.Carrier;
import org.elastos.carrier.CarrierHandler;
import org.elastos.carrier.ConnectionStatus;
import org.elastos.carrier.FriendInfo;
import org.elastos.carrier.UserInfo;
import org.elastos.carrier.exceptions.CarrierException;
import org.elastos.trinity.runtime.AppManager;
import org.elastos.trinity.runtime.contactnotifier.db.DatabaseAdapter;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Logger;

public class ContactNotifier {
    private static HashMap<String, ContactNotifier> instances = null; // Sandbox DIDs - One did session = one instance

    private Context context = null;
    private String didSessionDID = null;
    private AppManager appManager = null;
    private DatabaseAdapter dbAdapter = null;

    private ArrayList<OnOnlineStatusListener> onOnlineStatusChangedListeners = new ArrayList<>();

    public interface OnInvitationAcceptedListener {
        void onInvitationAccepted(Contact contact);
    }

    public interface OnOnlineStatusListener {
        void onStatusChanged(Contact contact, OnlineStatus status);
    }

    private ContactNotifier(Context context, String didSessionDID) {
        this.context = context;
        this.didSessionDID = didSessionDID;
        this.dbAdapter = new DatabaseAdapter(context);
    }

    public static ContactNotifier getSharedInstance(Context context, String did) {
        if (instances.containsKey(did))
            return instances.get(did);
        else {
            ContactNotifier instance = new ContactNotifier(context, did);
            instances.put(did, instance);
            return instance;
        }
    }

    public void setAppManager(AppManager appManager) {
        this.appManager = appManager;
    }

    /**
     * Returns DID-session specific carrier address for the current user. This is the address
     * that can be shared with future contacts so they can send invitation requests.
     *
     * @returns The currently active carrier address on which user can be reached by (future) contacts.
     */
    public String getCarrierAddress() {
        return CarrierHelper.getOrCreateAddress(context);
    }

    /**
     * Retrieve a previously added contact from his DID.
     *
     * @param did The contact's DID.
     */
    public Contact resolveContact(String did) {
        return dbAdapter.getContact(didSessionDID, did);
    }

    /**
     * Remove an existing contact. This contact stops seeing user's online status, can't send notification
     * any more.
     *
     * @param did DID of the contact to remove
     */
    public void removeContact(String did) {
        dbAdapter.removeContact(didSessionDID, did);
    }

    /**
     * Listen to changes in contacts online status.
     *
     * @param onOnlineStatusChanged Called every time a contact becomes online or offline.
     */
    public void addOnlineStatusListener(OnOnlineStatusListener onOnlineStatusChanged) {
        this.onOnlineStatusChangedListeners.add(onOnlineStatusChanged);
    }

    /**
     * Changes the online status mode, that decides if user's contacts can see his online status or not.
     *
     * @param onlineStatusMode Whether contacts can see user's online status or not.
     */
    public void setOnlineStatusMode(OnlineStatusMode onlineStatusMode) {

    }

    /**
     * Sends a contact request to a peer. This contact will receive a notification about this request
     * and can choose to accept the invitation or not.
     *
     * In case the invitation is accepted, both peers become friends on carrier and in this contact notifier and can
     * start sending remote notifications to each other.
     *
     * Use invitation accepted listener API to get informed of changes.
     *
     * @param carrierAddress Target carrier address. Usually shared privately or publicly by the future contact.
     */
    public void sendInvitation(String carrierAddress) {

    }

    /**
     * Accepts an invitation sent by a remote peer. After accepting an invitation, a new contact is saved
     * with his did and carrier addresses. After that, this contact can be resolved as a contact object
     * from his did string.
     *
     * @param invitationId Received invitation id that we're answering for.
     *
     * @returns The generated contact
     */
    public Contact acceptInvitation(String invitationId) {
        return null;
    }

    /**
     * Registers a listener to know when a previously sent invitation has been accepted.
     * Currently, it's only possible to know when an invitation was accepted, but not when
     * it was rejected.
     *
     * @param onInvitationAcceptedListener Called whenever an invitation has been accepted.
     */
    public void addOnInvitationAcceptedListener(OnInvitationAcceptedListener onInvitationAcceptedListener) {
    }

    /**
     * Configures the way invitations are accepted: manually, or automatically.
     *
     * @param mode Whether invitations should be accepted manually or automatically.
     */
    public void setInvitationRequestsMode(InvitationRequestsMode mode) {

    }

    private static class CarrierHelper {
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
                Logger.getGlobal().info("Carrier connection status: " + status);

                if(status == ConnectionStatus.Connected) {
                    // Do something
                }
            }

            @Override
            public void onFriendRequest(Carrier carrier,
                                        String userId,
                                        UserInfo info,
                                        String hello) {
                Logger.getGlobal().info("Carrier received friend request. Peer UserId: " + userId);
                try {
                    carrier.acceptFriend(userId);
                }
                catch (CarrierException e) {
                    e.printStackTrace();
                }
            }

            @Override
            public void onFriendAdded(Carrier carrier, FriendInfo info) {
                Logger.getGlobal().info("Carrier friend added. Peer UserId: " + info.getUserId());
            }

            @Override
            public void onFriendConnection(Carrier carrier,
                                           String friendId,
                                           ConnectionStatus status) {
                Logger.getGlobal().info("Carrier friend connect. peer UserId: " + friendId);
                Logger.getGlobal().info("Friend status:" + status);

                if(status == ConnectionStatus.Connected) {
                    // Do something
                } else {
                    // Do something
                }
            }

            @Override
            public void onFriendMessage(Carrier carrier, String from, byte[] message, boolean isOffline) {
                Logger.getGlobal().info("Message from userId: " + from);
                Logger.getGlobal().info("Message: " + new String(message));
            }
        }

        static String getOrCreateAddress(Context context) {
            // Initial setup
            Carrier.Options options = new DefaultCarrierOptions(context.getFilesDir().getAbsolutePath()+"/contactnotifier");
            CarrierHandler handler = new DefaultCarrierHandler();

            try {
                // Create or get an our carrier instance instance
                Carrier carrier = Carrier.createInstance(options, handler);

                // Start the service
                carrier.start(1000); // Start carrier. Wait 500 milliseconds between each check of carrier status (polling)

                return carrier.getAddress();
            } catch (CarrierException e) {
                e.printStackTrace();
                return null;
            }
        }
    }
}
