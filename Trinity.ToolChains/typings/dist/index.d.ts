
declare class Icon {
    src: string;
    sizes: any; // TODO - Should be some kind of Pair<number, number> array ?
    type: string;
}

declare enum MessageType {
    INTERNAL = 1,
    IN_RETURN = 2,
    EXTERNAL_LAUNCHER = 3,
    EXTERNAL_INSTALL = 4,
    EX_RETURN = 5
}

declare enum AuthorityStatus {
    NOINIT = 0,
    ASK = 1,
    ALLOW = 2,
    DENY = 3
}

declare class PluginAuthority {
     plugin: string;
     authority: AuthorityStatus;
}

declare class UrlAuthority {
    url: string;
    authority: AuthorityStatus;
}

declare class AppInfo {
    id: string;
    version: string;
    name: string;
    shortName: string;
    description: string;
    startUrl: string;
    icons: Icon[];
    authorName: string;
    authorEmail: string;
    defaultLocale: string;
    category: string;
    keywords: string;
    plugins: PluginAuthority[];
    urls: UrlAuthority[];
    backgroundColor: string;
    themeDisplay: string;
    themeColor: string;
    themeFontName: string;
    themeFontColor: string;
    installTime: Number;
    builtIn: Boolean;
    appPath: string;
    dataPath: string;
}

export declare class AppManager {
    getLocale(onSuccess: (defaultLang: string, systemLang: string)=>void);
    setCurrentLocate(code: string, onSuccess:(appInfo: AppInfo)=>void, onError?:(err:string)=>void);
    install(url: string, update: Boolean, onSuccess:(appInfo: AppInfo)=>void, onError?:(err: string)=>void);
    unInstall(id: string, onSuccess:(id: string)=>void, onError?:(err: string)=>void);
    getInfo(onSuccess:(appInfo: AppInfo)=>void, onError?:(err: string)=>void);
    getAppInfo(id: string, onSuccess:(appInfo: AppInfo)=>void, onError?:(err: string)=>void);
    getAppsInfo(onSuccess:(appsInfo: AppInfo[])=>void);
    start(id: string, onSuccess:()=>void, onError?:(err: string)=>void);
    launcher(onSuccess:()=>void, onError?:(err: string)=>void);
    close(onSuccess?:()=>void, onError?:(err: string)=>void);
    closeApp(id: string, onSuccess?:()=>void, onError?:(err: string)=>void);
    sendMessage(id: string, type: MessageType, msg: string, onSuccess:()=>void, onError?:(err: string)=>void);
    setListener(callback: (msg: any)=>void);
    getRunningList(onSuccess:(ids: string[])=>void);
    getAppList(onSuccess:(ids: string[])=>void);
    getLastList(onSuccess:(ids: string[])=>void);
    setPluginAuthority(id: string, plugin: string, authority: PluginAuthority, success: ()=>void, error: (err:any)=>void);
    setUrlAuthority(id: string, url: string, authority: UrlAuthority, success: ()=>void, error: (err:any)=>void);
    alertPrompt(title: string, message: string);
    infoPrompt(title: string, message: string);
    askPrompt(title: string, message: string, onOK:()=>void);
    sendIntent(action: string, params: any, onSuccess?: ()=>void, onError?: (err:any)=>void);
    sendUrlIntent(url: string, onSuccess: ()=>void, onError: (err:any)=>void);
    setIntentListener(callback: (msg: any)=>void);
    sendIntentResponse(action: string, result: any, intentId: Number, onSuccess: (response: any)=>void, onError?: (err:any)=>void?);
}
