declare namespace AppManagerPlugin {
    /**
     * The icons info.
     *
     * @typedef Icon
     * @type {Object}
     * @property {string}           src         The icon src.
     * @property {string}           sizes       The icon sizes.
     * @property {string}           type        The icon type.
     */
    type Icon = {
        /** The icon src. */
        src: string;
        /** The icon sizes. */
        sizes: any; // TODO - Should be some kind of Pair<number, number> array ?
        /** The icon type. */
        type: string;
    }

    /**
     * @description
     * Message type to send or receive.
     *
     * @enum {number}
     */
    const enum MessageType {
        /** The internal message */
        INTERNAL = 1,
        /** The internal return message. */
        IN_RETURN = 2,
        /** The external launcher message */
        EXTERNAL_LAUNCHER = 3,
        /** The external install message */
        EXTERNAL_INSTALL = 4,
        /** The external return message. */
        EX_RETURN = 5
    }

    /**
     * @description
     * Message type to send or receive.
     *
     * @enum {number}
     */
    const enum AuthorityStatus {
        /** Not initialized */
        NOINIT = 0,
        /** Ask for authority. */
        ASK = 1,
        /** Allow the authority. */
        ALLOW = 2,
        /** Deny the authority. */
        DENY = 3
    }

    /**
     * The plugin authority status.
     *
     * @typedef PluginAuthority
     * @type {Object}
     * @property {string}           plugin      The plugin name.
     * @property {AuthorityStatus}  authority   The authority status.
     */
    type PluginAuthority = {
        /** The plugin name. */
        plugin: string;
        /** The authority status. */
        authority: AuthorityStatus;
    }

    /**
     * The access url authority status.
     *
     * @typedef UrlAuthority
     * @type {Object}
     * @property {string}           url         The url access.
     * @property {AuthorityStatus}  authority   The authority status.
     */
    type UrlAuthority = {
        /** The url access. */
        url: string;
        /** The authority status. */
        authority: AuthorityStatus;
    }

    /**
     * The App information.
     *
     * @typedef AppInfo
     * @type {Object}
     * @param          id              The app id.
     * @param          version         The app version.
     * @param          name            The app name.
     * @param          shortName       The app shortName.
     * @param          description     The app description.
     * @param          startUrl        The app startUrl.
     * @param          icons           The app icons.
     * @param          authorName      The app authorName.
     * @param          authorEmail     The app authorEmail.
     * @param          defaultLocale   The app defaultLocale.
     * @param          category        The app category.
     * @param          keyWords        The app keyWords.
     * @param          plugins         The app PluginAuthority list.
     * @param          urls            The app UrlAuthoritylist.
     * @param          backgroundColor The app backgroundColor.
     * @param          themeDisplay    The app theme display.
     * @param          themeColor      The app theme color.
     * @param          themeFontName   The app theme font name.
     * @param          themeFontColor  The app theme font color.
     * @param          installTime     The app intall time.
     * @param          builtIn         The app builtIn.
     * @param          dataPath        The app data path.
     */
    type AppInfo = {
        /** The app id. */
        id: string;
        /** The app version. */
        version: string;
        /** The app name. */
        name: string;
        /** The app shortName. */
        shortName: string;
        /** The app description. */
        description: string;
        /** The app startUrl. */
        startUrl: string;
        /** The app icons. */
        icons: Icon[];
        /** The app authorName. */
        authorName: string;
        /** The app authorEmail. */
        authorEmail: string;
        /** The app defaultLocale. */
        defaultLocale: string;
        /** The app category. */
        category: string;
        /** The app keyWords. */
        keywords: string;
        /** The app PluginAuthority list. */
        plugins: PluginAuthority[];
        /** The app UrlAuthoritylist. */
        urls: UrlAuthority[];
        /** The app backgroundColor. */
        backgroundColor: string;
        /** The app theme display. */
        themeDisplay: string;
        /** The app theme color. */
        themeColor: string;
        /** The app theme font name. */
        themeFontName: string;
        /** The app theme font color. */
        themeFontColor: string;
        /** The app intall time. */
        installTime: Number;
        /** The app builtIn. */
        builtIn: Boolean;
        /** The app path. */
        appPath: string;
        /** The app data path. */
        dataPath: string;
    }

    /**
     * Object received when receiving a message.
     *
     * @param {string}  msg		    The message receive
     * @param {number}  type	    The message type
     * @param {string}  from		The message from
     */
    type ReceivedMessage = {
        /** The message receive */
        msg: string;
        /** The message type */
        type: Number;
        /** The message from */
        from: string;
    }

    /**
     * Object received when receiving an intent.
     *
     * @param {string}  action		 The intent action
     * @param {Object}  params	    The intent params
     * @param {string}  from		The intent from
     */
    type ReceivedIntent = {
        /** The intent action */
        action: string;
        /** The intent params */
        params: any;
        /** The intent from */
        from: string;
    }

    /**
     * The class representing dapp manager for launcher.
     * @class
     */
    interface AppManager {
        /**
         * Get locale.
         *
         * @param {Function} onSuccess  The function to call.the param include 'defaultLang' and 'systemLang'.
         */
        getLocale(onSuccess: (defaultLang: string, systemLang: string)=>void);

        /**
         * Set current locale.
         *
         * @param {string}   code       The current locale code.
         * @param {Function} onSuccess  The function to call when success.the param is a AppInfo.
         * @param {Function} [onError]  The function to call when error, the param is a String. Or set to null.
         */
        setCurrentLocate(code: string, onSuccess:(appInfo: AppInfo)=>void, onError?:(err:string)=>void);

        /**
         * Install a dapp by path.
         *
         * @param {string}   url        The dapp install url.
         * @param {boolean}  update    The dapp install update.
         * @param {Function} onSuccess  The function to call when success.the param is a AppInfo.
         * @param {Function} [onError]  The function to call when error, the param is a String. Or set to null.
         */
        install(url: string, update: Boolean, onSuccess:(appInfo: AppInfo)=>void, onError?:(err: string)=>void);

        /**
         * Uninstall a dapp by id.
         *
         * @param {string}   id         The dapp id.
         * @param {Function} onSuccess  The function to call when success.the param is the id.
         * @param {Function} [onError]  The function to call when error, the param is a String. Or set to null.
         */
        unInstall(id: string, onSuccess:(id: string)=>void, onError?:(err: string)=>void);

        /**
         * Get dapp info.
         *
         * @param {Function} onSuccess  The function to call when success, the param is a AppInfo.
         * @param {Function} [onError]  The function to call when error, the param is a String. Or set to null.
         */
        getInfo(onSuccess:(appInfo: AppInfo)=>void, onError?:(err: string)=>void);

        /**
         * Get a dapp info.
         *
         * @param {string}   id       The dapp id.
         * @param {Function} onSuccess  The function to call when success, the param is a AppInfo.
         * @param {Function} [onError]  The function to call when error, the param is a String. Or set to null.
         */
        getAppInfo(id: string, onSuccess:(appInfo: AppInfo)=>void, onError?:(err: string)=>void);

        /**
         * Get a dapp info.
         *
         * @param {Function} onSuccess  The function to call when success, the param is include 'infos' and 'list'.
         */
        getAppInfos(onSuccess:(appsInfo: AppInfo[])=>void);

        /**
         * Start a dapp by id. If the dapp running, it will be swith to curent.
         *
         * @param {string}   id         The dapp id.
         * @param {Function} onSuccess  The function to call when success.
         * @param {Function} [onError]  The function to call when error, the param is a String. Or set to null.
         */
        start(id: string, onSuccess:()=>void, onError?:(err: string)=>void);

        /**
         * Start the launcher.If the launcher running, it will be swith to curent.
         *
         * @param {Function} onSuccess  The function to call when success.
         * @param {Function} [onError]  The function to call when error, the param is a String. Or set to null.
         */
        launcher(onSuccess?:()=>void, onError?:(err: string)=>void);

        /**
         * Close dapp.
         *
         * @param {Function} onSuccess  The function to call when success.
         * @param {Function} [onError]  The function to call when error, the param is a String. Or set to null.
         */
        close(onSuccess?:()=>void, onError?:(err: string)=>void);

        /**
         * Close a dapp by id.
         *
         * @param {string}   id         The dapp id.
         * @param {Function} onSuccess  The function to call when success.
         * @param {Function} [onError]  The function to call when error, the param is a String. Or set to null.
         */
        closeApp(id: string, onSuccess?:()=>void, onError?:(err: string)=>void);

        /**
         * Send a message by id.
         *
         * @param {string}          id      The dapp id.
         * @param {MessageType}     type    The message type.
         * @param {string}   msg        The message content.
         * @param {Function} onSuccess  The function to call when success.
         * @param {Function} [onError]  The function to call when error, the param is a String. Or set to null.
         */
        sendMessage(id: string, type: MessageType, msg: string, onSuccess:()=>void, onError?:(err: string)=>void);

        /**
         * Set listener for message callback.
         *
         * @param {Function} callback   The function receive the message.
         */
        setListener(callback: (msg: ReceivedMessage)=>void);

        /**
         * Get running list.
         *
         * @param {Function} onSuccess  The function to call when success,the param is a dapp id list.
         */
        getRunningList(onSuccess:(ids: string[])=>void);

        /**
         * Get dapp list.
         *
         * @param {Function} onSuccess  The function to call when success,the param is a dapp id list.
         */
        getAppList(onSuccess:(ids: string[])=>void);

        /**
         * Get last run list.
         *
         * @param {Function} onSuccess  The function to call when success,the param is a dapp id list.
         */
        getLastList(onSuccess:(ids: string[])=>void);

        /**
         * Set a plugin authority. Only the launcher can set.
         *
         * @param {string}   id       The dapp id.
         * @param {string}   plugin     The plugin id to set authorty.
         * @param {AuthorityStatus}   authority  The authority to set.
         * @param {Function} onSuccess  The function to call when success.
         * @param {Function} [onError]  The function to call when error, the param is a String. Or set to null.
         */
        setPluginAuthority(id: string, plugin: string, authority: PluginAuthority, onSuccess: ()=>void, onError: (err:any)=>void);

        /**
         * Set a url authority. Only the launcher can set.
         *
         * @param {string}   id       The dapp id.
         * @param {string}   url      The url to set authority.
         * @param {AuthorityStatus}   authority  The authority to set.
         * @param {Function} onSuccess  The function to call when success.
         * @param {Function} [onError]  The function to call when error, the param is a String. Or set to null.
         */
        setUrlAuthority(id: string, url: string, authority: UrlAuthority, onSuccess: ()=>void, onError: (err:any)=>void);

        /**
         * Display a alert dialog prompt.
         *
         * @param {string}   title       The dialog title.
         * @param {string}   message     The dialog message.
         */
        alertPrompt(title: string, message: string);

        /**
         * Display a info dialog prompt.
         *
         * @param {string}   title       The dialog title.
         * @param {string}   message     The dialog message.
         */
        infoPrompt(title: string, message: string);

        /**
         * Display a ask dialog prompt.
         *
         * @param {string}   title       The dialog title.
         * @param {string}   message     The dialog message.
         * @param {Function} onOK        The function to call when click ok.
         */
        askPrompt(title: string, message: string, onOK:()=>void);

        /**
         * Send a intent by action.
         *
         * @param {string}   action     The intent action.
         * @param {Object}   params     The intent params.
         * @param {Function} onSuccess  The function to call when success.
         * @param {Function} [onError]  The function to call when error, the param is a String. Or set to null.
         */
        sendIntent(action: string, params: any, onSuccess?: (ret: any)=>void, onError?: (err:any)=>void);

        /**
         * Send a intent by url.
         *
         * @param {string}   url     The intent url.
         * @param {Function} onSuccess  The function to call when success.
         * @param {Function} [onError]  The function to call when error, the param is a String. Or set to null.
         */
        sendUrlIntent(url: string, onSuccess: ()=>void, onError: (err:any)=>void);

        /**
         * Set intent listener for message callback.
         *
         * @param {ReceivedIntent} callback   The function receive the intent.
         */
        setIntentListener(callback: (msg: ReceivedIntent)=>void);

        /**
         * Send a intent response by id.
         *
         * @param {string}   action     The intent action.
         * @param {Object}   result     The intent response result.
         * @param {long}     intentId   The intent id.
         * @param {Function} onSuccess  The function to call when success.
         * @param {Function} [onError]  The function to call when error, the param is a String. Or set to null.
         */
        sendIntentResponse(action: string, result: any, intentId: Number, onSuccess: (response: any)=>void, onError?: (err:any)=>void);
    }
}