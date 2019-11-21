export declare type OnSessionRequestComplete = (session: Session, status: Number, reason: string, sdp: string)=>void;
export declare type OnFriendInviteResponse = (from: string, status: Number, reason: string, data: string)=>void;

export declare type BootstrapNode = {
    ipv4: string;
    ipv6: string;
    port: string;
    publicKey: string;
}

export declare type Options = {
    udpEnabled: Boolean;
    persistentLocation: string;
    bootstraps: BootstrapNode[];
}

export declare type UserInfo = {
    userId: string;
    name: string;
    description: string;
    hasAvatar: Boolean;
    gender: string;
    phone: string;
    email: string;
    region: string;
}

export declare type FriendInfo = {
    userInfo: UserInfo;
    presence: PresenceStatus;
    connection: ConnectionStatus;
    label: string;
}

export declare type AddressInfo = {
    type: CandidateType;
    address: string;
    port: string;
    relatedAddress?: string;
    relatedPort?: string;
}

export declare type FileTransferInfo = {
    filename: string;
    fileId: string;
    size: Number;
}

export declare type TransportInfo = {
    topology: NetworkTopology;
    localAddr: AddressInfo;
    remoteAddr: AddressInfo;
}

export declare type StreamCallbacks = {
    onStateChanged?: (stream: Stream, state: StreamState)=>void;
    onStreamData?: (stream: Stream, data: string)=>void;
    onChannelOpen?: (stream: Stream, channel: Number, cookie: string)=>void;
    onChannelOpened?: (stream: Stream, channel: Number)=>void;
    onChannelClose?: (stream: Stream, channel: Number, reason: string)=>void;
    onChannelData?: (stream: Stream, channel: Number, data: string)=>void;
    onChannelPending?: (stream: Stream, channel: Number)=>void;
    onChannelResume?: (stream: Stream, channel: Number)=>void;
}

export declare interface Stream {
    id: Number;
    carrier: Carrier;
    session: Session;

    callbacks: StreamCallbacks;

    getTransportInfo: (onSuccess: (transportInfo: TransportInfo)=>void, onError?:(err: string)=>void)=>void;
    write: (data: string, onSuccess:(bytesSent: Number)=>void, onError?:(err: string)=>void)=>void;
    openChannel: (cookie: string, onSuccess:(channelId: Number)=>void, onError?:(err: string)=>void)=>void;
    closeChannel: (channel: Number, onSuccess:()=>void, onError?:(err: string)=>void)=>void;
    writeChannel: (channel: Number, data: string, onSuccess:(bytesSent: Number)=>void, onError?:(err: string)=>void)=>void;
    pendChannel: (channel: Number, onSuccess:()=>void, onError?:(err: string)=>void)=>void;
    resumeChannel: (channel: Number, onSuccess:()=>void, onError?:(err: string)=>void)=>void;
    openPortForwarding: (service: string, protocol: PortForwardingProtocol,  host: string, port: Number, onSuccess:(portForwardingId: Number)=>void, onError?:(err: string)=>void)=>void;
    closePortForwarding: (portForwarding: Number, onSuccess:()=>void, onError?:(err: string)=>void)=>void;
}

export declare interface Session {
    peer: string;
    carrier: Carrier;

    close: (onSuccess?:()=>void, onError?:(err: string)=>void)=>void;
    request: (handler: OnSessionRequestComplete, onSuccess:()=>void, onError?:(err: string)=>void)=>void;
    replyRequest: (status: Number, reason: string, onSuccess:()=>void, onError?:(err: string)=>void)=>void;
    start: (sdp: string, onSuccess:()=>void, onError?:(err: string)=>void)=>void;
    addStream: (type: StreamType, options: Number, callbacks: StreamCallbacks, onSuccess:()=>void, onError?:(err: string)=>void)=>void;
    removeStream: (stream: Stream, onSuccess:()=>void, onError?:(err: string)=>void)=>void;
    addService: (service: string, protocol: PortForwardingProtocol, host: string, port: Number, onSuccess:()=>void, onError?:(err: string)=>void)=>void;
    removeService: (service: string, onSuccess:()=>void, onError?:(err: string)=>void)=>void;
}

export declare type CarrierCallbacks = {
    onConnection?: (carrier: Carrier, status: ConnectionStatus)=>void;
    onReady?: (carrier: Carrier)=>void;
    onSelfInfoChanged?: (carrier: Carrier, userInfo: UserInfo)=>void;
    onFriends?: (carrier: Carrier, friends: FriendInfo[])=>void;
    onFriendConnection?: (carrier: Carrier, friendId: string, status: ConnectionStatus)=>void;
    onFriendInfoChanged?: (carrier: Carrier, friendId: string, info: FriendInfo)=>void;
    onFriendPresence?: (carrier: Carrier, friendId: string, presence: PresenceStatus)=>void;
    onFriendRequest?: (carrier: Carrier, userId: string, info: UserInfo, hello: string)=>void;
    onFriendAdded?: (carrier: Carrier, friendInfo: FriendInfo)=>void;
    onFriendRemoved?: (carrier: Carrier, friendId: string)=>void;
    onFriendMessage?: (carrier: Carrier, from: string, messate: string, isOffline: Boolean)=>void;
    onFriendInviteRequest?: (carrier: Carrier, from: string, data: string)=>void;
    onSessionRequest?: (carrier: Carrier, from: string, sdp: string)=>void;
    onGroupInvite?: (carrier: Carrier, groupTitle: string)=>void;
    onConnectRequest?: (carrier: Carrier, from: string, fileInfo: FileTransferInfo)=>void;
}

export declare interface Carrier {
    nodeId: string;
    userId: string;
    address: string;

    callbacks: CarrierCallbacks;

    start: (iterateInterval: Number, onSuccess:()=>void, onError?:(err: string)=>void)=>void;
    getSelfInfo: (onSuccess:(userInfo: UserInfo)=>void, onError?:(err: string)=>void)=>void;
    setSelfInfo: (name: string, value: string, onSuccess:()=>void, onError?:(err: string)=>void)=>void;
    isReady: (onSuccess:(ready: Boolean)=>void, onError?:(err: string)=>void)=>void;
    getFriends: (onSuccess:(friends: FriendInfo[])=>void, onError?:(err: string)=>void)=>void;
    getFriend: (userId: string, onSuccess:(friend: FriendInfo)=>void, onError?:(err: string)=>void)=>void;
    labelFriend: (userId: string, label: string, onSuccess:()=>void, onError?:(err: string)=>void)=>void;
    isFriend: (userId: string, onSuccess:(isFriend: Boolean)=>void, onError?:(err: string)=>void)=>void;
    addFriend: (address: string, hello: string, onSuccess:()=>void, onError?:(err: string)=>void)=>void;
    acceptFriend: (userId: string, onSuccess:()=>void, onError?:(err: string)=>void)=>void;
    removeFriend: (userId: string, onSuccess:()=>void, onError?:(err: string)=>void)=>void;
    sendFriendMessage: (to: string, message: string, onSuccess:()=>void, onError?:(err: string)=>void)=>void;
    inviteFriend: (to: string, data: string, handler: OnFriendInviteResponse, onSuccess:()=>void, onError?:(err: string)=>void)=>void;
    replyFriendInvite: (to: string, status: Number, reason: string, data: string, onSuccess:()=>void, onError?:(err: string)=>void)=>void;
    newGroup: (callbacks: CarrierCallbacks, onSuccess:(group: Group)=>void, onError?:(err: string)=>void)=>void;
    groupJoin: (friendId: string, cookieCode: string, onSuccess:(group: Group)=>void, onError?:(err: string)=>void)=>void;
    groupLeave: (group: Group, onSuccess:()=>void, onError?:(err: string)=>void)=>void;
    getGroups: (onSuccess:(groups: Group[])=>void, onError?:(err: string)=>void)=>void;
    newSession: (to: string, onSuccess:(session: Session)=>void, onError?:(err: string)=>void)=>void;
    destroy: (onSuccess:()=>void, onError?:(err: string)=>void)=>void;
}

export declare type GroupCallbacks = {
    onGroupConnected?: ()=>void ;
    onGroupMessage?: (from: string, message: string)=>void;
    onGroupTitle?: (from: string, title: string)=>void;
    onPeerName?: (peerId: string, peerName: string)=>void;
    onPeerListChanged?: ()=>void;
}

export declare interface Group {
    groupId: Number;
    callbacks: GroupCallbacks;

    invite: (friendId: string, onSuccess:()=>void, onError?:(err: string)=>void)=>void;
    sendMessage: (message: string, onSuccess:()=>void, onError?:(err: string)=>void)=>void;
    getTitle: (onSuccess:(groupTitle: string)=>void, onError?:(err: string)=>void)=>void;
    setTitle: (groupTitle: string, onSuccess:(groupTitle: string)=>void, onError?:(err: string)=>void)=>void;
    getPeers: (onSuccess:(peers: any)=>void, onError?:(err: string)=>void)=>void; // TODO: define a Peer type
    getPeer: (peerId: string, onSuccess:(peer: any)=>void, onError?:(err: string)=>void)=>void; // TODO: define a Peer type
}

export declare enum ConnectionStatus {
    CONNECTED=0,
    DISCONNECTED=1
}

export declare enum PresenceStatus {
    NONE=0,
    AWAY=1,
    BUSY=2
}

export declare enum StreamType {
    AUDIO=0,
    VIDEO=1,
    TEXT=2,
    APPLICATION=3,
    MESSAGE=4
}

export declare enum StreamState {
    RAW=0,
    INITIALIZED=1,
    TRANSPORT_READY=2,
    CONNECTING=3,
    CONNECTED=4,
    DEACTIVATED=5,
    CLOSED=6,
    ERROR=7
}

export declare enum CandidateType {
    HOST=0,
    SERVER_REFLEXIVE=1,
    PEER_REFLEXIVE=2,
    RELAYED=3
}
    
export declare enum NetworkTopology {
    LAN=0,
    P2P=1,
    RELAYED=2
}
    
export declare enum PortForwardingProtocol {
    TCP=1
}

export declare enum CloseReason {
    NORMAL=0,
    TIMEOUT=1,
    ERROR=2
}
   
export declare enum StreamMode {
    COMPRESS=1,
    PLAIN=2,
    RELIABLE=4,
    MULTIPLEXING=8,
    PORT_FORWARDING=16
}

export declare interface CarrierPlugin {
    getVersion: (onSuccess:(version: string)=>void, onError?:(err: string)=>void)=>void;
    isValidId: (id: string, onSuccess:(isValid: Boolean)=>void, onError?:(err: string)=>void)=>void;
    isValidAddress: (address: string, onSuccess:(isValid: string)=>void, onError?:(err: string)=>void)=>void;
    getIdFromAddress: (address: string, onSuccess:(userId: string)=>void, onError?:(err: string)=>void)=>void;
    createObject: (options: any, callbacks: CarrierCallbacks, onSuccess:(carrier: Carrier)=>void, onError?:(err: string)=>void)=>void; // TODO: need a type for options
}
