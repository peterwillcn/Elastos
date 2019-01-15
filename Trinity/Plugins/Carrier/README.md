---
title: Carrier
description: The carrier javascript API.
---

# elastos-trinity-plugins-carrier

This plugin defines a global `cordova.carrierPlugin` object, which provides an API for carrier library.

Although in the global scope, it is not available until after the `deviceready` event.

```js
document.addEventListener("deviceready", onDeviceReady, false);
function onDeviceReady() {
    console.log(carrierPlugin);
}
```
---

## Installation

```bash
    cordova plugin add elastos-trinity-plugins-carrier
```

## Supported Platforms

- Android
- iOS

# API Reference <a name="reference"></a>

## Modules

<dl>
<dt><a href="#module_carrierPlugin">carrierPlugin</a></dt>
<dd></dd>
</dl>

## Classes

<dl>
<dt><a href="#Stream">Stream</a></dt>
<dd></dd>
<dt><a href="#Session">Session</a></dt>
<dd></dd>
<dt><a href="#Carrier">Carrier</a></dt>
<dd></dd>
</dl>

## Typedefs

<dl>
<dt><a href="#BootstrapNode">BootstrapNode</a> : <code>Object</code></dt>
<dd><p>The Carrier user information.</p>
</dd>
<dt><a href="#Options">Options</a> : <code>Object</code></dt>
<dd><p>Options defines several settings that control the way the Carrier node connects to the carrier network.
Default values are not defined for bootstraps options, so application should be set bootstrap nodes clearly.</p>
</dd>
<dt><a href="#UserInfo">UserInfo</a> : <code>Object</code></dt>
<dd><p>The Carrier user information.</p>
</dd>
<dt><a href="#FriendInfo">FriendInfo</a> : <code>Object</code></dt>
<dd><p>The Carrier friend information.</p>
</dd>
<dt><a href="#AddressInfo">AddressInfo</a> : <code>Object</code></dt>
<dd><p>The netword address information.</p>
</dd>
<dt><a href="#TransportInfo">TransportInfo</a> : <code>Object</code></dt>
<dd><p>The netword transport information.</p>
</dd>
<dt><a href="#CarrierCallbacks">CarrierCallbacks</a> : <code>Object</code></dt>
<dd><p>The Carrier callbacks.</p>
</dd>
<dt><a href="#StreamCallbacks">StreamCallbacks</a> : <code>Object</code></dt>
<dd><p>The Stream callbacks.</p>
</dd>
<dt><a href="#onFriendInviteResponse">onFriendInviteResponse</a> : <code>function</code></dt>
<dd><p>The callback function to process the friend invite response.</p>
</dd>
<dt><a href="#onSessionRequestComplete">onSessionRequestComplete</a> : <code>function</code></dt>
<dd><p>The callback function to receive session request complete event.</p>
</dd>
<dt><a href="#onStateChanged">onStateChanged</a> : <code>function</code></dt>
<dd><p>The callback function to report state of stream when it&#39;s state changes.</p>
</dd>
<dt><a href="#onStreamData">onStreamData</a> : <code>function</code></dt>
<dd><p>The callback will be called when the stream receives incoming packet.
If the stream enabled multiplexing mode, application will not
receive stream-layered data callback any more. All data will reported
as multiplexing channel data.</p>
</dd>
<dt><a href="#onChannelOpen">onChannelOpen</a> : <code>function</code></dt>
<dd><p>The callback function to be called when new multiplexing channel request to open.</p>
</dd>
<dt><a href="#onChannelOpened">onChannelOpened</a> : <code>function</code></dt>
<dd><p>The callback function to be called when new multiplexing channel opened.</p>
</dd>
<dt><a href="#onChannelClose">onChannelClose</a> : <code>function</code></dt>
<dd><p>The callback function to be called when channel close.</p>
</dd>
<dt><a href="#onChannelData">onChannelData</a> : <code>function</code></dt>
<dd><p>The callback functiont to be called when channel received incoming data.</p>
</dd>
<dt><a href="#onChannelPending">onChannelPending</a> : <code>function</code></dt>
<dd><p>The callback function to be called when remote peer ask to pend data sending.</p>
</dd>
<dt><a href="#onChannelResume">onChannelResume</a> : <code>function</code></dt>
<dd><p>The callback function to be called when remote peer ask to resume data sending.</p>
</dd>
<dt><a href="#onConnection">onConnection</a> : <code>function</code></dt>
<dd><p>The callback function to process the self connection status.</p>
</dd>
<dt><a href="#onReady">onReady</a> : <code>function</code></dt>
<dd><p>The callback function to process the ready notification.</p>
<p>Application should wait this callback invoked before calling any
function to interact with friends.</p>
</dd>
<dt><a href="#onSelfInfoChanged">onSelfInfoChanged</a> : <code>function</code></dt>
<dd><p>The callback function to process the self info changed event.</p>
</dd>
<dt><a href="#onFriends">onFriends</a> : <code>function</code></dt>
<dd><p>The callback function to iterate the each friend item in friend list.</p>
</dd>
<dt><a href="#onFriendConnection">onFriendConnection</a> : <code>function</code></dt>
<dd><p>The callback function to process the friend connections status changed event.</p>
</dd>
<dt><a href="#onFriendInfoChanged">onFriendInfoChanged</a> : <code>function</code></dt>
<dd><p>The callback function to process the friend information changed event.</p>
</dd>
<dt><a href="#onFriendPresence">onFriendPresence</a> : <code>function</code></dt>
<dd><p>The callback function to process the friend presence changed event.</p>
</dd>
<dt><a href="#onFriendRequest">onFriendRequest</a> : <code>function</code></dt>
<dd><p>The callback function to process the friend request.</p>
</dd>
<dt><a href="#onFriendAdded">onFriendAdded</a> : <code>function</code></dt>
<dd><p>The callback function to process the new friend added event.</p>
</dd>
<dt><a href="#onFriendRemoved">onFriendRemoved</a> : <code>function</code></dt>
<dd><p>The callback function to process the friend removed event.</p>
</dd>
<dt><a href="#onFriendMessage">onFriendMessage</a> : <code>function</code></dt>
<dd><p>The callback function to process the friend message.</p>
</dd>
<dt><a href="#onFriendInviteRequest">onFriendInviteRequest</a> : <code>function</code></dt>
<dd><p>The callback function to process the friend invite request.</p>
</dd>
<dt><a href="#onSessionRequest">onSessionRequest</a> : <code>function</code></dt>
<dd><p>The callback function that handle session request.</p>
</dd>
</dl>

<a name="module_carrierPlugin"></a>

## carrierPlugin

* [carrierPlugin](#module_carrierPlugin)
    * [.ConnectionStatus](#module_carrierPlugin+ConnectionStatus) : <code>enum</code>
    * [.PresenceStatus](#module_carrierPlugin+PresenceStatus) : <code>enum</code>
    * [.StreamType](#module_carrierPlugin+StreamType) : <code>enum</code>
    * [.StreamState](#module_carrierPlugin+StreamState) : <code>enum</code>
    * [.CandidateType](#module_carrierPlugin+CandidateType) : <code>enum</code>
    * [.NetworkTopology](#module_carrierPlugin+NetworkTopology) : <code>enum</code>
    * [.PortForwardingProtocol](#module_carrierPlugin+PortForwardingProtocol) : <code>enum</code>
    * [.CloseReason](#module_carrierPlugin+CloseReason) : <code>enum</code>
    * [.StreamMode](#module_carrierPlugin+StreamMode) : <code>enum</code>
    * [.getVersion(onSuccess, [onError], onSuccess)](#module_carrierPlugin+getVersion)
    * [.isValidId(onSuccess, [onError], id)](#module_carrierPlugin+isValidId)
    * [.isValidAddress(onSuccess, [onError], address)](#module_carrierPlugin+isValidAddress)
    * [.getIdFromAddress(onSuccess, [onError], address)](#module_carrierPlugin+getIdFromAddress)
    * [.createObject(onSuccess, [onError], [options], callbacks)](#module_carrierPlugin+createObject)

<a name="module_carrierPlugin+ConnectionStatus"></a>

### carrierPlugin.ConnectionStatus : <code>enum</code>
Carrier node connection status to the carrier network.

**Kind**: instance enum of [<code>carrierPlugin</code>](#module_carrierPlugin)  
**Properties**

| Name | Type | Default | Description |
| --- | --- | --- | --- |
| CONNECTED | <code>number</code> | <code>0</code> | Carrier node connected to the carrier network. |
| DISCONNECTED | <code>number</code> | <code>1</code> | There is no connection to the carrier network. |

<a name="module_carrierPlugin+PresenceStatus"></a>

### carrierPlugin.PresenceStatus : <code>enum</code>
Carrier node presence status.

**Kind**: instance enum of [<code>carrierPlugin</code>](#module_carrierPlugin)  
**Properties**

| Name | Type | Default | Description |
| --- | --- | --- | --- |
| NONE | <code>number</code> | <code>0</code> | Carrier node is online and available. |
| AWAY | <code>number</code> | <code>1</code> | Carrier node is being away. |
| BUSY | <code>number</code> | <code>2</code> | Carrier node is being busy. |

<a name="module_carrierPlugin+StreamType"></a>

### carrierPlugin.StreamType : <code>enum</code>
Carrier stream type. Reference: https://tools.ietf.org/html/rfc4566#section-5.14 https://tools.ietf.org/html/rfc4566#section-8

**Kind**: instance enum of [<code>carrierPlugin</code>](#module_carrierPlugin)  
**Properties**

| Name | Type | Default | Description |
| --- | --- | --- | --- |
| AUDIO | <code>number</code> | <code>0</code> | Audio stream. |
| VIDEO | <code>number</code> | <code>1</code> | Video stream. |
| TEXT | <code>number</code> | <code>2</code> | Text stream. |
| APPLICATION | <code>number</code> | <code>3</code> | Application stream. |
| MESSAGE | <code>number</code> | <code>4</code> | Message stream. |

<a name="module_carrierPlugin+StreamState"></a>

### carrierPlugin.StreamState : <code>enum</code>
Carrier stream state The stream state will be changed according to the phase of the stream.

**Kind**: instance enum of [<code>carrierPlugin</code>](#module_carrierPlugin)  
**Properties**

| Name | Type | Default | Description |
| --- | --- | --- | --- |
| RAW | <code>number</code> | <code>0</code> | Raw stream. |
| INITIALIZED | <code>number</code> | <code>1</code> | Initialized stream. |
| TRANSPORT_READY | <code>number</code> | <code>2</code> | The underlying transport is ready for the stream to start. |
| CONNECTING | <code>number</code> | <code>3</code> | The stream is trying to connect the remote. |
| CONNECTED | <code>number</code> | <code>4</code> | The stream connected with remove peer. |
| DEACTIVATED | <code>number</code> | <code>5</code> | The stream is deactived. |
| CLOSED | <code>number</code> | <code>6</code> | The stream closed gracefully. |
| ERROR | <code>number</code> | <code>7</code> | The stream is on error, cannot to continue. |

<a name="module_carrierPlugin+CandidateType"></a>

### carrierPlugin.CandidateType : <code>enum</code>
Carrier Stream's candidate type.

**Kind**: instance enum of [<code>carrierPlugin</code>](#module_carrierPlugin)  
**Properties**

| Name | Type | Default | Description |
| --- | --- | --- | --- |
| HOST | <code>number</code> | <code>0</code> | Host candidate. |
| SERVE_RREFLEXIVE | <code>number</code> | <code>1</code> | Server reflexive, only valid to ICE transport. |
| PEER_REFLEXIVE | <code>number</code> | <code>2</code> | Peer reflexive, only valid to ICE transport. |
| RELAYED | <code>number</code> | <code>3</code> | Relayed Candidate, only valid to ICE tranport. |

<a name="module_carrierPlugin+NetworkTopology"></a>

### carrierPlugin.NetworkTopology : <code>enum</code>
Carrier network topology for session peers related to each other.

**Kind**: instance enum of [<code>carrierPlugin</code>](#module_carrierPlugin)  
**Properties**

| Name | Type | Default | Description |
| --- | --- | --- | --- |
| LAN | <code>number</code> | <code>0</code> | LAN network topology. |
| P2P | <code>number</code> | <code>1</code> | P2P network topology. |
| RELAYED | <code>number</code> | <code>2</code> | Relayed netowrk topology. |

<a name="module_carrierPlugin+PortForwardingProtocol"></a>

### carrierPlugin.PortForwardingProtocol : <code>enum</code>
Port forwarding supported protocols.

**Kind**: instance enum of [<code>carrierPlugin</code>](#module_carrierPlugin)  
**Properties**

| Name | Type | Default | Description |
| --- | --- | --- | --- |
| TCP | <code>number</code> | <code>1</code> | TCP protocol. |

<a name="module_carrierPlugin+CloseReason"></a>

### carrierPlugin.CloseReason : <code>enum</code>
Multiplexing channel close reason mode.

**Kind**: instance enum of [<code>carrierPlugin</code>](#module_carrierPlugin)  
**Properties**

| Name | Type | Default | Description |
| --- | --- | --- | --- |
| NORMAL | <code>number</code> | <code>0</code> | Channel closed normaly. |
| TIMEOUT | <code>number</code> | <code>1</code> | Channel closed because of timeout. |
| ERROR | <code>number</code> | <code>2</code> | Channel closed because error occured. |

<a name="module_carrierPlugin+StreamMode"></a>

### carrierPlugin.StreamMode : <code>enum</code>
Carrier stream mode.

**Kind**: instance enum of [<code>carrierPlugin</code>](#module_carrierPlugin)  
**Properties**

| Name | Type | Default | Description |
| --- | --- | --- | --- |
| COMPRESS | <code>number</code> | <code>1</code> | Compress option, indicates data would be compressed before transmission. For now, just reserved this bit option for future implement. |
| PLAIN | <code>number</code> | <code>2</code> | Encrypt option, indicates data would be transmitted with plain mode. which means that transmitting data would be encrypted in default. |
| RELIABLE | <code>number</code> | <code>4</code> | Relaible option, indicates data transmission would be reliable, and be guranteed to received by remote peer, which acts as TCP transmission protocol. Without this option bitwised, the transmission would be unreliable as UDP transmission protocol. |
| MULTIPLEXING | <code>number</code> | <code>8</code> | Multiplexing option, indicates multiplexing would be activated on enstablished stream, and need to use multipexing APIs related with channel instread of APIs related strema to send/receive data. |
| PORT_FORWARDING | <code>number</code> | <code>16</code> | PortForwarding option, indicates port forwarding would be activated on established stream. This options should bitwise with 'Multiplexing' option. |

<a name="module_carrierPlugin+getVersion"></a>

### carrierPlugin.getVersion(onSuccess, [onError], onSuccess)
Get current version of Carrier node.

**Kind**: instance method of [<code>carrierPlugin</code>](#module_carrierPlugin)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success, the param is a String: The version of carrier node. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |
| onSuccess | <code>callback</code> | The version of carrier node |

<a name="module_carrierPlugin+isValidId"></a>

### carrierPlugin.isValidId(onSuccess, [onError], id)
Check if the ID is Carrier node id.

**Kind**: instance method of [<code>carrierPlugin</code>](#module_carrierPlugin)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success, the param is a Boolean: True if id is valid, otherwise false. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |
| id | <code>string</code> | The carrier node id to be check. |

<a name="module_carrierPlugin+isValidAddress"></a>

### carrierPlugin.isValidAddress(onSuccess, [onError], address)
Check if the carrier node address is valid.

**Kind**: instance method of [<code>carrierPlugin</code>](#module_carrierPlugin)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success, the param is a Boolean: True if key is valid, otherwise false. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |
| address | <code>string</code> | The carrier node address to be check. |

<a name="module_carrierPlugin+getIdFromAddress"></a>

### carrierPlugin.getIdFromAddress(onSuccess, [onError], address)
Get carrier ID from carrier node address.

**Kind**: instance method of [<code>carrierPlugin</code>](#module_carrierPlugin)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success, the param is a String: User id if address is valid, otherwise null. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |
| address | <code>string</code> | The carrier node address. |

<a name="module_carrierPlugin+createObject"></a>

### carrierPlugin.createObject(onSuccess, [onError], [options], callbacks)
Create a carrier object instance. After initializing the instance,
it's ready to start and therefore connect to carrier network.

**Kind**: instance method of [<code>carrierPlugin</code>](#module_carrierPlugin)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |
| [options] | [<code>Options</code>](#Options) | The options to set for creating carrier node. If set to null, will use default. |
| callbacks | [<code>CarrierCallbacks</code>](#CarrierCallbacks) | The callbacks for carrier node. |

<a name="Stream"></a>

## Stream
**Kind**: global class  

* [Stream](#Stream)
    * [new Stream()](#new_Stream_new)
    * [.id](#Stream+id)
    * [.transportInfo](#Stream+transportInfo)
    * [.carrier](#Stream+carrier)
    * [.session](#Stream+session)
    * [.on(name, callback)](#Stream+on)
    * [.write(onSuccess, [onError], data)](#Stream+write)
    * [.openChannel(onSuccess, [onError], cookie)](#Stream+openChannel)
    * [.closeChannel(onSuccess, [onError], channel)](#Stream+closeChannel)
    * [.writeChannel(onSuccess, [onError], channel, data)](#Stream+writeChannel)
    * [.pendChannel(onSuccess, [onError], channel)](#Stream+pendChannel)
    * [.resumeChannel(onSuccess, [onError], channel)](#Stream+resumeChannel)
    * [.openPortForwarding(onSuccess, [onError], service, protocol, host, port)](#Stream+openPortForwarding)
    * [.closePortForwarding(onSuccess, [onError], portForwarding)](#Stream+closePortForwarding)

<a name="new_Stream_new"></a>

### new Stream()
The class representing Carrier stream.

<a name="Stream+id"></a>

### stream.id
**Kind**: instance property of [<code>Stream</code>](#Stream)  
**Properties**

| Name | Type | Description |
| --- | --- | --- |
| id | <code>number</code> | Stream ID. |

<a name="Stream+transportInfo"></a>

### stream.transportInfo
**Kind**: instance property of [<code>Stream</code>](#Stream)  
**Properties**

| Name | Type | Description |
| --- | --- | --- |
| transportInfo | [<code>TransportInfo</code>](#TransportInfo) | Tranport info |

<a name="Stream+carrier"></a>

### stream.carrier
**Kind**: instance property of [<code>Stream</code>](#Stream)  
**Properties**

| Name | Type | Description |
| --- | --- | --- |
| carrier | [<code>Carrier</code>](#Carrier) | Parent carrier object. |

<a name="Stream+session"></a>

### stream.session
**Kind**: instance property of [<code>Stream</code>](#Stream)  
**Properties**

| Name | Type | Description |
| --- | --- | --- |
| session | [<code>Session</code>](#Session) | Parent session object. |

<a name="Stream+on"></a>

### stream.on(name, callback)
Add or remove Stream callback.

**Kind**: instance method of [<code>Stream</code>](#Stream)  

| Param | Type | Description |
| --- | --- | --- |
| name | <code>string</code> | The callback name. |
| callback | <code>function</code> | The function to add or change callback function. If set to null, will remove callback. |

<a name="Stream+write"></a>

### stream.write(onSuccess, [onError], data)
Send outgoing data to remote peer.
If the stream is in multiplexing mode, application can not call this function.

**Kind**: instance method of [<code>Stream</code>](#Stream)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success, the param is a Number: Bytes of data sent. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |
| data | <code>base64</code> | The send data. |

<a name="Stream+openChannel"></a>

### stream.openChannel(onSuccess, [onError], cookie)
Open a new channel on multiplexing stream.
If the stream is in multiplexing mode, application can not call this function.

**Kind**: instance method of [<code>Stream</code>](#Stream)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success, the param is a Number: New channel ID. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |
| cookie | <code>string</code> | The application defined data passed to remote peer |

<a name="Stream+closeChannel"></a>

### stream.closeChannel(onSuccess, [onError], channel)
Close a new channel on multiplexing stream.
If the stream is in multiplexing mode, application can not call this function.

**Kind**: instance method of [<code>Stream</code>](#Stream)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |
| channel | <code>number</code> | The channel ID to close |

<a name="Stream+writeChannel"></a>

### stream.writeChannel(onSuccess, [onError], channel, data)
Send outgoing data to remote peer.
If the stream is in multiplexing mode, application can not call this function.

**Kind**: instance method of [<code>Stream</code>](#Stream)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success, the param is a Number: Bytes of data sent. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |
| channel | <code>number</code> | The current channel ID. |
| data | <code>base64</code> | The send data. |

<a name="Stream+pendChannel"></a>

### stream.pendChannel(onSuccess, [onError], channel)
Request remote peer to pend channel data sending.
If the stream is in multiplexing mode, application can not call this function.

**Kind**: instance method of [<code>Stream</code>](#Stream)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |
| channel | <code>number</code> | The current channel ID. |

<a name="Stream+resumeChannel"></a>

### stream.resumeChannel(onSuccess, [onError], channel)
Request remote peer to resume channel data sending.
If the stream is in multiplexing mode, application can not call this function.

**Kind**: instance method of [<code>Stream</code>](#Stream)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |
| channel | <code>number</code> | The current channel ID. |

<a name="Stream+openPortForwarding"></a>

### stream.openPortForwarding(onSuccess, [onError], service, protocol, host, port)
Open a port forwarding to remote service over multiplexing.
If the stream is in multiplexing mode, application can not call this function.

**Kind**: instance method of [<code>Stream</code>](#Stream)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success, the param is a Number: Port forwarding ID. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |
| service | <code>string</code> | The remote service name |
| protocol | <code>PortForwardingProtocol</code> | Port forwarding protocol |
| host | <code>string</code> | Local host or ip to binding. If host is null, port forwarding will bind to localhost |
| port | <code>number</code> | Local port to binding. |

<a name="Stream+closePortForwarding"></a>

### stream.closePortForwarding(onSuccess, [onError], portForwarding)
Close a port forwarding.
If the stream is in multiplexing mode, application can not call this function.

**Kind**: instance method of [<code>Stream</code>](#Stream)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |
| portForwarding | <code>number</code> | The portforwarding ID. |

<a name="Session"></a>

## Session
**Kind**: global class  

* [Session](#Session)
    * [new Session()](#new_Session_new)
    * [.peer](#Session+peer)
    * [.carrier](#Session+carrier)
    * [.close()](#Session+close)
    * [.request(onSuccess, [onError], handler)](#Session+request)
    * [.replyRequest(onSuccess, [onError], status, reason)](#Session+replyRequest)
    * [.start(onSuccess, [onError], sdp)](#Session+start)
    * [.addStream(onSuccess, [onError], type, options, callbacks)](#Session+addStream)
    * [.removeStream(onSuccess, [onError], stream)](#Session+removeStream)
    * [.addService(onSuccess, [onError], service, protocol, host, port)](#Session+addService)
    * [.removeService(onSuccess, [onError], service)](#Session+removeService)

<a name="new_Session_new"></a>

### new Session()
The class representing Carrier Session.

<a name="Session+peer"></a>

### session.peer
**Kind**: instance property of [<code>Session</code>](#Session)  
**Properties**

| Name | Type | Description |
| --- | --- | --- |
| peer | <code>string</code> | The remote peer userid. |

<a name="Session+carrier"></a>

### session.carrier
**Kind**: instance property of [<code>Session</code>](#Session)  
**Properties**

| Name | Type | Description |
| --- | --- | --- |
| carrier | [<code>Carrier</code>](#Carrier) | Parent carrier object. |

<a name="Session+close"></a>

### session.close()
Close a session to friend. All resources include streams, channels, portforwardings
associated with current session will be destroyed.

**Kind**: instance method of [<code>Session</code>](#Session)  
<a name="Session+request"></a>

### session.request(onSuccess, [onError], handler)
Send session request to the friend.

**Kind**: instance method of [<code>Session</code>](#Session)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |
| handler | [<code>onSessionRequestComplete</code>](#onSessionRequestComplete) | A handler to the SessionRequestCompleteHandler to receive the session response |

<a name="Session+replyRequest"></a>

### session.replyRequest(onSuccess, [onError], status, reason)
Reply the session request from friend.

This function will send a session response to friend.

**Kind**: instance method of [<code>Session</code>](#Session)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |
| status | <code>number</code> | The status code of the response. 0 is success, otherwise is error |
| reason | <code>string</code> | The error message if status is error, or null if success |

<a name="Session+start"></a>

### session.start(onSuccess, [onError], sdp)
Begin to start a session.

All streams in current session will try to connect with remote friend,
The stream status will update to application by stream's StreamHandler.

**Kind**: instance method of [<code>Session</code>](#Session)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |
| sdp | <code>string</code> | The remote user's SDP.  Reference: https://tools.ietf.org/html/rfc4566 |

<a name="Session+addStream"></a>

### session.addStream(onSuccess, [onError], type, options, callbacks)
Add a new stream to session.

Carrier stream supports several underlying transport mechanisms:

  - Plain/encrypted UDP data gram protocol
  - Plain/encrypted TCP like reliable stream protocol
  - Multiplexing over UDP
  - Multiplexing over TCP like reliable protocol

 Application can use options to specify the new stream mode.
 Multiplexing over UDP can not provide reliable transport.

**Kind**: instance method of [<code>Session</code>](#Session)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success, the param is a Stream object: The new added carrier stream. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |
| type | <code>StreamType</code> | The stream type defined in StreamType |
| options | <code>number</code> | The stream mode options. options are constructed by a bitwise-inclusive OR of flags |
| callbacks | [<code>StreamCallbacks</code>](#StreamCallbacks) | The stream callbacks. |

<a name="Session+removeStream"></a>

### session.removeStream(onSuccess, [onError], stream)
Remove a stream from session.

**Kind**: instance method of [<code>Session</code>](#Session)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |
| stream | <code>stream</code> | The Stream to be removed |

<a name="Session+addService"></a>

### session.addService(onSuccess, [onError], service, protocol, host, port)
Add a new portforwarding service to session.

The registered services can be used by remote peer in portforwarding request.

**Kind**: instance method of [<code>Session</code>](#Session)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |
| service | <code>string</code> | The new service name, should be unique in session scope. |
| protocol | <code>PortForwardingProtocol</code> | The protocol of the service. |
| host | <code>string</code> | The host name or ip of the service. |
| port | <code>number</code> | The port of the service. |

<a name="Session+removeService"></a>

### session.removeService(onSuccess, [onError], service)
Remove a portforwarding server to session.

This function has not effect on existing portforwarings.

**Kind**: instance method of [<code>Session</code>](#Session)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |
| service | <code>string</code> | The service name. |

<a name="Carrier"></a>

## Carrier
**Kind**: global class  

* [Carrier](#Carrier)
    * [new Carrier()](#new_Carrier_new)
    * [.nodeId](#Carrier+nodeId)
    * [.userId](#Carrier+userId)
    * [.address](#Carrier+address)
    * [.nospam](#Carrier+nospam)
    * [.presence](#Carrier+presence)
    * [.on(name, callback)](#Carrier+on)
    * [.start(onSuccess, [onError], iterateInterval)](#Carrier+start)
    * [.getSelfInfo(onSuccess, [onError])](#Carrier+getSelfInfo)
    * [.setSelfInfo(onSuccess, [onError], userinfo)](#Carrier+setSelfInfo)
    * [.isReady(onSuccess, [onError])](#Carrier+isReady)
    * [.getFriends(onSuccess, [onError])](#Carrier+getFriends)
    * [.getFriend(onSuccess, [onError], userId)](#Carrier+getFriend)
    * [.labelFriend(onSuccess, [onError], userId, label)](#Carrier+labelFriend)
    * [.isFriend(onSuccess, [onError], userId)](#Carrier+isFriend)
    * [.addFriend(onSuccess, [onError], address, hello)](#Carrier+addFriend)
    * [.acceptFriend(onSuccess, [onError], userId)](#Carrier+acceptFriend)
    * [.removeFriend(onSuccess, [onError], userId)](#Carrier+removeFriend)
    * [.sendFriendMessage(onSuccess, [onError], to, message)](#Carrier+sendFriendMessage)
    * [.inviteFriend(onSuccess, [onError], to, data, handler)](#Carrier+inviteFriend)
    * [.replyFriendInvite(onSuccess, [onError], to, status, reason, data)](#Carrier+replyFriendInvite)
    * [.newSession(onSuccess, [onError], to)](#Carrier+newSession)
    * [.destroy(onSuccess, [onError])](#Carrier+destroy)

<a name="new_Carrier_new"></a>

### new Carrier()
The class representing Carrier.

<a name="Carrier+nodeId"></a>

### carrier.nodeId
**Kind**: instance property of [<code>Carrier</code>](#Carrier)  
**Properties**

| Name | Type | Description |
| --- | --- | --- |
| nodeId | <code>string</code> | Node id. |

<a name="Carrier+userId"></a>

### carrier.userId
**Kind**: instance property of [<code>Carrier</code>](#Carrier)  
**Properties**

| Name | Type | Description |
| --- | --- | --- |
| userId | <code>string</code> | User id. |

<a name="Carrier+address"></a>

### carrier.address
**Kind**: instance property of [<code>Carrier</code>](#Carrier)  
**Properties**

| Name | Type | Description |
| --- | --- | --- |
| address | <code>string</code> | Node address. |

<a name="Carrier+nospam"></a>

### carrier.nospam
**Kind**: instance property of [<code>Carrier</code>](#Carrier)  
**Properties**

| Name | Type | Description |
| --- | --- | --- |
| nospam | <code>number</code> | The nospam for Carrier address is used to eliminate spam friend. |

<a name="Carrier+presence"></a>

### carrier.presence
**Kind**: instance property of [<code>Carrier</code>](#Carrier)  
**Properties**

| Name | Type | Description |
| --- | --- | --- |
| presence | <code>number</code> | Presence status. |

<a name="Carrier+on"></a>

### carrier.on(name, callback)
Add or remove Carrier callback.

**Kind**: instance method of [<code>Carrier</code>](#Carrier)  

| Param | Type | Description |
| --- | --- | --- |
| name | <code>string</code> | The callback name. |
| callback | <code>function</code> | The function to add or change callback function. If set to null, will remove callback. |

<a name="Carrier+start"></a>

### carrier.start(onSuccess, [onError], iterateInterval)
Start carrier node asynchronously to connect to carrier network. If the connection
to network is successful, carrier node starts working.

**Kind**: instance method of [<code>Carrier</code>](#Carrier)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |
| iterateInterval | <code>number</code> | Internal loop interval, in milliseconds. |

<a name="Carrier+getSelfInfo"></a>

### carrier.getSelfInfo(onSuccess, [onError])
Get self user information.

**Kind**: instance method of [<code>Carrier</code>](#Carrier)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success, the param is a UserInfo: the user information to the carrier node. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |

<a name="Carrier+setSelfInfo"></a>

### carrier.setSelfInfo(onSuccess, [onError], userinfo)
Update self user information.
After self user information changed, carrier node will update this information
to carrier network, and thereupon network broadcasts the change to all friends.

**Kind**: instance method of [<code>Carrier</code>](#Carrier)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |
| userinfo | [<code>UserInfo</code>](#UserInfo) | The user information to update for this carrier node. |

<a name="Carrier+isReady"></a>

### carrier.isReady(onSuccess, [onError])
Check if carrier node instance is being ready.

All carrier interactive APIs should be called only if carrier node instance
is being ready.

**Kind**: instance method of [<code>Carrier</code>](#Carrier)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success, the param is a Boolean: true if the carrier node instance is ready, or false if not. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |

<a name="Carrier+getFriends"></a>

### carrier.getFriends(onSuccess, [onError])
Get friends list.

**Kind**: instance method of [<code>Carrier</code>](#Carrier)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success, the param is a {friendId: info} Object: The list of friend information to current user. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |

<a name="Carrier+getFriend"></a>

### carrier.getFriend(onSuccess, [onError], userId)
Get specified friend information.

**Kind**: instance method of [<code>Carrier</code>](#Carrier)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success, the param is a FriendInfo: The friend information. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |
| userId | <code>string</code> | The user identifier of friend |

<a name="Carrier+labelFriend"></a>

### carrier.labelFriend(onSuccess, [onError], userId, label)
Set the label of the specified friend.

The label of a friend is a private alias name for current user. It can be
seen by current user only, and has no impact to the target friend itself.

**Kind**: instance method of [<code>Carrier</code>](#Carrier)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |
| userId | <code>string</code> | The friend's user identifier |
| label | <code>string</code> | The new label of specified friend |

<a name="Carrier+isFriend"></a>

### carrier.isFriend(onSuccess, [onError], userId)
Check if the user ID is friend.

**Kind**: instance method of [<code>Carrier</code>](#Carrier)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success, the param is a Boolean: True if the user is a friend, or false if not. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |
| userId | <code>string</code> | The userId to check. |

<a name="Carrier+addFriend"></a>

### carrier.addFriend(onSuccess, [onError], address, hello)
Add friend by sending a new friend request.

This function will add a new friend with specific address, and then
send a friend request to the target node.

**Kind**: instance method of [<code>Carrier</code>](#Carrier)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |
| address | <code>string</code> | the target user address of remote carrier node. |
| hello | <code>string</code> | PIN for target user, or any application defined content. |

<a name="Carrier+acceptFriend"></a>

### carrier.acceptFriend(onSuccess, [onError], userId)
Accept the friend request.

This function is used to add a friend in response to a friend request.

**Kind**: instance method of [<code>Carrier</code>](#Carrier)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |
| userId | <code>string</code> | The user id who want be friend with us. |

<a name="Carrier+removeFriend"></a>

### carrier.removeFriend(onSuccess, [onError], userId)
Remove a friend.

This function will remove a friend on this carrier node.

**Kind**: instance method of [<code>Carrier</code>](#Carrier)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |
| userId | <code>string</code> | The target user id to remove friendship |

<a name="Carrier+sendFriendMessage"></a>

### carrier.sendFriendMessage(onSuccess, [onError], to, message)
Send a message to a friend.

The message length may not exceed MAX_APP_MESSAGE_LEN, and message itself
should be text-formatted. Larger messages must be split by application
and sent as separate messages. Other nodes can reassemble the fragments.

**Kind**: instance method of [<code>Carrier</code>](#Carrier)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |
| to | <code>string</code> | The target id |
| message | <code>string</code> | The message content defined by application |

<a name="Carrier+inviteFriend"></a>

### carrier.inviteFriend(onSuccess, [onError], to, data, handler)
Send invite request to a friend.

Application can attach the application defined data with in the invite
request, and the data will send to target friend.

**Kind**: instance method of [<code>Carrier</code>](#Carrier)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |
| to | <code>string</code> | The target id |
| data | <code>string</code> | The application defined data send to target user |
| handler | [<code>onFriendInviteResponse</code>](#onFriendInviteResponse) | The handler to receive invite reponse |

<a name="Carrier+replyFriendInvite"></a>

### carrier.replyFriendInvite(onSuccess, [onError], to, status, reason, data)
Reply the friend invite request.

This function will send a invite response to friend.

**Kind**: instance method of [<code>Carrier</code>](#Carrier)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |
| to | <code>string</code> | The id who send invite request |
| status | <code>number</code> | The status code of the response. 0 is success, otherwise is error |
| reason | <code>string</code> | The error message if status is error, or null if success |
| data | <code>string</code> | The application defined data send to target user. If the status is error, this will be ignored |

<a name="Carrier+newSession"></a>

### carrier.newSession(onSuccess, [onError], to)
Create a new session to a friend.

The session object represent a conversation handle to a friend.

**Kind**: instance method of [<code>Carrier</code>](#Carrier)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success, the param is a Session Object: The new Session object |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |
| to | <code>string</code> | The target id(userid or userid@nodeid). |

<a name="Carrier+destroy"></a>

### carrier.destroy(onSuccess, [onError])
Disconnect carrier node from carrier network, and destroy all associated resources to carreier node instance.
After calling the method, the carrier node instance becomes invalid.

**Kind**: instance method of [<code>Carrier</code>](#Carrier)  

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |

<a name="BootstrapNode"></a>

## BootstrapNode : <code>Object</code>
The Carrier user information.

**Kind**: global typedef  
**Properties**

| Name | Type | Description |
| --- | --- | --- |
| ipv4 | <code>string</code> | The server ipv4. |
| ipv6 | <code>string</code> | The server ipv6. |
| port | <code>string</code> | The server port. |
| publicKey | <code>string</code> | The publicKey. |

<a name="Options"></a>

## Options : <code>Object</code>
Options defines several settings that control the way the Carrier node connects to the carrier network.
Default values are not defined for bootstraps options, so application should be set bootstrap nodes clearly.

**Kind**: global typedef  
**Properties**

| Name | Type | Description |
| --- | --- | --- |
| udpEnabled | <code>Boolean</code> | Set to use udp transport or not. Setting this value to false will force carrier node to TCP only,                                which will potentially slow down the message to run through. |
| persistentLocation | <code>string</code> | Set the persistent data location. The location must be set. |
| bootstraps | <code>Array</code> | BootstrapNode Array. |

<a name="UserInfo"></a>

## UserInfo : <code>Object</code>
The Carrier user information.

**Kind**: global typedef  
**Properties**

| Name | Type | Description |
| --- | --- | --- |
| userId | <code>string</code> | The user ID. |
| name | <code>string</code> | The nickname. |
| description | <code>string</code> | user's brief description. |
| hasAvatar | <code>Boolean</code> | Has avatar or not. |
| gender | <code>string</code> | The gender. |
| phone | <code>string</code> | The phone number. |
| email | <code>string</code> | The email address. |
| region | <code>string</code> | The region. |

<a name="FriendInfo"></a>

## FriendInfo : <code>Object</code>
The Carrier friend information.

**Kind**: global typedef  
**Properties**

| Name | Type | Description |
| --- | --- | --- |
| userInfo | [<code>UserInfo</code>](#UserInfo) | The user info. |
| presence | <code>PresenceStatus</code> | The presence status. |
| connection | <code>ConnectionStatus</code> | The connection status. |
| label | <code>string</code> | The friend's label name. |

<a name="AddressInfo"></a>

## AddressInfo : <code>Object</code>
The netword address information.

**Kind**: global typedef  
**Properties**

| Name | Type | Description |
| --- | --- | --- |
| type | <code>CandidateType</code> | The address type. |
| address | <code>string</code> | The address. |
| port | <code>string</code> | The port. |
| [relatedAddress] | <code>string</code> | The related address status. |
| [relatedPort] | <code>string</code> | The related port. |

<a name="TransportInfo"></a>

## TransportInfo : <code>Object</code>
The netword transport information.

**Kind**: global typedef  
**Properties**

| Name | Type | Description |
| --- | --- | --- |
| topology | <code>NetworkTopology</code> | The network topology. |
| localAddr | [<code>AddressInfo</code>](#AddressInfo) | The local address. |
| remoteAddr | [<code>AddressInfo</code>](#AddressInfo) | The remote address. |

<a name="CarrierCallbacks"></a>

## CarrierCallbacks : <code>Object</code>
The Carrier callbacks.

**Kind**: global typedef  
**Properties**

| Name | Type | Description |
| --- | --- | --- |
| onConnection | [<code>onConnection</code>](#onConnection) | The callback function to process the self connection status. |
| onReady | [<code>onReady</code>](#onReady) | The callback function to process the ready notification. |
| onSelfInfoChanged | [<code>onSelfInfoChanged</code>](#onSelfInfoChanged) | The callback function to process the self info changed event. |
| onFriends | [<code>onFriends</code>](#onFriends) | The callback function to iterate the each friend item in friend list. |
| onFriendConnection | [<code>onFriendConnection</code>](#onFriendConnection) | The callback function to process the friend connections status changed event. |
| onFriendInfoChanged | [<code>onFriendInfoChanged</code>](#onFriendInfoChanged) | The callback function to process the friend information changed event. |
| onFriendPresence | [<code>onFriendPresence</code>](#onFriendPresence) | The callback function to process the friend presence changed event. |
| onFriendRequest | [<code>onFriendRequest</code>](#onFriendRequest) | The callback function to process the friend request. |
| onFriendAdded | [<code>onFriendAdded</code>](#onFriendAdded) | The callback function to process the new friend added event. |
| onFriendRemoved | [<code>onFriendRemoved</code>](#onFriendRemoved) | The callback function to process the friend removed event. |
| onFriendMessage | [<code>onFriendMessage</code>](#onFriendMessage) | The callback function to process the friend message. |
| onFriendInviteRequest | [<code>onFriendInviteRequest</code>](#onFriendInviteRequest) | The callback function to process the friend invite request. |
| onSessionRequest | [<code>onSessionRequest</code>](#onSessionRequest) | The callback function that handle session request. |

<a name="StreamCallbacks"></a>

## StreamCallbacks : <code>Object</code>
The Stream callbacks.

**Kind**: global typedef  
**Properties**

| Name | Type | Description |
| --- | --- | --- |
| onStateChanged | [<code>onStateChanged</code>](#onStateChanged) | The callback function to report state of stream when it's state changes. |
| onStreamData | [<code>onStreamData</code>](#onStreamData) | The callback will be called when the stream receives incoming packet. |
| onChannelOpen | [<code>onChannelOpen</code>](#onChannelOpen) | The callback function to be called when new multiplexing channel opened. |
| onChannelOpened | [<code>onChannelOpened</code>](#onChannelOpened) | The callback function to be called when new multiplexing channel opened. |
| onChannelClose | [<code>onChannelClose</code>](#onChannelClose) | The callback function to be called when channel close. |
| onChannelData | [<code>onChannelData</code>](#onChannelData) | The callback functiont to be called when channel received incoming data. |
| onChannelPending | [<code>onChannelPending</code>](#onChannelPending) | The callback function to be called when remote peer ask to pend data sending. |
| onChannelResume | [<code>onChannelResume</code>](#onChannelResume) | The callback function to be called when remote peer ask to resume data sending. |

<a name="onFriendInviteResponse"></a>

## onFriendInviteResponse : <code>function</code>
The callback function to process the friend invite response.

**Kind**: global typedef  

| Param | Type | Description |
| --- | --- | --- |
| from | <code>string</code> | The target user id who send friend invite response |
| status | <code>number</code> | The status code of invite response. 0 is success, otherwise error |
| reason | <code>string</code> | The error message if status is error, otherwise null |
| data | <code>string</code> | The application defined data return by target user |

<a name="onSessionRequestComplete"></a>

## onSessionRequestComplete : <code>function</code>
The callback function to receive session request complete event.

**Kind**: global typedef  

| Param | Type | Description |
| --- | --- | --- |
| session | [<code>Session</code>](#Session) | The carrier session instance. |
| status | <code>number</code> | The status code of the response. 0 is success, otherwise is error. |
| reason | <code>string</code> | The error message if status is error, or nil if session request error happened. |
| sdp | <code>string</code> | The remote users SDP. Reference: https://tools.ietf.org/html/rfc4566 |

<a name="onStateChanged"></a>

## onStateChanged : <code>function</code>
The callback function to report state of stream when it's state changes.

**Kind**: global typedef  

| Param | Type | Description |
| --- | --- | --- |
| stream | [<code>Stream</code>](#Stream) | The carrier stream instance |
| state | <code>StreamState</code> | Stream state defined in StreamState |

<a name="onStreamData"></a>

## onStreamData : <code>function</code>
The callback will be called when the stream receives incoming packet.
If the stream enabled multiplexing mode, application will not
receive stream-layered data callback any more. All data will reported
as multiplexing channel data.

**Kind**: global typedef  

| Param | Type | Description |
| --- | --- | --- |
| stream | [<code>Stream</code>](#Stream) | The carrier stream instance |
| data | <code>base64</code> | The received packet data. |

<a name="onChannelOpen"></a>

## onChannelOpen : <code>function</code>
The callback function to be called when new multiplexing channel request to open.

**Kind**: global typedef  

| Param | Type | Description |
| --- | --- | --- |
|  |  |  |
| stream | [<code>Stream</code>](#Stream) | The carrier stream instance |
| channel | <code>number</code> | The current channel ID. |
| cookie | <code>string</code> | Application defined string data send from remote peer. |

<a name="onChannelOpened"></a>

## onChannelOpened : <code>function</code>
The callback function to be called when new multiplexing channel opened.

**Kind**: global typedef  

| Param | Type | Description |
| --- | --- | --- |
| stream | [<code>Stream</code>](#Stream) | The carrier stream instance |
| channel | <code>number</code> | The current channel ID. |

<a name="onChannelClose"></a>

## onChannelClose : <code>function</code>
The callback function to be called when channel close.

**Kind**: global typedef  

| Param | Type | Description |
| --- | --- | --- |
| stream | [<code>Stream</code>](#Stream) | The carrier stream instance |
| channel | <code>number</code> | The current channel ID. |
| reason | <code>string</code> | Channel close reason code, defined in CloseReason. |

<a name="onChannelData"></a>

## onChannelData : <code>function</code>
The callback functiont to be called when channel received incoming data.

**Kind**: global typedef  

| Param | Type | Description |
| --- | --- | --- |
| stream | [<code>Stream</code>](#Stream) | The carrier stream instance |
| channel | <code>number</code> | The current channel ID. |
| data | <code>base64</code> | The received packet data. |

<a name="onChannelPending"></a>

## onChannelPending : <code>function</code>
The callback function to be called when remote peer ask to pend data sending.

**Kind**: global typedef  

| Param | Type | Description |
| --- | --- | --- |
| stream | [<code>Stream</code>](#Stream) | The carrier stream instance |
| channel | <code>number</code> | The current channel ID. |

<a name="onChannelResume"></a>

## onChannelResume : <code>function</code>
The callback function to be called when remote peer ask to resume data sending.

**Kind**: global typedef  

| Param | Type | Description |
| --- | --- | --- |
| stream | [<code>Stream</code>](#Stream) | The carrier stream instance |
| channel | <code>number</code> | The current channel ID. |

<a name="onConnection"></a>

## onConnection : <code>function</code>
The callback function to process the self connection status.

**Kind**: global typedef  

| Param | Type | Description |
| --- | --- | --- |
| carrier | [<code>Carrier</code>](#Carrier) | Carrier node instance |
| status | <code>number</code> | Current connection status. @see ConnectionStatus |

<a name="onReady"></a>

## onReady : <code>function</code>
The callback function to process the ready notification.

Application should wait this callback invoked before calling any
function to interact with friends.

**Kind**: global typedef  

| Param | Type | Description |
| --- | --- | --- |
| carrier | [<code>Carrier</code>](#Carrier) | Carrier node instance |

<a name="onSelfInfoChanged"></a>

## onSelfInfoChanged : <code>function</code>
The callback function to process the self info changed event.

**Kind**: global typedef  

| Param | Type | Description |
| --- | --- | --- |
| carrier | [<code>Carrier</code>](#Carrier) | Carrier node instance |
| userInfo | [<code>UserInfo</code>](#UserInfo) | The updated user information |

<a name="onFriends"></a>

## onFriends : <code>function</code>
The callback function to iterate the each friend item in friend list.

**Kind**: global typedef  

| Param | Type | Description |
| --- | --- | --- |
| carrier | [<code>Carrier</code>](#Carrier) | Carrier node instance |
| friends | <code>Array</code> | The friends list. |

<a name="onFriendConnection"></a>

## onFriendConnection : <code>function</code>
The callback function to process the friend connections status changed event.

**Kind**: global typedef  

| Param | Type | Description |
| --- | --- | --- |
| carrier | [<code>Carrier</code>](#Carrier) | Carrier node instance |
| friendId | <code>string</code> | The friend's user id. |
| status | <code>number</code> | The connection status of friend. @see ConnectionStatus |

<a name="onFriendInfoChanged"></a>

## onFriendInfoChanged : <code>function</code>
The callback function to process the friend information changed event.

**Kind**: global typedef  

| Param | Type | Description |
| --- | --- | --- |
| carrier | [<code>Carrier</code>](#Carrier) | Carrier node instance |
| friendId | <code>string</code> | The friend's user id |
| info | [<code>FriendInfo</code>](#FriendInfo) | The update friend information |

<a name="onFriendPresence"></a>

## onFriendPresence : <code>function</code>
The callback function to process the friend presence changed event.

**Kind**: global typedef  

| Param | Type | Description |
| --- | --- | --- |
| carrier | [<code>Carrier</code>](#Carrier) | Carrier node instance |
| friendId | <code>string</code> | The friend's user id |
| presence | <code>number</code> | The presence status of the friend |

<a name="onFriendRequest"></a>

## onFriendRequest : <code>function</code>
The callback function to process the friend request.

**Kind**: global typedef  

| Param | Type | Description |
| --- | --- | --- |
| carrier | [<code>Carrier</code>](#Carrier) | Carrier node instance |
| userId | <code>string</code> | The user id who want be friend with current user |
| info | [<code>UserInfo</code>](#UserInfo) | The user information to `userId` |
| hello | <code>string</code> | The PIN for target user, or any application defined content |

<a name="onFriendAdded"></a>

## onFriendAdded : <code>function</code>
The callback function to process the new friend added event.

**Kind**: global typedef  

| Param | Type | Description |
| --- | --- | --- |
| carrier | [<code>Carrier</code>](#Carrier) | Carrier node instance |
| friendInfo | [<code>FriendInfo</code>](#FriendInfo) | The added friend's information |

<a name="onFriendRemoved"></a>

## onFriendRemoved : <code>function</code>
The callback function to process the friend removed event.

**Kind**: global typedef  

| Param | Type | Description |
| --- | --- | --- |
| carrier | [<code>Carrier</code>](#Carrier) | Carrier node instance |
| friendId | <code>string</code> | The friend's user id |

<a name="onFriendMessage"></a>

## onFriendMessage : <code>function</code>
The callback function to process the friend message.

**Kind**: global typedef  

| Param | Type | Description |
| --- | --- | --- |
| carrier | [<code>Carrier</code>](#Carrier) | Carrier node instance |
| from | <code>string</code> | The id from who send the message |
| message | <code>string</code> | The message content |

<a name="onFriendInviteRequest"></a>

## onFriendInviteRequest : <code>function</code>
The callback function to process the friend invite request.

**Kind**: global typedef  

| Param | Type | Description |
| --- | --- | --- |
| carrier | [<code>Carrier</code>](#Carrier) | Carrier node instance |
| from | <code>string</code> | The user id from who send the invite request |
| data | <code>string</code> | The application defined data sent from friend |

<a name="onSessionRequest"></a>

## onSessionRequest : <code>function</code>
The callback function that handle session request.

**Kind**: global typedef  

| Param | Type | Description |
| --- | --- | --- |
| carrier | [<code>Carrier</code>](#Carrier) | Carrier node instance |
| from | <code>string</code> | The id who send the message |
| sdp | <code>string</code> | The remote users SDP. Reference: https://tools.ietf.org/html/rfc4566 |


