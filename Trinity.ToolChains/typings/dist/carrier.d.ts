/*
* Copyright (c) 2018-2020 Elastos Foundation
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/
   
/**
* @module CarrierPlugin
*/

declare module CarrierPlugin {
    type Opaque<T, K> = T & { __opaque__: K };
    type Int = Opaque<number, 'Int'>;

    /**
    * The callback function to receive session request complete event.
    *
    * @callback OnSessionRequestComplete
    *
    * @param {Session} session     The carrier session instance.
    * @param {number}  status      The status code of the response. 0 is success, otherwise is error.
    * @param {string}  reason      The error message if status is error, or nil if session request error happened.
    * @param {string}  sdp         The remote users SDP. Reference: https://tools.ietf.org/html/rfc4566
    */
    type OnSessionRequestComplete = (session: Session, status: Number, reason: string, sdp: string)=>void;

    /**
    * The callback function to process the friend invite response.
    *
    * @callback OnFriendInviteResponse
    *
    * @param {string}  from   The target user id who send friend invite response
    * @param {number}  status   The status code of invite response. 0 is success, otherwise error
    * @param {string}  reason   The error message if status is error, otherwise null
    * @param {string}  data   The application defined data return by target user
    */
    type OnFriendInviteResponse = (from: string, status: Number, reason: string, data: string)=>void;

    /**
    * The Carrier user information.
    *
    * @typedef BootstrapNode
    * @type {Object}
    * @property {string} ipv4 The server ipv4.
    * @property {string} ipv6 The server ipv6.
    * @property {string} port The server port.
    * @property {string} publicKey The publicKey.
    */
    type BootstrapNode = {
        ipv4: string;
        ipv6: string;
        port: string;
        publicKey: string;
    }

    /**
    * Options defines several settings that control the way the Carrier node connects to the carrier network.
    * Default values are not defined for bootstraps options, so application should be set bootstrap nodes clearly.
    *
    * @typedef Options
    * @type {Object}
    * @property {Boolean} udpEnabled Set to use udp transport or not. Setting this value to false will force carrier node to TCP only,
    *                                which will potentially slow down the message to run through.
    * @property {string}  persistentLocation Set the persistent data location. The location must be set.
    * @property {Array}  bootstraps BootstrapNode Array.
    */
    type Options = {
        udpEnabled: Boolean;
        persistentLocation: string;
        bootstraps: BootstrapNode[];
    }

    /**
    * The Carrier user information.
    *
    * @typedef UserInfo
    * @type {Object}
    * @property {string} userId The user ID.
    * @property {string} name The nickname.
    * @property {string} description user's brief description.
    * @property {Boolean} hasAvatar Has avatar or not.
    * @property {string} gender The gender.
    * @property {string} phone The phone number.
    * @property {string} email The email address.
    * @property {string} region The region.
    */
    type UserInfo = {
        userId: string;
        name: string;
        description: string;
        hasAvatar: Boolean;
        gender: string;
        phone: string;
        email: string;
        region: string;
    }

    /**
    * The Carrier friend information.
    *
    * @typedef FriendInfo
    * @type {Object}
    * @property {UserInfo} userInfo The user info.
    * @property {PresenceStatus} presence The presence status.
    * @property {ConnectionStatus} connection The connection status.
    * @property {string} label The friend's label name.
    */
    type FriendInfo = {
        userInfo: UserInfo;
        presence: PresenceStatus;
        connection: ConnectionStatus;
        label: string;
    }

    /**
    * The netword address information.
    *
    * @typedef AddressInfo
    * @type {Object}
    * @property {CandidateType}    type             The address type.
    * @property {string}           address          The address.
    * @property {string}           port             The port.
    * @property {string}           [relatedAddress] The related address status.
    * @property {string}           [relatedPort]    The related port.
    */
    type AddressInfo = {
        type: CandidateType;
        address: string;
        port: string;
        relatedAddress?: string;
        relatedPort?: string;
    }

    /**
    * The file transfer information.
    *
    * @typedef FileTransferInfo
    * @type {Object}
    * @property {string}  filename    The file name.
    * @property {string}  fileId      The file id.
    * @property {long}    size        The file size.
    */
    type FileTransferInfo = {
        filename: string;
        fileId: string;
        size: Number;
    }

    /**
    * The netword transport information.
    *
    * @typedef TransportInfo
    * @type {Object}
    * @property {NetworkTopology}  topology    The network topology.
    * @property {AddressInfo}      localAddr   The local address.
    * @property {AddressInfo}      remoteAddr  The remote address.
    */
    type TransportInfo = {
        topology: NetworkTopology;
        localAddr: AddressInfo;
        remoteAddr: AddressInfo;
    }

    /**
    * The Stream callbacks.
    *
    * @typedef StreamCallbacks
    * @type {Object}
    */
    type StreamCallbacks = {
        /**
        * The callback function to report state of stream when it's state changes.
        *
        * @callback onStateChanged
        *
        * @param {Stream}      stream      The carrier stream instance
        * @param {StreamState} state       Stream state defined in StreamState
        */
        onStateChanged?: (stream: Stream, state: StreamState)=>void;

        /**
        * The callback will be called when the stream receives incoming packet.
        * If the stream enabled multiplexing mode, application will not
        * receive stream-layered data callback any more. All data will reported
        * as multiplexing channel data.
        *
        * @callback onStreamData
        *
        * @param {Stream} stream      The carrier stream instance
        * @param {base64} data        The received packet data.
        */
        onStreamData?: (stream: Stream, data: string)=>void;

        /**
        * The callback function to be called when new multiplexing channel request to open.
        *
        * @callback onChannelOpen
        *
        * @param
        * @param {Stream} stream      The carrier stream instance
        * @param {number} channel     The current channel ID.
        * @param {string} cookie      Application defined string data send from remote peer.
        *
        */
        onChannelOpen?: (stream: Stream, channel: Number, cookie: string)=>void;

        /**
        * The callback function to be called when new multiplexing channel opened.
        *
        * @callback onChannelOpened
        *
        * @param {Stream} stream      The carrier stream instance
        * @param {number} channel     The current channel ID.
        */
        onChannelOpened?: (stream: Stream, channel: Number)=>void;

        /**
        * The callback function to be called when channel close.
        *
        * @callback onChannelClose
        *
        * @param {Stream} stream      The carrier stream instance
        * @param {number} channel     The current channel ID.
        * @param {string} reason      Channel close reason code, defined in CloseReason.
        */
        onChannelClose?: (stream: Stream, channel: Number, reason: string)=>void;

        /**
        * The callback functiont to be called when channel received incoming data.
        *
        * @callback onChannelData
        *
        * @param {Stream} stream      The carrier stream instance
        * @param {number} channel     The current channel ID.
        * @param {base64} data        The received packet data.
        */
        onChannelData?: (stream: Stream, channel: Number, data: string)=>void;

        /**
        * The callback function to be called when remote peer ask to pend data sending.
        *
        * @callback onChannelPending
        *
        * @param {Stream} stream      The carrier stream instance
        * @param {number} channel     The current channel ID.
        */
        onChannelPending?: (stream: Stream, channel: Number)=>void;

        /**
        * The callback function to be called when remote peer ask to resume data sending.
        *
        * @callback onChannelResume
        *
        * @param {Stream} stream      The carrier stream instance
        * @param {number} channel     The current channel ID.
        */
        onChannelResume?: (stream: Stream, channel: Number)=>void;
    }

    /**
    * The class representing Carrier stream.
    * @class
    */
    interface Stream {
        /** @property {number}  id Stream ID. **/
        id: Int;
        /** @property {Carrier} carrier Parent carrier object. **/
        carrier: Carrier;
        /** @property {Session} session Parent session object. **/
        session: Session;
        /** @property {StreamType} type Type of the stream. **/
        type: StreamType;

        callbacks: StreamCallbacks;

        /**
        * Get transport info of carrier stream.
        * @param {Function} onSuccess  The function to call when success, the param is a TransportInfo object
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        */
        getTransportInfo: (onSuccess: (transportInfo: TransportInfo)=>void, onError?:(err: string)=>void)=>void;

        /**
        * Send outgoing data to remote peer.
        * If the stream is in multiplexing mode, application can not call this function.
        *
        * @param {Function} onSuccess  The function to call when success, the param is a Number: Bytes of data sent.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {base64}   data      The send data.
        */
        write: (data: string, onSuccess:(bytesSent: Number)=>void, onError?:(err: string)=>void)=>void;

        /**
        * Open a new channel on multiplexing stream.
        * If the stream is in multiplexing mode, application can not call this function.
        *
        * @param {Function} onSuccess  The function to call when success, the param is a Number: New channel ID.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {string}   cookie    The application defined data passed to remote peer
        */
        openChannel: (cookie: string, onSuccess:(channelId: Number)=>void, onError?:(err: string)=>void)=>void;

        /**
        * Close a new channel on multiplexing stream.
        * If the stream is in multiplexing mode, application can not call this function.
        *
        * @param {Function} onSuccess  The function to call when success.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {number}   channel   The channel ID to close
        */
        closeChannel: (channel: Number, onSuccess:()=>void, onError?:(err: string)=>void)=>void;

        /**
        * Send outgoing data to remote peer.
        * If the stream is in multiplexing mode, application can not call this function.
        *
        * @param {Function} onSuccess  The function to call when success, the param is a Number: Bytes of data sent.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {number} channel     The current channel ID.
        * @param {base64} data        The send data.
        */
        writeChannel: (channel: Number, data: string, onSuccess:(bytesSent: Number)=>void, onError?:(err: string)=>void)=>void;

        /**
        * Request remote peer to pend channel data sending.
        * If the stream is in multiplexing mode, application can not call this function.
        *
        * @param {Function} onSuccess  The function to call when success.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {number} channel     The current channel ID.
        */
        pendChannel: (channel: Number, onSuccess:()=>void, onError?:(err: string)=>void)=>void;

        /**
        * Request remote peer to resume channel data sending.
        * If the stream is in multiplexing mode, application can not call this function.
        *
        * @param {Function} onSuccess  The function to call when success.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {number} channel     The current channel ID.
        */
        resumeChannel: (channel: Number, onSuccess:()=>void, onError?:(err: string)=>void)=>void;

        /**
        * Open a port forwarding to remote service over multiplexing.
        * If the stream is in multiplexing mode, application can not call this function.
        *
        * @param {Function} onSuccess  The function to call when success, the param is a Number: Port forwarding ID.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {string}   service   The remote service name
        * @param {PortForwardingProtocol}  protocol    Port forwarding protocol
        * @param {string}   host      Local host or ip to binding. If host is null, port forwarding will bind to localhost
        * @param {number}   port      Local port to binding.
        */
        openPortForwarding: (service: string, protocol: PortForwardingProtocol,  host: string, port: Number, onSuccess:(portForwardingId: Number)=>void, onError?:(err: string)=>void)=>void;

        /**
        * Close a port forwarding.
        * If the stream is in multiplexing mode, application can not call this function.
        *
        * @param {Function} onSuccess  The function to call when success.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {number}   portForwarding  The portforwarding ID.
        */
        closePortForwarding: (portForwarding: Number, onSuccess:()=>void, onError?:(err: string)=>void)=>void;
    }

    /**
    * The class representing Carrier Session.
    * @class
    */
    interface Session {
        /** @property {string} peer The remote peer userid. **/
        peer: string;
        /** @property {Carrier} carrier Parent carrier object. */
        carrier: Carrier;

        /**
        * Close a session to friend. All resources include streams, channels, portforwardings
        * associated with current session will be destroyed.
        */
        close: (onSuccess?:()=>void, onError?:(err: string)=>void)=>void;

        /**
        * Send session request to the friend.
        *
        * @param {Function} onSuccess  The function to call when success.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {onSessionRequestComplete} handler A handler to the SessionRequestCompleteHandler to receive the session response
        */
        request: (handler: OnSessionRequestComplete, onSuccess:()=>void, onError?:(err: string)=>void)=>void;

        /**
        * Reply the session request from friend.
        *
        * This function will send a session response to friend.
        *
        * @param {Function} onSuccess  The function to call when success.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {number}   status     The status code of the response. 0 is success, otherwise is error
        * @param {string}   reason     The error message if status is error, or null if success
        */
        replyRequest: (status: Number, reason: string, onSuccess:()=>void, onError?:(err: string)=>void)=>void;

        /**
        * Begin to start a session.
        *
        * All streams in current session will try to connect with remote friend,
        * The stream status will update to application by stream's StreamHandler.
        *
        * @param {Function} onSuccess  The function to call when success.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {string}   sdp        The remote user's SDP.  Reference: https://tools.ietf.org/html/rfc4566
        */
        start: (sdp: string, onSuccess:()=>void, onError?:(err: string)=>void)=>void;

        /**
        * Add a new stream to session.
        *
        * Carrier stream supports several underlying transport mechanisms:
        *
        *   - Plain/encrypted UDP data gram protocol
        *   - Plain/encrypted TCP like reliable stream protocol
        *   - Multiplexing over UDP
        *   - Multiplexing over TCP like reliable protocol
        *
        *  Application can use options to specify the new stream mode.
        *  Multiplexing over UDP can not provide reliable transport.
        *
        * @param {Function} onSuccess  The function to call when success, the param is a Stream object: The new added carrier stream.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {StreamType} type     The stream type defined in StreamType
        * @param {number}   options    The stream mode options. options are constructed by a bitwise-inclusive OR of flags
        * @param {StreamCallbacks} callbacks The stream callbacks.
        */
        addStream: (type: StreamType, options: Number, callbacks: StreamCallbacks, onSuccess:(stream: Stream)=>void, onError?:(err: string)=>void)=>void;

        /**
        * Remove a stream from session.
        *
        * @param {Function} onSuccess  The function to call when success.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {stream}   stream     The Stream to be removed
        */
        removeStream: (stream: Stream, onSuccess:(stream: Stream)=>void, onError?:(err: string)=>void)=>void;

        /**
        * Add a new portforwarding service to session.
        *
        * The registered services can be used by remote peer in portforwarding request.
        *
        * @param {Function} onSuccess  The function to call when success.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {string}   service   The new service name, should be unique in session scope.
        * @param {PortForwardingProtocol}  protocol    The protocol of the service.
        * @param {string}   host      The host name or ip of the service.
        * @param {number}   port      The port of the service.
        */
        addService: (service: string, protocol: PortForwardingProtocol, host: string, port: Number, onSuccess:()=>void, onError?:(err: string)=>void)=>void;

        /**
        * Remove a portforwarding server to session.
        *
        * This function has not effect on existing portforwarings.
        *
        * @param {Function} onSuccess  The function to call when success.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {string}   service    The service name.
        */
        removeService: (service: string, onSuccess:()=>void, onError?:(err: string)=>void)=>void;
    }

    /**
    * The Carrier callbacks.
    *
    * @typedef CarrierCallbacks
    * @type {Object}
    */
    type CarrierCallbacks = {
        /**
        * The callback function to process the self connection status.
        *
        *@callback onConnection
        *
        * @param {Carrier}  carrier   Carrier node instance
        * @param {number}  status     Current connection status. @see ConnectionStatus
        */
        onConnection?: (carrier: Carrier, status: ConnectionStatus)=>void;

        /**
        * The callback function to process the ready notification.
        *
        * Application should wait this callback invoked before calling any
        * function to interact with friends.
        *
        * @callback onReady
        *
        * @param {Carrier}  carrier   Carrier node instance
        */
        onReady?: (carrier: Carrier)=>void;

        /**
        * The callback function to process the self info changed event.
        *
        * @callback onSelfInfoChanged
        *
        * @param {Carrier}   carrier  Carrier node instance
        * @param {UserInfo} userInfo  The updated user information
        */
        onSelfInfoChanged?: (carrier: Carrier, userInfo: UserInfo)=>void;

        /**
        * The callback function to iterate the each friend item in friend list.
        *
        * @callback onFriends
        *
        * @param {Carrier}  carrier   Carrier node instance
        * @param {Array}   friends  The friends list.
        */
        onFriends?: (carrier: Carrier, friends: FriendInfo[])=>void;

        /**
        * The callback function to process the friend connections status changed event.
        *
        * @callback onFriendConnection
        *
        * @param {Carrier}  carrier   Carrier node instance
        * @param {string}  friendId   The friend's user id.
        * @param {number}  status     The connection status of friend. @see ConnectionStatus
        */
        onFriendConnection?: (carrier: Carrier, friendId: string, status: ConnectionStatus)=>void;

        /**
        * The callback function to process the friend information changed event.
        *
        * @callback onFriendInfoChanged
        *
        * @param {Carrier}  carrier   Carrier node instance
        * @param {string}  friendId     The friend's user id
        * @param {FriendInfo}  info The update friend information
        */
        onFriendInfoChanged?: (carrier: Carrier, friendId: string, info: FriendInfo)=>void;

        /**
        * The callback function to process the friend presence changed event.
        *
        * @callback onFriendPresence
        *
        * @param {Carrier}  carrier   Carrier node instance
        * @param {string}  friendId     The friend's user id
        * @param {number}  presence The presence status of the friend
        */
        onFriendPresence?: (carrier: Carrier, friendId: string, presence: PresenceStatus)=>void;

        /**
        * The callback function to process the friend request.
        *
        * @callback onFriendRequest
        *
        * @param {Carrier}   carrier  Carrier node instance
        * @param {string}   userId      The user id who want be friend with current user
        * @param {UserInfo} info    The user information to `userId`
        * @param {string}   hello      The PIN for target user, or any application defined content
        */
        onFriendRequest?: (carrier: Carrier, userId: string, info: UserInfo, hello: string)=>void;

        /**
        * The callback function to process the new friend added event.
        *
        * @callback onFriendAdded
        *
        * @param {Carrier}      carrier   Carrier node instance
        * @param {FriendInfo}  friendInfo The added friend's information
        */
        onFriendAdded?: (carrier: Carrier, friendInfo: FriendInfo)=>void;

        /**
        * The callback function to process the friend removed event.
        *
        * @callback onFriendRemoved
        *
        * @param {Carrier}  carrier   Carrier node instance
        * @param {string}  friendId     The friend's user id
        */
        onFriendRemoved?: (carrier: Carrier, friendId: string)=>void;

        /**
        * The callback function to process the friend message.
        *
        * @callback onFriendMessage
        *
        * @param {Carrier}  carrier   Carrier node instance
        * @param {string}  from       The id from who send the message
        * @param {string}  message    The message content
        * @param {Boolean} isOffline  Whether this message sent as online message or
        *   offline message. The value of true means the message was sent as
        *   online message, otherwise as offline message.
        */
        onFriendMessage?: (carrier: Carrier, from: string, messate: string, isOffline: Boolean)=>void;

        /**
        * The callback function to process the friend invite request.
        *
        * @callback onFriendInviteRequest
        *
        * @param {Carrier}  carrier   Carrier node instance
        * @param {string}  from         The user id from who send the invite request
        * @param {string}  data         The application defined data sent from friend
        */
        onFriendInviteRequest?: (carrier: Carrier, from: string, data: string)=>void;
        
        /**
        * The callback function that handle session request.
        *
        * @callback onSessionRequest
        *
        * @param {Carrier}  carrier   Carrier node instance
        * @param {string}  from        The id who send the message
        * @param {string}  sdp         The remote users SDP. Reference: https://tools.ietf.org/html/rfc4566
        */
        onSessionRequest?: (carrier: Carrier, from: string, sdp: string)=>void;

        /**
        * The callback function that handle group invite.
        *
        * @callback onGroupInvite
        *
        * @param {Carrier}  carrier    Carrier node instance
        * @param {string}  groupTitle  Current group title
        */
        onGroupInvite?: (carrier: Carrier, groupTitle: string)=>void;

        /**
        * A callback function that handle file transfer connect request.
        *
        * @callback onConnectRequest
        *
        * @param {Carrier} carrier     Carrier node instance
        * @param {string}  from        The id who send the request
        * @param {FileTransferInfo} fileInfo    Information of the file which the requester wants to send
        */
        onConnectRequest?: (carrier: Carrier, from: string, fileInfo: FileTransferInfo)=>void;
    }

    /**
    * The class representing Carrier.
    * @class
    */
    interface Carrier {
        /** @property {string} nodeId Node id. **/
        nodeId: string;
        /** @property {string} userId User id. **/
        userId: string;
        /** @property {string} address Node address. **/
        address: string;

        callbacks: CarrierCallbacks;

        /**
        * Start carrier node asynchronously to connect to carrier network. If the connection
        * to network is successful, carrier node starts working.
        *
        * @param {Function} onSuccess  The function to call when success.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {number}   iterateInterval Internal loop interval, in milliseconds.
        */
        start: (iterateInterval: Number, onSuccess:()=>void, onError?:(err: string)=>void)=>void;

        /**
        * Get self user information.
        *
        * @param {Function} onSuccess  The function to call when success, the param is a UserInfo: the user information to the carrier node.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        */
        getSelfInfo: (onSuccess:(userInfo: UserInfo)=>void, onError?:(err: string)=>void)=>void;

        /**
        * Update self user information.
        * After self user information changed, carrier node will update this information
        * to carrier network, and thereupon network broadcasts the change to all friends.
        *
        * @param {Function} onSuccess  The function to call when success.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {UserInfo} userinfo   The user information to update for this carrier node.
        */
        setSelfInfo: (name: string, value: string, onSuccess:()=>void, onError?:(err: string)=>void)=>void;

        /**
        * Check if carrier node instance is being ready.
        *
        * All carrier interactive APIs should be called only if carrier node instance
        * is being ready.
        *
        * @param {Function} onSuccess  The function to call when success, the param is a Boolean: true if the carrier node instance is ready, or false if not.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        */
        isReady: (onSuccess:(ready: Boolean)=>void, onError?:(err: string)=>void)=>void;

        /**
        * Get friends list.
        *
        * @param {Function} onSuccess  The function to call when success, the param is a {friendId: info} Object: The list of friend information to current user.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        */
        getFriends: (onSuccess:(friends: FriendInfo[])=>void, onError?:(err: string)=>void)=>void;

        /**
        * Get specified friend information.
        *
        * @param {Function} onSuccess  The function to call when success, the param is a FriendInfo: The friend information.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {string}   userId    The user identifier of friend
        */
        getFriend: (userId: string, onSuccess:(friend: FriendInfo)=>void, onError?:(err: string)=>void)=>void;

        /**
        * Set the label of the specified friend.
        *
        * The label of a friend is a private alias name for current user. It can be
        * seen by current user only, and has no impact to the target friend itself.
        *
        * @param {Function} onSuccess  The function to call when success.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {string}   userId    The friend's user identifier
        * @param {string}   label   The new label of specified friend
        */
        labelFriend: (userId: string, label: string, onSuccess:()=>void, onError?:(err: string)=>void)=>void;

        /**
        * Check if the user ID is friend.
        *
        * @param {Function} onSuccess  The function to call when success, the param is a Boolean: True if the user is a friend, or false if not.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {string}   userId  The userId to check.
        */
        isFriend: (userId: string, onSuccess:(isFriend: Boolean)=>void, onError?:(err: string)=>void)=>void;

        /**
        * Add friend by sending a new friend request.
        *
        * This function will add a new friend with specific address, and then
        * send a friend request to the target node.
        *
        * @param {Function} onSuccess  The function to call when success.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {string}   address   the target user address of remote carrier node.
        * @param {string}   hello     PIN for target user, or any application defined content.
        */
        addFriend: (address: string, hello: string, onSuccess:()=>void, onError?:(err: string)=>void)=>void;

        /**
        * Accept the friend request.
        *
        * This function is used to add a friend in response to a friend request.
        *
        * @param {Function} onSuccess  The function to call when success.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {string}   userId  The user id who want be friend with us.
        */
        acceptFriend: (userId: string, onSuccess:()=>void, onError?:(err: string)=>void)=>void;

        /**
        * Remove a friend.
        *
        * This function will remove a friend on this carrier node.
        *
        * @param {Function} onSuccess  The function to call when success.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {string}   userId      The target user id to remove friendship
        */
        removeFriend: (userId: string, onSuccess:()=>void, onError?:(err: string)=>void)=>void;

        /**
        * Send a message to a friend.
        *
        * The message length may not exceed MAX_APP_MESSAGE_LEN, and message itself
        * should be text-formatted. Larger messages must be split by application
        * and sent as separate messages. Other nodes can reassemble the fragments.
        *
        * @param {Function} onSuccess  The function to call when success.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {string}   to    The target id
        * @param {string}   message The message content defined by application
        */
        sendFriendMessage: (to: string, message: string, onSuccess:()=>void, onError?:(err: string)=>void)=>void;

        /**
        * Send invite request to a friend.
        *
        * Application can attach the application defined data with in the invite
        * request, and the data will send to target friend.
        *
        * @param {Function} onSuccess  The function to call when success.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {string}   to      The target id
        * @param {string}   data    The application defined data send to target user
        * @param {onFriendInviteResponse}   handler The handler to receive invite reponse
        */
        inviteFriend: (to: string, data: string, handler: OnFriendInviteResponse, onSuccess:()=>void, onError?:(err: string)=>void)=>void;

        /**
        * Reply the friend invite request.
        *
        * This function will send a invite response to friend.
        *
        * @param {Function} onSuccess  The function to call when success.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {string}   to      The id who send invite request
        * @param {number}   status    The status code of the response. 0 is success, otherwise is error
        * @param {string}   reason    The error message if status is error, or null if success
        * @param {string}   data    The application defined data send to target user. If the status is error, this will be ignored
        */
        replyFriendInvite: (to: string, status: Number, reason: string, data: string, onSuccess:()=>void, onError?:(err: string)=>void)=>void;

        /**
        * Create a new group request.
        *
        * This function will create a new group.
        *
        * @param {Function} onSuccess  The function to call when success, the param is Group object.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        */
        newGroup: (callbacks: CarrierCallbacks, onSuccess:(group: Group)=>void, onError?:(err: string)=>void)=>void;

        /**
        * Join a group request.
        *
        * Join a group associating with cookie into which remote friend invites.
        *
        * @param {Function} onSuccess  The function to call when success, the param is Group object
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {string} friendId     The friend who send a group invitation
        * @param {string} cookieCode    The cookieCode information to join group,from onGroupInvite.
        */
        groupJoin: (friendId: string, cookieCode: string, callbacks: GroupCallbacks, onSuccess:(group: Group)=>void, onError?:(err: string)=>void)=>void;

        /**
        * Leave a group request.
        *
        * @param {Function} onSuccess  The function to call when success
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {Object} group      Group object
        */
        groupLeave: (group: Group, onSuccess:(group: Group)=>void, onError?:(err: string)=>void)=>void;

        /**
         * Get all Groups request.
         *
         * @param {Function} onSuccess  The function to call when success.The param is a group array object ,
         * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
         */
        getGroups: (onSuccess:(groups: Group[])=>void, onError?:(err: string)=>void)=>void;

        /**
        * Create a new file transfer to a friend.
        *
        * The file transfer object represent a conversation handle to a friend.
        *
        * @param {Function} onSuccess  The function to call when success.The param is fileTransfer instance,
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {string}   to         The target id(userid or userid@nodeid).
        * @param {FileTransferInfo} fileTransferInfo    Information of the file to be transferred.
        */
        newFileTransfer: (to:string, fileTransferInfo: FileTransferInfo, callbacks: FileTransferCallbacks, onSuccess?:(fileTransfer: FileTransfer)=>void, onError?:(err: String)=>void)=>void;
            
        /**
         * Generate unique file identifier with random algorithm.
         *
         * @param {Function} onSuccess  The function to call when success.The param is fileId,
         */
        generateFileId: (onSuccess: (fileId: Int)=>void)=>void;
            
        /**
        * Create a new session to a friend.
        *
        * The session object represent a conversation handle to a friend.
        *
        * @param {Function} onSuccess  The function to call when success, the param is a Session Object: The new Session object
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {string}   to         The target id(userid or userid@nodeid).
        */
        newSession: (to: string, onSuccess:(session: Session)=>void, onError?:(err: string)=>void)=>void;

        /**
        * Disconnect carrier node from carrier network, and destroy all associated resources to carreier node instance.
        * After calling the method, the carrier node instance becomes invalid.
        *
        * @param {Function} onSuccess  The function to call when success.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        */
        destroy: (onSuccess?:()=>void, onError?:(err: string)=>void)=>void;
    }

    type GroupCallbacks = {
        /**
        * The callback function that handle group connect status.
        *
        * @callback onGroupConnected
        *
        * @param {Group} group      The group instance .
        */
        onGroupConnected?: ()=>void ;

        /**
        * The callback function that handle group message.
        *
        * @callback onGroupMessage
        *
        * @param {Group} group      The group instance .
        * @param {string}  from        The friend's user id.
        * @param {string}  message     The message content
        */
        onGroupMessage?: (from: string, message: string)=>void;

        /**
        * The callback function that handle group title changed.
        *
        * @callback onGroupTitle
        *
        * @param {Group} group      The group instance .
        * @param {string}  from        The User id of the modifier
        * @param {string}  title       New group title
        */
        onGroupTitle?: (from: string, title: string)=>void;

        /**
        * The callback function that handle peer name changed.
        *
        * @callback onPeerName
        *
        * @param {Group} group      The group instance .
        * @param {string}  peerId      The peer's user id.
        * @param {string}  peerName    The peer's name.
        */
        onPeerName?: (peerId: string, peerName: string)=>void;

        /**
        * The callback function that handle peer list changed.
        *
        * @callback onPeerListChanged
        *
        * @param {Group} group      The group instance .
        */
        onPeerListChanged?: ()=>void;
    }

    /**
    * The class representing Group.
    * @class
    */
    interface Group {
        groupId: Int;
        callbacks: GroupCallbacks;

        /**
        * Invite a friend into group request.
        *
        * @param {Function} onSuccess  The function to call when success.The param is a string "Success!",
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {string} friendId     The friend's id
        */
        invite: (friendId: string, onSuccess:()=>void, onError?:(err: string)=>void)=>void;

        /**
        * Send a message to a group request.
        *
        * @param {Function} onSuccess  The function to call when success.The param is a string "Success!",
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {string} message      The message content defined by application
        */
        sendMessage: (message: string, onSuccess:()=>void, onError?:(err: string)=>void)=>void;

        /**
        * Get group title request.
        *
        * @param {Function} onSuccess  The function to call when success.The param is a string ,
        *                              group title information
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        */
        getTitle: (onSuccess:(groupTitle: string)=>void, onError?:(err: string)=>void)=>void;

        /**
        * Modify group title request.
        *
        * @param {Function} onSuccess  The function to call when success.The param is a json string ,
        *                              group title information,
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {string}  groupTitle  New group's title
        */
        setTitle: (groupTitle: string, onSuccess:(groupTitle: string)=>void, onError?:(err: string)=>void)=>void;

        /**
        * Get peers from Group request.
        *
        * @param {Function} onSuccess  The function to call when success.The param is a json string ,
        *                              group peers information ,
        *                              like this {"PEER_ID":{"peerName":"PEER_NAME","peerUserId":"PEER_ID"}}.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        */
        getPeers: (onSuccess:(peers: any)=>void, onError?:(err: string)=>void)=>void; // TODO: define a Peer type

        /**
        * Get a peer from Group request.
        *
        * @param {Function} onSuccess  The function to call when success.The param is a json string ,
        *                              a peer information ,
        *                              like this{"peerName":"PEER_NAME","peerUserId":"PEER_ID"}.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {string}   peerId    The peer's id
        */
        getPeer: (peerId: string, onSuccess:(peer: any)=>void, onError?:(err: string)=>void)=>void; // TODO: define a Peer type
    }

    enum FileTransferState {
        /** The file transfer connection is initialized. */
        Initialized = 1,
        /** The file transfer connection is connecting.*/
        Connecting = 2,
        /** The file transfer connection has been established. */
        Connected = 3,
        /** The file transfer connection is closed and disconnected. */
        Closed = 4,
        /** The file transfer connection failed with some reason. */
        Failed = 5
    }

    type FileTransferCallbacks = {
        /**
         * The callback function that handle the state changed event.
         * An application-defined function that handle the state changed event.
         *
         * @callback onStateChanged
         * @param {FileTransfer} fileTransfer   The fileTransfer instance .
         * @param {FileTransferState} state     The file transfer connection state.
         */
        onStateChanged?: (fileTransfer: FileTransfer, state: FileTransferState)=>void;

        /**
         * An application-defined function that handle transfer file request event.
         *
         * @callback onFileRequest
         *
         * @param {FileTransfer} fileTransfer   The fileTransfer instance .
         * @param {string} fileId    The file identifier.
         * @param {string} filename  The file name.
         * @param {Long}   size      The total file size.
         */
        onFileRequest?: (fileTransfer: FileTransfer, fileId: string, filename: string, size: Int)=>void;

        /**
         * An application-defined function that handle file transfer pull request
         * event.
         *
         * @callback onPullRequest
         *
         * @param {FileTransfer} fileTransfer   The fileTransfer instance .
         * @param {string} fileId  The unique identifier of transferring file.
         * @param {string} offset  The offset of file where transfer begins.
         */
        onPullRequest?: (fileTransfer: FileTransfer, fileId: string, offset: string)=>void;

        /**
         * An application-defined function that perform receiving data.
         *
         * @callback onData
         *
         * @param {FileTransfer} fileTransfer   The fileTransfer instance .
         * @param {string} fileId  The unique identifier of transferring file.
         * @param {string} data    The received data.
         */
        onData?: (fileTransfer: FileTransfer, fileId: string, data: string)=>void;

        /**
         * An application-defined function that handles the event of end of receiving data.
         *
         * @callback onDataFinished
         *
         * @param {FileTransfer} fileTransfer   The fileTransfer instance .
         * @param {string} fileId  The unique identifier of transferring file.
         */
        onDataFinished?: (fileTransfer: FileTransfer, fileId: string)=>void;

        /**
         * An application-defined function that handles pause file transfer
         * notification from the peer.
         *
         * @callback onPending
         *
         * @param {FileTransfer} fileTransfer   The fileTransfer instance .
         * @param {string} fileId  The unique identifier of transferring file.
         */
        onPending?: (fileTransfer: FileTransfer, fileId: string)=>void;

        /**
         * An application-defined function that handles resume file transfer
         * notification from the peer.
         *
         * @callback onResume
         *
         * @param {FileTransfer} fileTransfer   The fileTransfer instance .
         * @param {string} fileId  The unique identifier of transferring file.
         */
        onResume?: (fileTransfer: FileTransfer, fileId: string)=>void;

        /**
         * An application-defined function that handles cancel file transfer
         * notification from the peer.
         *
         * @callback onCancel
         *
         * @param {FileTransfer} fileTransfer   The fileTransfer instance .
         * @param {string} fileId  The unique identifier of transferring file.
         * @param {int}    status  Cancel transfer status code.
         * @param {string} reason  Cancel transfer reason.
         */
        onCancel?: (fileTransfer: FileTransfer, fileId: string, status: Int, reason: string)=>void;
    }

    /**
     * The class representing FileTransfer.
     * @class
     */
    interface FileTransfer {
        callbacks: FileTransferCallbacks;

        /**
         * Close file transfer instance.
         *
         * @param {Function} onSuccess  The function to call when success.The param is a string "Success!",
         * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
         *
         */
        close: (onSuccess?: ()=>void, onError?: (err:string)=>void)=>void;

        /**
         * Get an unique file identifier of specified file.
         * Each file has its unique file id used between two peers.
         *
         * @param {string}   filename   The target file name.
         * @param {Function} onSuccess  The function to call when success.The param is fileId,
         * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
         *
         */
        getFileId: (filename: string, onSuccess?: (fileId: string)=>void, onError?: (err:string)=>void)=>void;

        /**
         * Get file name by file id.
         * Each file has its unique file id used between two peers.
         *
         * @param {string}   fileId     The target file identifier.
         * @param {Function} onSuccess  The function to call when success.The param is filename,
         * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
         */
        getFileName: (fileId: string, onSuccess?: (filename: string)=>void, onError?: (err:string)=>void)=>void;

        /**
         * Send a file transfer connect request to target peer.
         *
         * @param {Function} onSuccess  The function to call when success.The param is a string "Success!",
         * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
         *
         */
        connect: (onSuccess?: ()=>void, onError?: (err:string)=>void)=>void;

        /**
         * Accept file transfer connection request.
         *
         * @param {Function} onSuccess  The function to call when success.The param is a string "Success!",
         * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
         *
         */
        acceptConnect: (onSuccess?: ()=>void, onError?: (err:string)=>void)=>void;

        /**
         * Add a file to queue of file transfer.
         *
         * @param {Object} fileinfo  Information of the file to be added.
         * @param {Function} onSuccess  The function to call when success.The param is a string "Success!",
         * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
         */
        addFile: (fileInfo: FileTransferInfo, onSuccess?: ()=>void, onError?: (err:string)=>void)=>void;

        /**
         * To send pull request to transfer file with specified fileId.
         *
         * @param {string}   fileId     The file identifier.
         * @param {Long}     offset     The offset of file where transfer begins.
         * @param {Function} onSuccess  The function to call when success.The param is a string "Success!",
         * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
         */
        pullData: (fileId: string, offset: Int, onSuccess?: ()=>void, onError?: (err:string)=>void)=>void;

        /**
         * To transfer file data with specified fileId.
         *
         * @param {Function} onSuccess  The function to call when success.The param is a string "Success!",
         * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
         * @param {string}   fileId     The file identifier.
         * @param {string}   data       The data to transfer for file.
         */
        writeData: (fileId: string, data: string, onSuccess?: ()=>void, onError?: (err:string)=>void)=>void;

        /**
         * Finish transferring file with specified fileId(only available to sender).
         *
         * @param {string}   fileId     The file identifier.
         * @param {Function} onSuccess  The function to call when success.The param is a string "Success!",
         * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
         */
        sendFinish: (fileId: string, onSuccess?: ()=>void, onError?: (err:string)=>void)=>void;

        /**
         * Cancel transferring file with specified fileId(only available to receiver).
         *
         * @param {string}   fileId     The file identifier.
         * @param {Function} onSuccess  The function to call when success.The param is a string "Success!",
         * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
         */
        cancelTransfer: (fileId: string, status: Int, reason: string, onSuccess?: ()=>void, onError?: (err:string)=>void)=>void;

        /**
         * Pend transferring file with specified fileId.
         *
         * @param {string}   fileId     The file identifier.
         * @param {Function} onSuccess  The function to call when success.The param is a string "Success!",
         * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
         */
        pendTransfer: (fileId: string, onSuccess?: ()=>void, onError?: (err:string)=>void)=>void;

        /**
         * Resume transferring file with specified fileId.
         *
         * @param {string}   fileId     The file identifier.
         * @param {Function} onSuccess  The function to call when success.The param is a string "Success!",
         * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
         */
        resumeTransfer: (fileId: string, onSuccess?: ()=>void, onError?: (err:string)=>void)=>void;
    }

    /**
    * @description
    * Carrier node connection status to the carrier network.
    *
    * @enum {number}
    */
    enum ConnectionStatus {
        /** Carrier node connected to the carrier network. */
        CONNECTED=0,
        /** There is no connection to the carrier network. */
        DISCONNECTED=1
    }

    /**
    * @description
    * Carrier node presence status.
    *
    * @enum {number}
    */
    enum PresenceStatus {
        /** Carrier node is online and available. */
        NONE=0,
        /** Carrier node is being away. */
        AWAY=1,
        /** Carrier node is being busy. */
        BUSY=2
    }

    /**
    * @description
    * Carrier stream type. Reference: https://tools.ietf.org/html/rfc4566#section-5.14 https://tools.ietf.org/html/rfc4566#section-8
    *
    * @enum {number}
    */
    enum StreamType {
        /** Audio stream. */
        AUDIO=0,
        /** Video stream. */
        VIDEO=1,
        /** Text stream. */
        TEXT=2,
        /** Application stream. */
        APPLICATION=3,
        /** Message stream. */
        MESSAGE=4
    }

    /**
    * @description
    * Carrier stream state The stream state will be changed according to the phase of the stream.
    *
    * @enum {number}
    */
    enum StreamState {
        /** Raw stream. */
        RAW=0,
        /** Initialized stream. */
        INITIALIZED=1,
        /** The underlying transport is ready for the stream to start. */
        TRANSPORT_READY=2,
        /** The stream is trying to connect the remote. */
        CONNECTING=3,
        /** The stream connected with remove peer. */
        CONNECTED=4,
        /** The stream is deactived. */
        DEACTIVATED=5,
        /** The stream closed gracefully. */
        CLOSED=6,
        /** The stream is on error, cannot to continue. */
        ERROR=7
    }

    /**
    * @description
    * Carrier Stream's candidate type.
    *
    * @enum {number}
    */
    enum CandidateType {
        /** Host candidate. */
        HOST=0,
        /** Server reflexive, only valid to ICE transport. */
        SERVER_REFLEXIVE=1,
        /** Peer reflexive, only valid to ICE transport. */
        PEER_REFLEXIVE=2,
        /** Relayed Candidate, only valid to ICE tranport. */
        RELAYED=3,
    }
        
    /**
    * @description
    * Carrier network topology for session peers related to each other.
    *
    * @enum {number}
    */
    enum NetworkTopology {
        /** LAN network topology. */
        LAN=0,
        /** P2P network topology. */
        P2P=1,
        /** Relayed netowrk topology. */
        RELAYED=2
    }
        
    /**
    * @description
    * Port forwarding supported protocols.
    *
    * @enum {number}
    */
    enum PortForwardingProtocol {
        /** TCP protocol. */
        TCP=1
    }

    /**
    * @description
    * Multiplexing channel close reason mode.
    *
    * @enum {number}
    */
    enum CloseReason {
        /** Channel closed normaly. */
        NORMAL=0,
        /** Channel closed because of timeout. */
        TIMEOUT=1,
        /** Channel closed because error occured. */
        ERROR=2
    }
    
    /**
    * @description
    * Carrier stream mode.
    *
    * @enum {number}
    */
    enum StreamMode {
        /**
        * Compress option, indicates data would be compressed before transmission.
        * For now, just reserved this bit option for future implement.
        */
        COMPRESS=1,
        /**
        * Encrypt option, indicates data would be transmitted with plain mode.
        * which means that transmitting data would be encrypted in default.
        */
        PLAIN=2,
        /**
        * Relaible option, indicates data transmission would be reliable, and be
        * guranteed to received by remote peer, which acts as TCP transmission
        * protocol. Without this option bitwised, the transmission would be
        * unreliable as UDP transmission protocol.
        */
        RELIABLE=4,
        /**
        * Multiplexing option, indicates multiplexing would be activated on
        * enstablished stream, and need to use multipexing APIs related with channel
        * instread of APIs related strema to send/receive data.
        */
        MULTIPLEXING=8,
        /**
        * PortForwarding option, indicates port forwarding would be activated
        * on established stream. This options should bitwise with 'Multiplexing'
        * option.
        */
        PORT_FORWARDING=16
    }

    interface CarrierManager {
        /**
        * Get current version of Carrier node.
        *
        * @param {Function} onSuccess  The function to call when success, the param is a string: The version of carrier node.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        */
        getVersion: (onSuccess:(version: string)=>void, onError?:(err: string)=>void)=>void;

        /**
        * Check if the ID is Carrier node id.
        *
        * @param {string}   id       The carrier node id to be check.
        * @param {Function} onSuccess  The function to call when success, the param is a Boolean: True if id is valid, otherwise false.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        */
        isValidId: (id: string, onSuccess:(isValid: Boolean)=>void, onError?:(err: string)=>void)=>void;

        /**
        * Check if the carrier node address is valid.
        *
        * @param {string}   address    The carrier node address to be check.
        * @param {Function} onSuccess  The function to call when success, the param is a Boolean: True if key is valid, otherwise false.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        */
        isValidAddress: (address: string, onSuccess:(isValid: Boolean)=>void, onError?:(err: string)=>void)=>void;

        /**
        * Get carrier ID from carrier node address.
        *
        * @param {Function} onSuccess  The function to call when success, the param is a string: User id if address is valid, otherwise null.
        * @param {Function} [onError]  The function to call when error, the param is a string. Or set to null.
        * @param {string}   address    The carrier node address.
        */
        getIdFromAddress: (address: string, onSuccess:(userId: string)=>void, onError?:(err: string)=>void)=>void;

        /**
        * Create a carrier object instance. After initializing the instance,
        * it's ready to start and therefore connect to carrier network.
        *
        * @param {CarrierCallbacks} callbacks The callbacks for carrier node.
        * @param {Options}   [options]   The options to set for creating carrier node. If set to null, will use default.
        * @param {Function}  [onSuccess]  The function to call when success.
        * @param {Function}  [onError]  The function to call when error, the param is a string. Or set to null.
        */
        createObject: (callbacks: CarrierCallbacks, options?: any, onSuccess?:(carrier: Carrier)=>void, onError?:(err: string)=>void)=>void; // TODO: need a type for options
    }
}
