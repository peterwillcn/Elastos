declare namespace AppManagerPlugin {
    /**
     * The icons info.
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
     */
    type PluginAuthority = {
        /** The plugin name. */
        plugin: string;
        /** The authority status. */
        authority: AuthorityStatus;
    }

    /**
     * The access url authority status.
     */
    type UrlAuthority = {
        /** The url access. */
        url: string;
        /** The authority status. */
        authority: AuthorityStatus;
    }

    /**
     * The App information.
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
     */
    interface AppManager {
        /**
         * Get locale.
         *
         * @param onSuccess  The function to call.the param include 'defaultLang' and 'systemLang'.
         */
        getLocale(onSuccess: (defaultLang: string, systemLang: string)=>void);

        /**
         * Set current locale.
         *
         * @param code       The current locale code.
         * @param onSuccess  The function to call when success.the param is a AppInfo.
         * @param onError    The function to call when error, the param is a String. Or set to null.
         */
        setCurrentLocate(code: string, onSuccess:(appInfo: AppInfo)=>void, onError?:(err:string)=>void);

        /**
         * Install a dapp by path.
         *
         * @param url        The dapp install url.
         * @param update     The dapp install update.
         * @param onSuccess  The function to call when success.the param is a AppInfo.
         * @param onError    The function to call when error, the param is a String. Or set to null.
         */
        install(url: string, update: Boolean, onSuccess:(appInfo: AppInfo)=>void, onError?:(err: string)=>void);

        /**
         * Uninstall a dapp by id.
         *
         * @param id         The dapp id.
         * @param onSuccess  The function to call when success.the param is the id.
         * @param onError    The function to call when error, the param is a String. Or set to null.
         */
        unInstall(id: string, onSuccess:(id: string)=>void, onError?:(err: string)=>void);

        /**
         * Get dapp info.
         *
         * @param onSuccess  The function to call when success, the param is a AppInfo.
         * @param onError    The function to call when error, the param is a String. Or set to null.
         */
        getInfo(onSuccess:(appInfo: AppInfo)=>void, onError?:(err: string)=>void);

        /**
         * Get a dapp info.
         *
         * @param id         The dapp id.
         * @param onSuccess  The function to call when success, the param is a AppInfo.
         * @param onError    The function to call when error, the param is a String. Or set to null.
         */
        getAppInfo(id: string, onSuccess:(appInfo: AppInfo)=>void, onError?:(err: string)=>void);

        /**
         * Get a dapp info.
         *
         * @param onSuccess  The function to call when success, the param is include 'infos' and 'list'.
         */
        getAppInfos(onSuccess:(appsInfo: AppInfo[])=>void);

        /**
         * Start a dapp by id. If the dapp running, it will be swith to curent.
         *
         * @param id         The dapp id.
         * @param onSuccess  The function to call when success.
         * @param onError    The function to call when error, the param is a String. Or set to null.
         */
        start(id: string, onSuccess:()=>void, onError?:(err: string)=>void);

        /**
         * Start the launcher.If the launcher running, it will be swith to curent.
         *
         * @param onSuccess  The function to call when success.
         * @param onError    The function to call when error, the param is a String. Or set to null.
         */
        launcher(onSuccess?:()=>void, onError?:(err: string)=>void);

        /**
         * Close dapp.
         *
         * @param onSuccess  The function to call when success.
         * @param onError    The function to call when error, the param is a String. Or set to null.
         */
        close(onSuccess?:()=>void, onError?:(err: string)=>void);

        /**
         * Close a dapp by id.
         *
         * @param id         The dapp id.
         * @param onSuccess  The function to call when success.
         * @param onError    The function to call when error, the param is a String. Or set to null.
         */
        closeApp(id: string, onSuccess?:()=>void, onError?:(err: string)=>void);

        /**
         * Send a message by id.
         *
         * @param id         The dapp id.
         * @param type       The message type.
         * @param msg        The message content.
         * @param onSuccess  The function to call when success.
         * @param onError    The function to call when error, the param is a String. Or set to null.
         */
        sendMessage(id: string, type: MessageType, msg: string, onSuccess:()=>void, onError?:(err: string)=>void);

        /**
         * Set listener for message callback.
         *
         * @param callback   The function receive the message.
         */
        setListener(callback: (msg: ReceivedMessage)=>void);

        /**
         * Get running list.
         *
         * @param onSuccess  The function to call when success,the param is a dapp id list.
         */
        getRunningList(onSuccess:(ids: string[])=>void);

        /**
         * Get dapp list.
         *
         * @param onSuccess  The function to call when success,the param is a dapp id list.
         */
        getAppList(onSuccess:(ids: string[])=>void);

        /**
         * Get last run list.
         *
         * @param onSuccess  The function to call when success,the param is a dapp id list.
         */
        getLastList(onSuccess:(ids: string[])=>void);

        /**
         * Set a plugin authority. Only the launcher can set.
         *
         * @param id         The dapp id.
         * @param plugin     The plugin id to set authorty.
         * @param authority  The authority to set.
         * @param onSuccess  The function to call when success.
         * @param onError    The function to call when error, the param is a String. Or set to null.
         */
        setPluginAuthority(id: string, plugin: string, authority: PluginAuthority, onSuccess: ()=>void, onError: (err:any)=>void);

        /**
         * Set a url authority. Only the launcher can set.
         *
         * @param id         The dapp id.
         * @param url        The url to set authority.
         * @param authority  The authority to set.
         * @param onSuccess  The function to call when success.
         * @param onError    The function to call when error, the param is a String. Or set to null.
         */
        setUrlAuthority(id: string, url: string, authority: UrlAuthority, onSuccess: ()=>void, onError: (err:any)=>void);

        /**
         * Display a alert dialog prompt.
         *
         * @param title       The dialog title.
         * @param message     The dialog message.
         */
        alertPrompt(title: string, message: string);

        /**
         * Display a info dialog prompt.
         *
         * @param title       The dialog title.
         * @param message     The dialog message.
         */
        infoPrompt(title: string, message: string);

        /**
         * Display a ask dialog prompt.
         *
         * @param title       The dialog title.
         * @param message     The dialog message.
         * @param onOK        The function to call when click ok.
         */
        askPrompt(title: string, message: string, onOK:()=>void);

        /**
         * Send a intent by action.
         *
         * @param action     The intent action.
         * @param params     The intent params.
         * @param onSuccess  The function to call when success.
         * @param onError    The function to call when error, the param is a String. Or set to null.
         */
        sendIntent(action: string, params: any, onSuccess?: (ret: any)=>void, onError?: (err:any)=>void);

        /**
         * Send a intent by url.
         *
         * @param url        The intent url.
         * @param onSuccess  The function to call when success.
         * @param onError    The function to call when error, the param is a String. Or set to null.
         */
        sendUrlIntent(url: string, onSuccess: ()=>void, onError: (err:any)=>void);

        /**
         * Set intent listener for message callback.
         *
         * @param callback   The function receive the intent.
         */
        setIntentListener(callback: (msg: ReceivedIntent)=>void);

        /**
         * Send a intent response by id.
         *
         * @param action     The intent action.
         * @param result     The intent response result.
         * @param intentId   The intent id.
         * @param onSuccess  The function to call when success.
         * @param onError    The function to call when error, the param is a String. Or set to null.
         */
        sendIntentResponse(action: string, result: any, intentId: Number, onSuccess: (response: any)=>void, onError?: (err:any)=>void);
    }
}