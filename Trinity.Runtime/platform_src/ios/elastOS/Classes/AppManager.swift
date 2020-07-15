 /*
  * Copyright (c) 2018 Elastos Foundation
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

import Foundation

@objc(AppManager)
class AppManager: NSObject {
    private static var appManager: AppManager?;

    /** The internal message */
    static let MSG_TYPE_INTERNAL = 1;
    /** The internal return message. */
    static let MSG_TYPE_IN_RETURN = 2;
    /** The internal refresh message. */
    static let MSG_TYPE_IN_REFRESH = 3;
    /** The installing message. */
    static let MSG_TYPE_INSTALLING = 4;

    /** The external message */
    static let MSG_TYPE_EXTERNAL = 11;
    /** The external launcher message */
    static let MSG_TYPE_EX_LAUNCHER = 12;
    /** The external install message */
    static let MSG_TYPE_EX_INSTALL = 13;
    /** The external return message. */
    static let MSG_TYPE_EX_RETURN = 14;

    static let LAUNCHER = "launcher";

    let mainViewController: MainViewController;
    var viewControllers = [String: TrinityViewController]();

    let appsPath: String;
    let dataPath: String;
    let configPath: String;
    let tempPath: String;

    var curController: TrinityViewController?;

    let dbAdapter: ManagerDBAdapter;

    var appList: [AppInfo];
    var appInfos = [String: AppInfo]();
    var lastList = [String]();
    var installer: AppInstaller;
    var visibles = [String: Bool]();

    private var launcherInfo: AppInfo? = nil;

    var installUriList = [String]();
    var intentUriList = [URL]();
    var launcherReady = false;

    static let defaultPlugins = [
        "gesturehandler",
        "appmanager",
        "titlebarplugin",
        "console",
        "localstorage",
        "handleopenurl",
        "intentandnavigationfilter",
        "authorityplugin",
        "statusbar"
    ];

    init(_ mainViewController: MainViewController) {

        self.mainViewController = mainViewController;

        appsPath = NSHomeDirectory() + "/Documents/apps/";
        dataPath = NSHomeDirectory() + "/Documents/data/";
        configPath = NSHomeDirectory() + "/Documents/config/";
        tempPath = NSHomeDirectory() + "/Documents/temp/";

        let fileManager = FileManager.default
        if (!fileManager.fileExists(atPath: appsPath)) {
            do {
                try fileManager.createDirectory(atPath: appsPath, withIntermediateDirectories: true, attributes: nil)
            }
            catch let error {
                print("Make appsPath error: \(error)");
            }
        }

        if (!fileManager.fileExists(atPath: dataPath)) {
            do {
                try fileManager.createDirectory(atPath: dataPath, withIntermediateDirectories: true, attributes: nil)
            }
            catch let error {
                print("Make dataPath error: \(error)");
            }
        }

        if (!fileManager.fileExists(atPath: configPath)) {
            do {
                try fileManager.createDirectory(atPath: configPath, withIntermediateDirectories: true, attributes: nil)
            }
            catch let error {
                print("Make configPath error: \(error)");
            }
        }

        if (!fileManager.fileExists(atPath: tempPath)) {
            do {
                try fileManager.createDirectory(atPath: tempPath, withIntermediateDirectories: true, attributes: nil)
            }
            catch let error {
                print("Make tempPath error: \(error)");
            }
        }

        dbAdapter = ManagerDBAdapter(dataPath);
//        try! dbAdapter.clean();
        installer = AppInstaller(appsPath, dataPath, tempPath, dbAdapter);
        appList = try! dbAdapter.getAppInfos();
        super.init();

        AppManager.appManager = self;

        PasswordManager.getSharedInstance().setAppManager(self)

        refreashInfos();
        getLauncherInfo();
        saveLauncher();

        do {
            // TMP BPI try loadLauncher();
            try launchStartupScreen()
        }
        catch let error {
            print("loadLauncher error: \(error)");
        }
        saveBuiltInApps();
        refreashInfos();
        sendRefreshList("initiated", nil);

        if (PreferenceManager.getShareInstance().getDeveloperMode()) {
            CLIService.getShareInstance().start();
        }
    }

    @objc static func getShareInstance() -> AppManager {
        return AppManager.appManager!;
    }

    func getDBAdapter() -> ManagerDBAdapter {
        return dbAdapter;
    }

    func copyConfigFiles() {
        let path = getAbsolutePath("www/config");
        do {
            try installer.copyAssetsFolder(path, configPath);
        }
        catch let error {
            print("Copy configPath error: \(error)");
        }
    }

    func setAppVisible(_ id: String, _ visible: String) {
        if (visible == "hide") {
            visibles[id] = false;
        }
        else {
            visibles[id] = true;
        }
    }

    func getAppVisible(_ id: String) -> Bool {
        let ret = visibles[id];
        if (ret == nil) {
            return true;
        }
        return ret!;
    }

    @objc func getLauncherInfo() -> AppInfo? {
        if launcherInfo == nil {
            launcherInfo = try! dbAdapter.getLauncherInfo();
        }
        return launcherInfo;
    }

    @objc func isLauncher(_ appId: String?) -> Bool {
        if (appId == nil || launcherInfo == nil) {
            return false;
        }

        if (appId == AppManager.LAUNCHER || appId == launcherInfo!.app_id) {
            return true;
        }
        else {
            return false;
        }
    }

    func refreashInfos() {
        appList = try! dbAdapter.getAppInfos();
        appInfos = [String: AppInfo]();
        for info in appList {
            appInfos[info.app_id] = info;
            let visible = visibles[info.app_id];
            if (visible == nil) {
                setAppVisible(info.app_id, info.start_visible);
            }
        }
    }

    @objc func getAppInfo(_ id: String) -> AppInfo? {
        if (isLauncher(id)) {
            return getLauncherInfo();
        }
        else {
            return appInfos[id];
        }
    }

    func getAppInfos() -> [String: AppInfo] {
        return appInfos;
    }

    func getStartPath(_ info: AppInfo) -> String {
        if (!info.remote) {
            return getAppUrl(info) + info.start_url;
        }
        else {
            return info.start_url;
        }
    }

    @objc func getAppPath(_ info: AppInfo) -> String {
        if (!info.remote) {
            return appsPath + info.app_id + "/";
        }
        else {
            let index = info.start_url.range(of: "/", options: .backwards)!.lowerBound;
            return String(info.start_url[info.start_url.startIndex ..< index])  + "/";
        }
    }

    @objc func getAppUrl(_ info: AppInfo) -> String {
        var url = getAppPath(info);
        if (!info.remote) {
            url = "file://" + url;
        }
        return url;
    }

    @objc func getDataPath(_ id: String) -> String {
        var appId = id;
        if (id == "launcher") {
            appId = getLauncherInfo()!.app_id;
        }
        return dataPath + appId + "/";
    }

    @objc func getDataUrl(_ id: String) -> String {
        return "file://" + getDataPath(id);
    }

    @objc func getTempPath(_ id: String) -> String {
        var appId = id;
        if (id == "launcher") {
            appId = getLauncherInfo()!.app_id;
        }
        return tempPath + appId + "/";
    }

    @objc func getTempUrl(_ id: String) -> String {
        return "file://" + getTempPath(id);
    }

    @objc func getConfigPath() -> String {
        return configPath;
    }

    func getIconPath(_ info: AppInfo) -> String {
        if (info.type == "url") {
            return appsPath + info.app_id + "/";
        }
        else {
            return getAppPath(info);
        }
    }

    func getIconPaths(_ info: AppInfo) -> [String] {
        let path = getAppPath(info)
        var iconPaths = [String]()
        for i in 0..<info.icons.count {
            iconPaths.append(path + info.icons[i].src)
        }
        return iconPaths
    }

    func installBuiltInApp(_ appPath: String, _ id: String, _ launcher: Bool) throws {
//        Log.d("AppManager", "Entering installBuiltInApp path=" + appPath + " id=" + id +" launcher=" + launcher);

        let originPath = getAbsolutePath(appPath + id);
        var path = originPath;
        let fileManager = FileManager.default;
        var ret = fileManager.fileExists(atPath: path + "/manifest.json");
        if (!ret) {
            path = path + "/assets";
            ret = fileManager.fileExists(atPath: path + "/manifest.json");
            guard ret else {
                fatalError("installBuiltInApp error: No manifest found, returning.")
            }
        }

        let builtInInfo = try installer.parseManifest(path + "/manifest.json", launcher)!;
        let installedInfo = getAppInfo(id);
        var needInstall = true;

        if (installedInfo != nil) {
            let versionChanged = PreferenceManager.getShareInstance().versionChanged;
            if (versionChanged || builtInInfo.version_code > installedInfo!.version_code) {
                if versionChanged {
                    Log.d("AppManager", "Trinity version has changed: uninstalling installed version of \(installedInfo!.app_id)");
                }
                else {
                    Log.d("AppManager", "built in version \(builtInInfo.version_code) > installed version \(installedInfo!.version_code) for \(installedInfo!.app_id): uninstalling installed")
                }
                try installer.unInstall(installedInfo, true)
            }
            else {
                Log.d("AppManager", "Built in version <= installed version, No need to install");
                needInstall = false;
            }
        }
        else {
            Log.d("AppManager", "No installed info found");
        }

        if (needInstall) {
            Log.d("AppManager", "Needs install - copying assets and setting built-in to 1");
            try installer.copyAssetsFolder(originPath, appsPath + builtInInfo.app_id);
            builtInInfo.built_in = true;
            try dbAdapter.addAppInfo(builtInInfo);
            if (launcher) {
                launcherInfo = nil;
                getLauncherInfo();
            }
        }

        return;
    }

    private func saveLauncher() {
        do {
            try installBuiltInApp("www/", "launcher", true);

            //For Launcher update by install()
            let path = appsPath + AppManager.LAUNCHER;
            let fileManager = FileManager.default;
            if (fileManager.fileExists(atPath: path)) {
                let info = try installer.getInfoByManifest(path + "/", true);
                info!.built_in = true;
                try dbAdapter.removeAppInfo(launcherInfo!);
                try installer.renameFolder(path, appsPath, launcherInfo!.app_id);
                try dbAdapter.addAppInfo(info!);
                launcherInfo = nil;
                getLauncherInfo();
            }
        } catch let error {
            print("saveLauncher error: \(error)");
        }
    }

    func saveBuiltInApps() {
        let path = getAbsolutePath("www/built-in") + "/";

        let fileManager = FileManager.default;
        let dirs = try? fileManager.contentsOfDirectory(atPath: path);
        guard dirs != nil else {
            return;
        }

        do {
            for dir in dirs! {
                try installBuiltInApp("www/built-in/", dir, false);
            }

            for info in appList {
//                print("save / app "+info.app_id+" buildin "+info.built_in);
                if (!info.built_in) {
                    continue;
                }

                var needChange = true;
                for dir in dirs! {
                    if (dir == info.app_id) {
                        needChange = false;
                        break;
                    }
                }
                if (needChange) {
                    try dbAdapter.changeBuiltInToNormal(info.app_id);
                }
            }
        } catch AppError.error(let err) {
            print(err);
        } catch let error {
            print(error.localizedDescription);
        }
    }

    func install(_ url: String, _ update: Bool) throws -> AppInfo? {
        let info = try installer.install(url, update);
        if (info != nil) {
            refreashInfos();

            if (info!.launcher) {
                sendRefreshList("launcher_upgraded", info!);
            }
            else {
                sendRefreshList("installed", info);
            }
        }

        return info
    }

    func unInstall(_ id: String, _ update: Bool) throws {
        try close(id);
        let info = appInfos[id];
        try installer.unInstall(info, update);
        refreashInfos();
        if (!update) {
            if (info!.built_in) {
                try installBuiltInApp("www/built-in/", info!.app_id, false);
               refreashInfos();
            }
           sendRefreshList("unInstalled", info);
        }
    }

    func removeLastlistItem(_ id: String) {
        for (index, item) in lastList.enumerated() {
            if item == id {
                lastList.remove(at: index);
                break;
            }
        }
    }

    func getViewControllerById(_ appId: String) -> TrinityViewController? {
        var id = appId;
        if (isLauncher(id)) {
            id = AppManager.LAUNCHER;
        }
        return viewControllers[id];
    }

    func switchContent(_ to: TrinityViewController, _ id: String) {
        if ((curController != nil) && (curController != to)) {
            mainViewController.switchController(from: curController!, to: to)
        }

        curController = to

//        removeRunninglistItem(id);
//        runningList.insert(id, at: 0);

        removeLastlistItem(id);
        lastList.insert(id, at: 0);
    }

    private func hideViewController(_ viewController: TrinityViewController, _ id: String) {
        viewController.view.isHidden = true;

//        runningList.insert(id, at: 0);
        lastList.insert(id, at: 1);
    }

    func isCurrentViewController(_ viewController: TrinityViewController) -> Bool {
        if (curController == nil) {
            return false;
        }
        return (viewController == curController!);
    }

    func start(_ id: String) throws {
        var viewController = getViewControllerById(id);
        if viewController == nil {
            if (isLauncher(id)) {
                viewController = LauncherViewController();
            }
            else {
                let appInfo = appInfos[id];
                guard appInfo != nil else {
                    throw AppError.error("No such app!");
                }

                let nativeClassName = ConfigManager.getShareInstance().getNativeMainViewControllerName(appInfo!);
                if (nativeClassName != nil) {
                    viewController = NativeAppViewController(appInfo!, nativeClassName!);
                }
                else {
                    viewController = AppViewController(appInfo!);
                }
                sendRefreshList("started", appInfo!);
            }

            mainViewController.add(viewController!)
            viewControllers[id] = viewController;

            if (!getAppVisible(id)) {
                hideViewController(viewController!, id);
            }

            viewController!.setReady();
        }

        if (getAppVisible(id)) {
            viewController!.view.isHidden = false;
            switchContent(viewController!, id);
        }
    }

    func close(_ id: String) throws {
        if (isLauncher(id)) {
            throw AppError.error("Launcher can't close!");
        }

        let info = appInfos[id];
        if (info == nil) {
            throw AppError.error("No such app!");
        }

        setAppVisible(id, info!.start_visible);

        let viewController = getViewControllerById(id);
        if (viewController == nil) {
            return;
        }

        try IntentManager.getShareInstance().removeAppFromIntentList(id);

        if (viewController == curController) {
            let id2 = lastList[1];
            let viewController2 = getViewControllerById(id2);
            if (viewController2 == nil) {
                throw AppError.error("RT inner error!");
            }
            switchContent(viewController2!, id2);
        }

        viewControllers[id] = nil;
        viewController!.remove();
        removeLastlistItem(id);
        sendRefreshList("closed", info!);
    }

    /**
     * Closes all running apps, except the launcher app.
     */
    public func closeAll() throws {
        for appId in getRunningList() {
            if appId != AppManager.LAUNCHER {
                try close(appId)
            }
        }
    }

    func loadLauncher() throws {
        try start("launcher");
    }
    
    public func launchStartupScreen() throws {
        // Check if a there is a signed in DID. If so, directly start the launcher. If not,
        // start the DID session dapp
        DIDSessionManager.getSharedInstance().setAppManager(self)
        if let signedInIdentity = try DIDSessionManager.getSharedInstance().getSignedInIdentity() {
            // A DID is signed in
            try loadLauncher()
        }
        else {
            // No DID signed in
            try loadLauncher() // TODO - IMPORTANT NOTE: for now because did session app crashes if launcher was not loaded, we also start the launcher FOR TEST. Later , launcher should NOT start if DID session starts
            try start("org.elastos.trinity.dapp.didsession")
        }
    }
    
    /**
     * Signs in to a new DID session.
     */
    public func signIn() throws {
        // Stop the did session app
        try close("org.elastos.trinity.dapp.didsession")

        // Start the launcher app
        try launchStartupScreen()
    }

    /**
     * Signs out from a DID session. All apps and services are closed, and launcher goes back to the DID session app prompt.
     */
    public func signOut() throws {
        try closeAll()

        // Go back to the startup screen
        try launchStartupScreen()
    }

   func checkInProtectList(_ uri: String) throws {
        let protectList = ConfigManager.getShareInstance().getStringArrayValue("dapp.protectList", [String]());
        let info = try installer.getInfoFromUrl(uri);
        if (info != nil && info!.app_id != "" ) {
            if (protectList.contains(info!.app_id.lowercased())) {
                throw AppError.error("Don't allow install '\(info!.app_id)' by the third party app.");
            }
        }
    }

    func installUri(_ uri: String, _ dev:Bool) {
        do {
            if (dev && PreferenceManager.getShareInstance().getDeveloperMode()) {
                let _ = try install(uri, true);
            }
            else {
                try checkInProtectList(uri);
                sendInstallMsg(uri);
            }
        }
        catch AppError.error(let err) {
            alertDialog("Install Error", err);
        }
        catch let error {
            alertDialog("Install Error", error.localizedDescription);
        }
    }

    func setInstallUri(_ uri: String, _ dev: Bool) {
        if (launcherReady || dev) {
            sendInstallMsg(uri);
        }
        else {
            installUriList.append(uri);
        }
    }

    func setIntentUri(_ uri: URL) {
        if (launcherReady) {
            IntentManager.getShareInstance().doIntentByUri(uri);
        }
        else {
            intentUriList.append(uri);
        }
    }

    func isLauncherReady() -> Bool {
        return launcherReady;
    }

    func setLauncherReady() {
        launcherReady = true;

        for uri in installUriList {
            self.sendInstallMsg(uri);
        }

        for uri in intentUriList {
            IntentManager.getShareInstance().doIntentByUri(uri);
        }
    }

    func sendLauncherMessage(_ type: Int, _ msg: String, _ fromId: String) throws {
        try sendMessage(AppManager.LAUNCHER, type, msg, fromId);
    }


    func sendLauncherMessageMinimize(_ fromId: String) throws {
        try sendLauncherMessage(AppManager.MSG_TYPE_INTERNAL,
        "{\"action\":\"minimize\"}", fromId);
    }

    private func sendInstallMsg(_ uri: String) {
        let msg = "{\"uri\":\"" + uri + "\", \"dev\":\"false\"}";
        do {
            try sendLauncherMessage(AppManager.MSG_TYPE_EX_INSTALL, msg, "system");
        } catch {
            print("Send install message: " + msg + " error!");
        }
    }

    private func sendRefreshList(_ action: String, _ info: AppInfo?) {
        var msg = "";

        if (info != nil) {
            msg = "{\"action\":\"" + action + "\", \"id\":\"" + info!.app_id + "\", \"name\":\"" + info!.name + "\"}";
        }
        else {
            msg = "{\"action\":\"" + action + "\"}";
        }

        do {
            try sendMessage("launcher", AppManager.MSG_TYPE_IN_REFRESH, msg, "system");
        }
        catch {
            print("Send message: " + msg + " error!");
        }
   }

    func sendMessage(_ toId: String, _ type: Int, _ msg: String, _ fromId: String) throws {
        let viewController = getViewControllerById(toId);
        if (viewController != nil) {
            viewController!.basePlugin!.onReceive(msg, type, fromId);
        }
        else {
            throw AppError.error(toId + " isn't running!");
        }
    }

    func broadcastMessage(_ type: Int, _ msg: String, _ fromId: String) {
        for id in viewControllers.keys {
            viewControllers[id]!.basePlugin!.onReceive(msg, type, fromId);
        }
    }

    func getPluginAuthority(_ id: String, _ plugin: String) -> Int {
        if (AppManager.defaultPlugins.contains(plugin)) {
            return AppInfo.AUTHORITY_ALLOW;
        }

        let info = appInfos[id];
        if (info != nil) {
            for pluginAuth in info!.plugins {
                if (pluginAuth.plugin == plugin) {
                    return pluginAuth.authority;
                }
            }
        }
        return AppInfo.AUTHORITY_NOEXIST;
    }

    func getUrlAuthority(_ id: String, _ url: String) -> Int {
        let info = appInfos[id];
        if (info != nil) {
            for urlAuth in info!.urls {
                if (urlAuth.url == url) {
                    return urlAuth.authority;
                }
            }
        }
        return AppInfo.AUTHORITY_NOEXIST;
    }

    func getIntentAuthority(_ id: String, _ url: String) -> Int {
        let info = appInfos[id];
        if (info != nil) {
            for urlAuth in info!.intents {
                if (urlAuth.url == url) {
                    return urlAuth.authority;
                }
            }
        }
        return AppInfo.AUTHORITY_NOEXIST;
    }

    func setPluginAuthority(_ id: String, _ plugin: String, _ authority: Int) throws {
        let info = appInfos[id];
        guard (info != nil) else {
            throw AppError.error("No such app!");
        }

        for pluginAuth in info!.plugins {
            if (pluginAuth.plugin == plugin) {
                try dbAdapter.updatePluginAuth(pluginAuth, authority);
                pluginAuth.authority = authority;
                sendRefreshList("authorityChanged", info!);
                return;
            }
        }
        throw AppError.error("The plugin isn't in list!");
    }

    func setUrlAuthority(_ id: String, _ url: String, _ authority: Int) throws {
        let info = appInfos[id];
        guard (info != nil) else {
            throw AppError.error("No such app!");
        }

        for urlAuth in info!.urls {
            if (urlAuth.url == url) {
                try dbAdapter.updateUrlAuth(urlAuth, authority);
                urlAuth.authority = authority;
                sendRefreshList("authorityChanged", info!);
                return;
            }
        }
        throw AppError.error("The url isn't in list!");
    }

    private let pluginAlertLock = DispatchSemaphore(value: 1)

    /**
     Ask user if he is willing to let the given plugin run for this application or not.
     */
    func runAlertPluginAuth(_ info: AppInfo, _ pluginName: String,
                            _ originAuthority: Int,
                            _ plugin: CDVPlugin,
                            _ command: CDVInvokedUrlCommand) {

        // We use a background thread to queue (and lock) multiple alerts, as we can't block the UI thread.
        DispatchQueue.init(label: "alert-plugin-auth").async {
            // Make sure other calls are blocked here (other plugin requests) before showing more popups
            // to users.
            self.pluginAlertLock.wait()

            let authority = self.getPluginAuthority(info.app_id, pluginName);
            if (authority != originAuthority) {
                self.pluginAlertLock.signal()
                self.sendCallbackResult("plugin", pluginName, authority, plugin, command);
                return;

            }
            self.alertPluginAuth(info, pluginName, plugin, command);
        }
    }

    func sendCallbackResult(_ name: String, _ value: String, _ auth: Int, _ plugin: CDVPlugin,
                            _ command: CDVInvokedUrlCommand) {

        var result = CDVPluginResult(status: CDVCommandStatus_OK);
        if (auth == AppInfo.AUTHORITY_ALLOW) {
            let _ = plugin.execute(command);

        }
        else {
            result = CDVPluginResult(status: CDVCommandStatus_ERROR,
                                         messageAs: name + ":'" + value + "' have not run authority.");
        }
        result?.setKeepCallbackAs(false);
        plugin.commandDelegate.send(result, callbackId: command.callbackId)
    }

    func alertPluginAuth(_ info: AppInfo, _ pluginName: String, _ plugin: CDVPlugin, _ command: CDVInvokedUrlCommand) {

        func doAllowHandler(alerAction:UIAlertAction) {
            try? setPluginAuthority(info.app_id, pluginName, AppInfo.AUTHORITY_ALLOW);
            pluginAlertLock.signal()
            sendCallbackResult("plugin", pluginName, AppInfo.AUTHORITY_ALLOW, plugin, command);
        }

        func doRefuseHandler(alerAction:UIAlertAction) {
            try? setPluginAuthority(info.app_id, pluginName, AppInfo.AUTHORITY_DENY);
            pluginAlertLock.signal()
            sendCallbackResult("plugin", pluginName, AppInfo.AUTHORITY_DENY, plugin, command);
        }

        let alertController = UIAlertController(title: "Plugin authority request",
                message: "App:'" + info.name + "' request plugin:'" + pluginName + "' access authority.",
                preferredStyle: UIAlertController.Style.alert)
        let cancelAlertAction = UIAlertAction(title: "Refuse", style: UIAlertAction.Style.cancel, handler: doRefuseHandler)
        alertController.addAction(cancelAlertAction)

        let allowAlertAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default, handler: doAllowHandler)
        alertController.addAction(allowAlertAction)

        DispatchQueue.main.async {
            // Show popup to user
            self.mainViewController.present(alertController, animated: true, completion: nil)
        }
    }

    func runAlertUrlAuth(_ info: AppInfo, _ url: String) {
        func doAllowHandler(alerAction:UIAlertAction) {
            try? setUrlAuthority(info.app_id, url, AppInfo.AUTHORITY_ALLOW);
        }

        func doRefuseHandler(alerAction:UIAlertAction) {
            try? setUrlAuthority(info.app_id, url, AppInfo.AUTHORITY_DENY);
        }

        let alertController = UIAlertController(title: "Url authority request",
                                                message: "App:'" + info.name + "' request url:'" + url + "' access authority.",
                                                preferredStyle: UIAlertController.Style.alert)
        let cancelAlertAction = UIAlertAction(title: "Refuse", style: UIAlertAction.Style.cancel, handler: doRefuseHandler)
        alertController.addAction(cancelAlertAction)
        let sureAlertAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default, handler: doAllowHandler)
        alertController.addAction(sureAlertAction)
        self.mainViewController.present(alertController, animated: true, completion: nil)
    }

    func getAppIdList() -> [String] {
        var ret = [String]();
        for info in appList {
            ret.append(info.app_id);
        }
        return ret;
    }

    func getAppInfoList() -> [AppInfo] {
        return appList;
    }

    func getRunningList() -> [String] {
        var ret = [String]();
        for id in viewControllers.keys {
            ret.append(id);
        }
        return ret;
    }

    func getLastList() -> [String] {
        return lastList;
    }

}
