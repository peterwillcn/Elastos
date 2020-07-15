## Classes

<dl>
<dt><a href="#AppManager">AppManager</a></dt>
<dd></dd>
</dl>

## Typedefs

<dl>
<dt><a href="#Icon">Icon</a> : <code>Object</code></dt>
<dd><p>The icons info.</p>
</dd>
<dt><a href="#PluginAuthority">PluginAuthority</a> : <code>Object</code></dt>
<dd><p>The plugin authority status.</p>
</dd>
<dt><a href="#UrlAuthority">UrlAuthority</a> : <code>Object</code></dt>
<dd><p>The access url authority status.</p>
</dd>
<dt><a href="#AppInfo">AppInfo</a> : <code>Object</code></dt>
<dd><p>The App information.</p>
</dd>
<dt><a href="#onReceiveMessage">onReceiveMessage</a> : <code>function</code></dt>
<dd><p>The callback function to receive message.</p>
</dd>
<dt><a href="#onReceiveIntent">onReceiveIntent</a> : <code>function</code></dt>
<dd><p>The callback function to receive message.</p>
</dd>
</dl>

<a name="AppManager"></a>

## AppManager
**Kind**: global class

* [AppManager](#AppManager)
    * [new AppManager()](#new_AppManager_new)
    * [.MessageType](#AppManager+MessageType) : <code>enum</code>
    * [.AuthorityStatus](#AppManager+AuthorityStatus) : <code>enum</code>
    * [.getLocale(onSuccess)](#AppManager+getLocale)
    * [.setCurrentLocale(code, onSuccess, [onError])](#AppManager+setCurrentLocale)
    * [.install(url, update, onSuccess, [onError])](#AppManager+install)
    * [.unInstall(id, onSuccess, [onError])](#AppManager+unInstall)
    * [.getInfo(onSuccess, [onError])](#AppManager+getInfo)
    * [.getAppInfo(id, onSuccess, [onError])](#AppManager+getAppInfo)
    * [.getAppInfos(onSuccess)](#AppManager+getAppInfos)
    * [.start(id, onSuccess, [onError])](#AppManager+start)
    * [.launcher(onSuccess, [onError])](#AppManager+launcher)
    * [.close(onSuccess, [onError])](#AppManager+close)
    * [.closeApp(id, onSuccess, [onError])](#AppManager+closeApp)
    * [.sendMessage(id, type, msg, onSuccess, [onError])](#AppManager+sendMessage)
    * [.setListener(callback)](#AppManager+setListener)
    * [.getRunningList(onSuccess)](#AppManager+getRunningList)
    * [.getAppList(onSuccess)](#AppManager+getAppList)
    * [.getLastList(onSuccess)](#AppManager+getLastList)
    * [.setPluginAuthority(id, plugin, authority, onSuccess, [onError])](#AppManager+setPluginAuthority)
    * [.setUrlAuthority(id, url, authority, onSuccess, [onError])](#AppManager+setUrlAuthority)
    * [.alertPrompt(title, message)](#AppManager+alertPrompt)
    * [.infoPrompt(title, message)](#AppManager+infoPrompt)
    * [.askPrompt(title, message, onOK)](#AppManager+askPrompt)
    * [.sendIntent(action, params, onSuccess, [onError])](#AppManager+sendIntent)
    * [.sendUrlIntent(url, onSuccess, [onError])](#AppManager+sendUrlIntent)
    * [.setIntentListener(callback)](#AppManager+setIntentListener)
    * [.sendIntentResponse(action, result, intentId, onSuccess, [onError])](#AppManager+sendIntentResponse)

<a name="new_AppManager_new"></a>

### new AppManager()
The class representing dapp manager for launcher.

<a name="AppManager+MessageType"></a>

### appManager.MessageType : <code>enum</code>
Message type to send or receive.

**Kind**: instance enum of [<code>AppManager</code>](#AppManager)
**Properties**

| Name | Type | Default | Description |
| --- | --- | --- | --- |
| INTERNAL | <code>number</code> | <code>1</code> | The internal message |
| IN_RETURN | <code>number</code> | <code>2</code> | The internal return message. |
| EXTERNAL_LAUNCHER | <code>number</code> | <code>3</code> | The external launcher message |
| EXTERNAL_INSTALL | <code>number</code> | <code>4</code> | The external install message |
| EX_RETURN | <code>number</code> | <code>5</code> | The external return message. |

<a name="AppManager+AuthorityStatus"></a>

### appManager.AuthorityStatus : <code>enum</code>
Message type to send or receive.

**Kind**: instance enum of [<code>AppManager</code>](#AppManager)
**Properties**

| Name | Type | Default | Description |
| --- | --- | --- | --- |
| NOINIT | <code>number</code> | <code>0</code> | Not initialise |
| ASK | <code>number</code> | <code>1</code> | Ask for authority. |
| ALLOW | <code>number</code> | <code>2</code> | Allow the authority. |
| DENY | <code>number</code> | <code>3</code> | Deny the authority. |

<a name="AppManager+getLocale"></a>

### appManager.getLocale(onSuccess)
Get locale.

**Kind**: instance method of [<code>AppManager</code>](#AppManager)

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call.the param include 'defaultLang' and 'systemLang'. |

<a name="AppManager+setCurrentLocale"></a>

### appManager.setCurrentLocale(code, onSuccess, [onError])
Set current locale.

**Kind**: instance method of [<code>AppManager</code>](#AppManager)

| Param | Type | Description |
| --- | --- | --- |
| code | <code>string</code> | The current locale code. |
| onSuccess | <code>function</code> | The function to call when success.the param is a AppInfo. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |

<a name="AppManager+install"></a>

### appManager.install(url, update, onSuccess, [onError])
Install a dapp by path.

**Kind**: instance method of [<code>AppManager</code>](#AppManager)

| Param | Type | Description |
| --- | --- | --- |
| url | <code>string</code> | The dapp install url. |
| update | <code>boolean</code> | The dapp install update. |
| onSuccess | <code>function</code> | The function to call when success.the param is a AppInfo. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |

<a name="AppManager+unInstall"></a>

### appManager.unInstall(id, onSuccess, [onError])
Uninstall a dapp by id.

**Kind**: instance method of [<code>AppManager</code>](#AppManager)

| Param | Type | Description |
| --- | --- | --- |
| id | <code>string</code> | The dapp id. |
| onSuccess | <code>function</code> | The function to call when success.the param is the id. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |

<a name="AppManager+getInfo"></a>

### appManager.getInfo(onSuccess, [onError])
Get dapp info.

**Kind**: instance method of [<code>AppManager</code>](#AppManager)

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success, the param is a AppInfo. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |

<a name="AppManager+getAppInfo"></a>

### appManager.getAppInfo(id, onSuccess, [onError])
Get a dapp info.

**Kind**: instance method of [<code>AppManager</code>](#AppManager)

| Param | Type | Description |
| --- | --- | --- |
| id | <code>string</code> | The dapp id. |
| onSuccess | <code>function</code> | The function to call when success, the param is a AppInfo. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |

<a name="AppManager+getAppInfos"></a>

### appManager.getAppInfos(onSuccess)
Get a dapp info.

**Kind**: instance method of [<code>AppManager</code>](#AppManager)

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success, the param is include 'infos' and 'list'. |

<a name="AppManager+start"></a>

### appManager.start(id, onSuccess, [onError])
Start a dapp by id. If the dapp running, it will be swith to curent.

**Kind**: instance method of [<code>AppManager</code>](#AppManager)

| Param | Type | Description |
| --- | --- | --- |
| id | <code>string</code> | The dapp id. |
| onSuccess | <code>function</code> | The function to call when success. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |

<a name="AppManager+launcher"></a>

### appManager.launcher(onSuccess, [onError])
Start the launcher.If the launcher running, it will be swith to curent.

**Kind**: instance method of [<code>AppManager</code>](#AppManager)

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |

<a name="AppManager+close"></a>

### appManager.close(onSuccess, [onError])
Close dapp.

**Kind**: instance method of [<code>AppManager</code>](#AppManager)

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |

<a name="AppManager+closeApp"></a>

### appManager.closeApp(id, onSuccess, [onError])
Close a dapp by id.

**Kind**: instance method of [<code>AppManager</code>](#AppManager)

| Param | Type | Description |
| --- | --- | --- |
| id | <code>string</code> | The dapp id. |
| onSuccess | <code>function</code> | The function to call when success. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |

<a name="AppManager+sendMessage"></a>

### appManager.sendMessage(id, type, msg, onSuccess, [onError])
Send a message by id.

**Kind**: instance method of [<code>AppManager</code>](#AppManager)

| Param | Type | Description |
| --- | --- | --- |
| id | <code>string</code> | The dapp id. |
| type | <code>MessageType</code> | The message type. |
| msg | <code>string</code> | The message content. |
| onSuccess | <code>function</code> | The function to call when success. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |

<a name="AppManager+setListener"></a>

### appManager.setListener(callback)
Set listener for message callback.

**Kind**: instance method of [<code>AppManager</code>](#AppManager)

| Param | Type | Description |
| --- | --- | --- |
| callback | [<code>onReceiveMessage</code>](#onReceiveMessage) | The function receive the message. |

<a name="AppManager+getRunningList"></a>

### appManager.getRunningList(onSuccess)
Get running list.

**Kind**: instance method of [<code>AppManager</code>](#AppManager)

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success,the param is a dapp id list. |

<a name="AppManager+getAppList"></a>

### appManager.getAppList(onSuccess)
Get dapp list.

**Kind**: instance method of [<code>AppManager</code>](#AppManager)

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success,the param is a dapp id list. |

<a name="AppManager+getLastList"></a>

### appManager.getLastList(onSuccess)
Get last run list.

**Kind**: instance method of [<code>AppManager</code>](#AppManager)

| Param | Type | Description |
| --- | --- | --- |
| onSuccess | <code>function</code> | The function to call when success,the param is a dapp id list. |

<a name="AppManager+setPluginAuthority"></a>

### appManager.setPluginAuthority(id, plugin, authority, onSuccess, [onError])
Set a plugin authority. Only the launcher can set.

**Kind**: instance method of [<code>AppManager</code>](#AppManager)

| Param | Type | Description |
| --- | --- | --- |
| id | <code>string</code> | The dapp id. |
| plugin | <code>string</code> | The plugin id to set authorty. |
| authority | <code>AuthorityStatus</code> | The authority to set. |
| onSuccess | <code>function</code> | The function to call when success. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |

<a name="AppManager+setUrlAuthority"></a>

### appManager.setUrlAuthority(id, url, authority, onSuccess, [onError])
Set a url authority. Only the launcher can set.

**Kind**: instance method of [<code>AppManager</code>](#AppManager)

| Param | Type | Description |
| --- | --- | --- |
| id | <code>string</code> | The dapp id. |
| url | <code>string</code> | The url to set authority. |
| authority | <code>AuthorityStatus</code> | The authority to set. |
| onSuccess | <code>function</code> | The function to call when success. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |

<a name="AppManager+alertPrompt"></a>

### appManager.alertPrompt(title, message)
Display a alert dialog prompt.

**Kind**: instance method of [<code>AppManager</code>](#AppManager)

| Param | Type | Description |
| --- | --- | --- |
| title | <code>string</code> | The dialog title. |
| message | <code>string</code> | The dialog message. |

<a name="AppManager+infoPrompt"></a>

### appManager.infoPrompt(title, message)
Display a info dialog prompt.

**Kind**: instance method of [<code>AppManager</code>](#AppManager)

| Param | Type | Description |
| --- | --- | --- |
| title | <code>string</code> | The dialog title. |
| message | <code>string</code> | The dialog message. |

<a name="AppManager+askPrompt"></a>

### appManager.askPrompt(title, message, onOK)
Display a ask dialog prompt.

**Kind**: instance method of [<code>AppManager</code>](#AppManager)

| Param | Type | Description |
| --- | --- | --- |
| title | <code>string</code> | The dialog title. |
| message | <code>string</code> | The dialog message. |
| onOK | <code>function</code> | The function to call when click ok. |

<a name="AppManager+sendIntent"></a>

### appManager.sendIntent(action, params, onSuccess, [onError])
Send a intent by action.

**Kind**: instance method of [<code>AppManager</code>](#AppManager)

| Param | Type | Description |
| --- | --- | --- |
| action | <code>string</code> | The intent action. |
| params | <code>Object</code> | The intent params. |
| onSuccess | <code>function</code> | The function to call when success. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |

<a name="AppManager+sendUrlIntent"></a>

### appManager.sendUrlIntent(url, onSuccess, [onError])
Send a intent by action.

**Kind**: instance method of [<code>AppManager</code>](#AppManager)

| Param | Type | Description |
| --- | --- | --- |
| url | <code>string</code> | The intent url. |
| onSuccess | <code>function</code> | The function to call when success. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |

<a name="AppManager+setIntentListener"></a>

### appManager.setIntentListener(callback)
Set intent listener for message callback.

**Kind**: instance method of [<code>AppManager</code>](#AppManager)

| Param | Type | Description |
| --- | --- | --- |
| callback | [<code>onReceiveIntent</code>](#onReceiveIntent) | The function receive the intent. |

<a name="AppManager+sendIntentResponse"></a>

### appManager.sendIntentResponse(action, result, intentId, onSuccess, [onError])
Send a intent respone by id.

**Kind**: instance method of [<code>AppManager</code>](#AppManager)

| Param | Type | Description |
| --- | --- | --- |
| action | <code>string</code> | The intent action. |
| result | <code>Object</code> | The intent respone result. |
| intentId | <code>long</code> | The intent id. |
| onSuccess | <code>function</code> | The function to call when success. |
| [onError] | <code>function</code> | The function to call when error, the param is a String. Or set to null. |

<a name="Icon"></a>

## Icon : <code>Object</code>
The icons info.

**Kind**: global typedef
**Properties**

| Name | Type | Description |
| --- | --- | --- |
| src | <code>string</code> | The icon src. |
| sizes | <code>string</code> | The icon sizes. |
| type | <code>string</code> | The icon type. |

<a name="PluginAuthority"></a>

## PluginAuthority : <code>Object</code>
The plugin authority status.

**Kind**: global typedef
**Properties**

| Name | Type | Description |
| --- | --- | --- |
| plugin | <code>string</code> | The plugin name. |
| authority | <code>AuthorityStatus</code> | The authority status. |

<a name="UrlAuthority"></a>

## UrlAuthority : <code>Object</code>
The access url authority status.

**Kind**: global typedef
**Properties**

| Name | Type | Description |
| --- | --- | --- |
| url | <code>string</code> | The url access. |
| authority | <code>AuthorityStatus</code> | The authority status. |

<a name="AppInfo"></a>

## AppInfo : <code>Object</code>
The App information.

**Kind**: global typedef
**Properties**

| Name | Type | Description |
| --- | --- | --- |
| id | <code>string</code> | The app id. |
| version | <code>string</code> | The app version. |
| name | <code>string</code> | The app name. |
| shortName | <code>string</code> | The app shortName. |
| description | <code>string</code> | The app description. |
| startUrl | <code>string</code> | The app startUrl. |
| icons | [<code>Array.&lt;Icon&gt;</code>](#Icon) | The app icons. |
| authorName | <code>string</code> | The app authorName. |
| authorEmail | <code>string</code> | The app authorEmail. |
| defaultLocale | <code>string</code> | The app defaultLocale. |
| category | <code>string</code> | The app category. |
| keyWords | <code>string</code> | The app keyWords. |
| plugins | [<code>Array.&lt;PluginAuthority&gt;</code>](#PluginAuthority) | The app PluginAuthority list. |
| urls | [<code>Array.&lt;UrlAuthority&gt;</code>](#UrlAuthority) | The app UrlAuthoritylist. |
| backgroundColor | <code>string</code> | The app backgroundColor. |
| themeDisplay | <code>string</code> | The app theme display. |
| themeColor | <code>string</code> | The app theme color. |
| themeFontName | <code>string</code> | The app theme font name. |
| themeFontColor | <code>string</code> | The app theme font color. |
| installTime | <code>number</code> | The app intall time. |
| builtIn | <code>number</code> | The app builtIn. |
| appPath | <code>string</code> | The app path. |
| dataPath | <code>string</code> | The app data path. |

<a name="onReceiveMessage"></a>

## onReceiveMessage : <code>function</code>
The callback function to receive message.

**Kind**: global typedef

| Param | Type | Description |
| --- | --- | --- |
| msg | <code>string</code> | The message receive |
| type | <code>number</code> | The message type |
| from | <code>string</code> | The message from |

<a name="onReceiveIntent"></a>

## onReceiveIntent : <code>function</code>
The callback function to receive message.

**Kind**: global typedef

| Param | Type | Description |
| --- | --- | --- |
| action | <code>string</code> | The intent action |
| params | <code>Object</code> | The intent params |
| from | <code>string</code> | The intent from |

