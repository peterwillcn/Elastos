/*
 * Copyright (c) 2020 Elastos Foundation
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
import PopupDialog

public enum ApiDangerLevel: String {
    case LOW = "low"
    case MEDIUM = "medium"
    case HIGH = "high"
}

class ApiAuthorityInfo {
    var dangerLevel = "high";
    var title = [String: String]();
    var description = [String: String]();
    
    init() {
    }

    init(_ dangerLevel: String, _ title: [String: String], _ description: [String: String]) {
        self.dangerLevel = dangerLevel;
        self.title = title;
        self.description = description;
    }
    
    func getLocalizedTitle() -> String {
        let local = PreferenceManager.getShareInstance().getStringValue("locale.language", "en");
        
        var ret = self.title[local];
        if (ret == nil) {
            ret = self.title["en"];
        }
        return ret!;
    }
    
    func getLocalizedDescription() -> String {
        let local = PreferenceManager.getShareInstance().getStringValue("locale.language", "en");
        var ret = self.description[local];
        if (ret == nil) {
            ret = self.description["en"];
        }
        return ret!;
    }
}

class ApiAuthorityManager {
    var infoList = [String: ApiAuthorityInfo]();
    static var apiAuthorityManager: ApiAuthorityManager?;
    let dbAdapter: ManagerDBAdapter;
    let appManager: AppManager;

    public init() {
        appManager = AppManager.getShareInstance();
        dbAdapter = appManager.getDBAdapter();
        do {
            try parseJson();
        }
        catch let error {
            print("PermissionManager para config error: \(error)");
        }

        ApiAuthorityManager.apiAuthorityManager = self;
    }

    static func getShareInstance() -> ApiAuthorityManager {
        if (ApiAuthorityManager.apiAuthorityManager == nil) {
            ApiAuthorityManager.apiAuthorityManager = ApiAuthorityManager();
        }
        return ApiAuthorityManager.apiAuthorityManager!;
    }

    func parseJson() throws {
        let path = getAbsolutePath("www/config/authority/api.json");
        let url = URL.init(fileURLWithPath: path)

        let data = try Data(contentsOf: url);
        let json = try JSONSerialization.jsonObject(with: data,
        options: []) as! [String: [String: [String: Any]]];

        for (plugin, apis) in json {
            for (api, obj) in apis {
                let info = ApiAuthorityInfo();
                if (obj["danger_level"] != nil) {
                    info.dangerLevel = obj["danger_level"] as! String;
                }
                
                if (obj["title"] != nil) {
                    info.title = obj["title"] as! [String: String];
                }
                
                if (obj["description"] != nil) {
                    info.description = obj["description"] as! [String: String];
                }
                
                infoList[plugin.lowercased() + "." + api] = info;
            }
        }
    }
    
    func getApiAuthorityInfo(_ plugin: String, _ api: String) -> ApiAuthorityInfo? {
        return infoList[plugin.lowercased() + "." + api];
    }
    
    private func getApiAuth(_ appId: String, _ plugin: String, _ api: String) -> Int {
        var ret = try! self.dbAdapter.getApiAuth(appId, plugin, api);
        if (ret == nil) {
            ret = AppInfo.AUTHORITY_NOINIT;
        }
        return ret!;
    }
    
    private func setApiAuth(_ appId: String, _ plugin: String, _ api: String, _ auth: Int?) {
        try! self.dbAdapter.setApiAuth(appId, plugin, api, auth);
    }
    
    private func sendCallbackResult(_ pluginName: String, _ api: String, _ auth: Int, _ plugin: CDVPlugin,
                            _ command: CDVInvokedUrlCommand) {

        var result = CDVPluginResult(status: CDVCommandStatus_OK);
        if (auth == AppInfo.AUTHORITY_ALLOW) {
            let _ = plugin.execute(command);

        }
        else {
            result = CDVPluginResult(status: CDVCommandStatus_ERROR,
                                         messageAs: "Api:'" + pluginName + "." + api + "' doesn't have authority to run.");
        }
        result?.setKeepCallbackAs(false);
        plugin.commandDelegate.send(result, callbackId: command.callbackId)
    }

    private func alertApiAuth(_ info: AppInfo, _ plugin: String, _ api: String, _ pluginObj: CDVPlugin, _ command: CDVInvokedUrlCommand) {

        func doAllowHandler(alerAction:UIAlertAction) {
            setApiAuth(info.app_id, plugin, api, AppInfo.AUTHORITY_ALLOW);
            apiAlertLock.signal()
            sendCallbackResult(plugin, api, AppInfo.AUTHORITY_ALLOW, pluginObj, command);
        }

        func doRefuseHandler(alerAction:UIAlertAction) {
            setApiAuth(info.app_id, plugin, api, AppInfo.AUTHORITY_DENY);
            apiAlertLock.signal()
            sendCallbackResult(plugin, api, AppInfo.AUTHORITY_DENY, pluginObj, command);
        }
        
        let authInfo = self.getApiAuthorityInfo(plugin, api)!;
        let content = "------title: " + authInfo.getLocalizedTitle() + " ------description: " + authInfo.getLocalizedDescription();

        let alertController = UIAlertController(title: "Api authority request",
                message: "App:'" + info.name + "' request api:'" + plugin + "." + api + "' access authority." + content,
                preferredStyle: UIAlertController.Style.alert)
        let cancelAlertAction = UIAlertAction(title: "Refuse", style: UIAlertAction.Style.cancel, handler: doRefuseHandler)
        alertController.addAction(cancelAlertAction)

        let allowAlertAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default, handler: doAllowHandler)
        alertController.addAction(allowAlertAction)
        
        DispatchQueue.main.async {
            // Show popup to user
            self.appManager.mainViewController.present(alertController, animated: true, completion: nil)
        }
    }
    private let apiAlertLock = DispatchSemaphore(value: 1)

    /**
     Ask user if he is willing to let the given api run for this application or not.
     */
    func runAlertApiAuth(_ info: AppInfo, _ plugin: String, _ api: String,
                            _ originAuthority: Int,
                            _ pluginObj: CDVPlugin,
                            _ command: CDVInvokedUrlCommand) {

        // We use a background thread to queue (and lock) multiple alerts, as we can't block the UI thread.
        DispatchQueue.init(label: "alert-api-auth").async {
            // Make sure other calls are blocked here (other plugin requests) before showing more popups
            // to users.
            self.apiAlertLock.wait()

            let authority = self.getApiAuth(info.app_id, plugin, api);
            if (authority != originAuthority) {
                self.apiAlertLock.signal()
                self.sendCallbackResult(plugin, api, authority, pluginObj, command);
                return;
            }
//            self.alertApiAuth(info, plugin, api, pluginObj, command);
            DispatchQueue.main.async {
                self.popupAlertDialog(info, plugin, api, pluginObj, command);
            }
        }
    }
    
    private func popupAlertDialog(_ info: AppInfo, _ plugin: String, _ api: String, _ pluginObj: CDVPlugin, _ command: CDVInvokedUrlCommand) {
        // Create the dialog
        let apiAuthorityController = ApiAuthorityAlertController(nibName: "ApiAuthorityAlertController", bundle: Bundle.main)
        
        apiAuthorityController.setData(apiAlertLock, info, plugin, api, pluginObj, command)
        
        // TODO: MAKE POPUP NOT DISMISSABLE
        
        let popup = PopupDialog(viewController: apiAuthorityController)
        self.appManager.mainViewController.present(popup, animated: false, completion: nil)
        
        // Permission was granted by the user
        apiAuthorityController.setOnAllowListener {
            popup.dismiss()
            
            try! AppManager.getShareInstance().getDBAdapter().setApiAuth(info.app_id, plugin, api, AppInfo.AUTHORITY_ALLOW)
            
            self.apiAlertLock.signal()
            self.sendCallbackResult(plugin, api, AppInfo.AUTHORITY_ALLOW, pluginObj, command)
        }
        
        // Permission was refused by the user
        apiAuthorityController.setOnDenyListener {
            popup.dismiss()
            
            try! AppManager.getShareInstance().getDBAdapter().setApiAuth(info.app_id, plugin, api, AppInfo.AUTHORITY_DENY)
            
            self.apiAlertLock.signal()
            self.sendCallbackResult(plugin, api, AppInfo.AUTHORITY_DENY, pluginObj, command)
        }
    }
    
    
    func getApiAuthority(_ appId: String, _ plugin: String,
                                  _ pluginObj: CDVPlugin,
                                  _ command: CDVInvokedUrlCommand) -> Int {
        let api = command.methodName!;
        let info = self.getApiAuthorityInfo(plugin, api);
        if (info != nil) {
            setApiAuth(appId, plugin, api, nil);
            let authority = getApiAuth(appId, plugin, api);
            if (authority == AppInfo.AUTHORITY_NOINIT || authority == AppInfo.AUTHORITY_ASK) {
                let result = CDVPluginResult(status: CDVCommandStatus_NO_RESULT);
                result?.setKeepCallbackAs(true);
                pluginObj.commandDelegate.send(result, callbackId: command.callbackId);
                let appInfo = appManager.getAppInfo(appId);

                runAlertApiAuth(appInfo!, plugin, api, authority, pluginObj, command);
            }
            return authority;
        }
        return AppInfo.AUTHORITY_ALLOW;
    }


}

