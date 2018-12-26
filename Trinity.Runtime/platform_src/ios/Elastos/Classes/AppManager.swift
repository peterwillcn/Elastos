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

 class AppManager {
    public static var appManager: AppManager?;
    
    /** The internal message */
    static let MSG_TYPE_INTERNAL = 1;
    /** The internal return message. */
    static let MSG_TYPE_IN_RETURN = 2;
    /** The external launcher message */
    static let MSG_TYPE_EXTERNAL_LAUNCHER = 3;
    /** The external install message */
    static let MSG_TYPE_EXTERNAL_INSTALL = 4;
    /** The external return message. */
    static let MSG_TYPE_EX_RETURN = 5;
    
    let mainViewController: MainViewController;
    var viewControllers = [String: TrinityViewController]();
    
    let appsPath: String;
    let dataPath: String;
    
    var curController: TrinityViewController?;
    
    var dbAdapter = ManagerDBAdapter();
    
    var appList: [AppInfo];
    var appInfos = [String: AppInfo]();
    var lastList = [String]();
    let installer: AppInstaller;
    
    var installUriList = [String]();
    var launcherReady = false;
    
    init(_ mainViewController: MainViewController) {
        self.mainViewController = mainViewController;
        appsPath = NSHomeDirectory() + "/Documents/apps/";
        dataPath = NSHomeDirectory() + "/Documents/data/";
        
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
        
        installer = AppInstaller(appsPath, dataPath, dbAdapter);

        appList = dbAdapter.getAppInfos();
        if (appList.count < 1) {
            saveBuiltInAppInfos();
        }
//        dbAdapter.removeAppInfo(appList[0]);
        refreashInfos();
        
        AppManager.appManager = self;
    }
    
    func refreashInfos() {
        appList = dbAdapter.getAppInfos();
        appInfos = [String: AppInfo]();
        for info in appList {
            appInfos[info.id] = info;
        }
    }
    
    func getAppInfo(_ id: String) -> AppInfo? {
        return appInfos[id];
    }
    
    func getAppInfos() -> [String: AppInfo] {
        return appInfos;
    }
    
    func getStartPath(_ info: AppInfo) -> String {
        return resetPath(getAppUrl(info), info.start_url);
    }
    
    func getAppPath(_ info: AppInfo) -> String {
        return appsPath + info.id;
    }
    
    func getAppUrl(_ info: AppInfo) -> String {
        if (info.built_in) {
            return "file://" + self.getAbsolutePath("www/built-in")  + "/" + info.id + "/";
        }
        else {
            return "file://" + appsPath + info.id + "/";
        }
    }
    
    func getDataPath(_ info: AppInfo) -> String {
        return dataPath + info.id;
    }
    
    func getDataUrl(_ info: AppInfo) -> String {
        return "file://" + dataPath + info.id + "/";
    }
    
    func saveBuiltInAppInfos() {
        let path = getAbsolutePath("www/built-in") + "/";
        
        let fileManager = FileManager.default;
        let dirs = try? fileManager.contentsOfDirectory(atPath: path);
        guard dirs != nil else {
            return;
        }
        
        for dir in dirs! {
            let info = installer.parseManifest(path +  dir + "/manifest.json")
            guard (info != nil || info!.id != "") else {
                return;
            }
            
            info!.built_in = true;
            dbAdapter.addAppInfo(info!);
        }
    }

    func install(_ url: String) -> AppInfo? {
        let info = installer.install(self, url);
        if (info != nil) {
            refreashInfos();
        }
        return info;
    }
    
    func unInstall(_ id: String) -> Bool {
        if (!close(id)) {
            return false;
        }
        
        let ret = installer.unInstall(appInfos[id]);
        if (ret) {
            refreashInfos();
        }
        return ret;
    }
    
    func removeLastlistItem(_ id: String) {
        for (index, item) in lastList.enumerated() {
            if item == id {
                lastList.remove(at: index);
                break;
            }
        }
    }
    
    func switchContent(_ to: TrinityViewController, _ id: String) {
        mainViewController.switchController(from: curController!, to: to)
        removeLastlistItem(id);
        lastList.insert(id, at: 0);
    }

    func start(_ id: String) -> Bool {
        var viewController = viewControllers[id]
        if viewController == nil {
            if (id == "launcher") {
                viewController = LauncherViewController();
            }
            else {
                let appInfo = appInfos[id];
                guard appInfo != nil else {
                    print("No app of id = " + id);
                    return false;
                }
                let appViewController = AppViewController();
                appViewController.setInfo(id, appInfo!);
                viewController = appViewController;
//                viewController?.startPage = "built-in/org.elastos.trinity.demo1/demo1.html";
            }
            
            mainViewController.add(viewController!)
            viewControllers[id] = viewController;
            lastList.insert(id, at: 0);
        }
        else {
            if (curController != viewController) {
                switchContent(viewController!, id);
            }
        }
        
        curController = viewController
        return true;
    }
    
    func close(_ id: String) -> Bool {
        if (id == "launcher") {
            return false;
        }
        
        let info = appInfos[id];
        if (info == nil) {
            return false;
        }
    
        let viewController = viewControllers[id]
        if (viewController == nil) {
            return true;
        }
    
        if (viewController == curController) {
            let id2 = lastList[1];
            let viewController2 = viewControllers[id2]
            if (viewController2 == nil) {
                return false;
            }
            switchContent(viewController2!, id2);
        }
        
        removeLastlistItem(id);
        viewControllers[id] = nil;
        viewController!.remove();
        
        return true;
    }
    
    
    func loadLauncher() -> Bool {
        return start("launcher");
    }
    
    func setInstallUri(_ uri: String) {
        if launcherReady {
            self.sendMessage("launcher", AppManager.MSG_TYPE_EXTERNAL_INSTALL, uri, "system");
        }
        else {
            installUriList.append(uri);
        }
    }
    
    func isLauncherReady() -> Bool {
        return launcherReady;
    }
    
    func setLauncherReady() {
        launcherReady = true;
    
        for uri in installUriList {
            self.sendMessage("launcher", AppManager.MSG_TYPE_EXTERNAL_INSTALL, uri, "system");
        }
    }

    func getAbsolutePath(_ path: String, _ type: String? = nil) -> String {
        let nsPath: NSString = path as NSString;
        if !nsPath.isAbsolutePath {
            let absolutePath = Bundle.main.path(forResource: path, ofType: nil)
            if absolutePath != nil {
                return absolutePath!;
            }
        }
        return path;
    }

    func sendMessage(_ toId: String, _ type: Int, _ msg: String, _ fromId: String) -> Bool {
        let viewController = viewControllers[toId]
        if (viewController != nil) {
            viewController!.basePlugin!.onReceive(msg, type, fromId);
            return true;
        }
        else {
            return false;
        }
    }
    
    func getPluginAuthority(_ id: String, _ plugin: String) -> Int {
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
    
    func setPluginAuthority(_ id: String, _ plugin: String, _ authority: Int) {
        let info = appInfos[id];
        if (info != nil) {
            for pluginAuth in info!.plugins {
                if (pluginAuth.plugin == plugin) {
                    dbAdapter.updatePluginAuth(pluginAuth, authority);
                    return;
                }
            }
        }
    }
    
    func setUrlAuthority(_ id: String, _ url: String, _ authority: Int) {
        let info = appInfos[id];
        if (info != nil) {
            for urlAuth in info!.urls {
                if (urlAuth.url == url) {
                    dbAdapter.updateUrlAuth(urlAuth, authority);
                    return;
                }
            }
        }
    }

    func runAlertPluginAuth(_ info: AppInfo, _ plugin: String) {
        func doAllowHandler(alerAction:UIAlertAction) {
            setPluginAuthority(info.id, plugin, AppInfo.AUTHORITY_ALLOW);
        }
        
        func doRefuseHandler(alerAction:UIAlertAction) {
            setPluginAuthority(info.id, plugin, AppInfo.AUTHORITY_DENY);
        }
        
        let alertController = UIAlertController(title: "Plugin authority request",
                message: "App:'" + info.name + "' request plugin:'" + plugin + "' access authority.",
                preferredStyle: UIAlertController.Style.alert)
        let cancelAlertAction = UIAlertAction(title: "Refuse", style: UIAlertAction.Style.cancel, handler: doRefuseHandler)
        alertController.addAction(cancelAlertAction)
        let sureAlertAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default, handler: doAllowHandler)
        alertController.addAction(sureAlertAction)
        self.mainViewController.present(alertController, animated: true, completion: nil)
    }
    
    func runAlertUrlAuth(_ info: AppInfo, _ url: String) {
        func doAllowHandler(alerAction:UIAlertAction) {
            setUrlAuthority(info.id, url, AppInfo.AUTHORITY_ALLOW);
        }
        
        func doRefuseHandler(alerAction:UIAlertAction) {
            setUrlAuthority(info.id, url, AppInfo.AUTHORITY_DENY);
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
    
    func getRunningList() -> [String] {
        var ret = [String]();
        for id in viewControllers.keys {
            ret.append(id);
        }
        return ret;
    }
    
    func getAppList() -> [String] {
        var ret = [String]();
        for info in appList {
            ret.append(info.id);
        }
        return ret;
    }
    
    func getLastList() -> [String] {
        return lastList;
    }
    
}
