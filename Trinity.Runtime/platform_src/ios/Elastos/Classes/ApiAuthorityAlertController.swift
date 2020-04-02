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

import UIKit

class ApiAuthorityAlertController: UIViewController {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var txtDesc: UITextField!
    
    @IBOutlet weak var btnDeny: UIButton!
    @IBOutlet weak var btnAllow: UIButton!
    
    var apiAlertLock: DispatchSemaphore?
    var appInfo: AppInfo?
    var plugin: String?
    var api: String?
    var pluginObj: CDVPlugin?
    var command: CDVInvokedUrlCommand?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if (appInfo != nil) {
            let authInfo = ApiAuthorityManager.getShareInstance().getApiAuthorityInfo(plugin!, api!)!;
            
            
            let title = authInfo.getLocalizedTitle()
            let description = authInfo.getLocalizedDescription();
            let level = authInfo.dangerLevel;
            
            var image: UIImage?
            
            let iconPaths = AppManager.getShareInstance().getIconPaths(appInfo!)
            if (iconPaths.count > 0) {
                let appIconPath = iconPaths[0]
                image = UIImage(contentsOfFile: appIconPath)
            }
            
        }
    }

    func setData(_ apiAlertLock: DispatchSemaphore,_ appInfo: AppInfo, _ plugin: String, _ api: String, _ pluginObj: CDVPlugin, _ command: CDVInvokedUrlCommand) {
        self.appInfo = appInfo;
        self.plugin = plugin;
        self.api = api;
        self.pluginObj = pluginObj;
        self.command = command;
    }
    
    private func setApiAuth(_ appId: String, _ plugin: String, _ api: String, _ auth: Int?) {
        try! AppManager.getShareInstance().getDBAdapter().setApiAuth(appId, plugin, api, auth);
    }
    
    private func sendCallbackResult(_ pluginName: String, _ api: String, _ auth: Int, _ plugin: CDVPlugin,
                            _ command: CDVInvokedUrlCommand) {

        var result = CDVPluginResult(status: CDVCommandStatus_OK);
        if (auth == AppInfo.AUTHORITY_ALLOW) {
            let _ = plugin.execute(command);

        }
        else {
            result = CDVPluginResult(status: CDVCommandStatus_ERROR,
                                         messageAs: "Api:'" + pluginName + "." + api + "' have not run authority.");
        }
        result?.setKeepCallbackAs(false);
        plugin.commandDelegate.send(result, callbackId: command.callbackId)
    }

    @IBAction func denyClicked(_ sender: Any) {
        setApiAuth(appInfo!.app_id, plugin!, api!, AppInfo.AUTHORITY_DENY);
        apiAlertLock!.signal()
        sendCallbackResult(plugin!, api!, AppInfo.AUTHORITY_DENY, pluginObj!, command!);
    }
    
    @IBAction func allowClicked(_ sender: Any) {
        setApiAuth(appInfo!.app_id, plugin!, api!, AppInfo.AUTHORITY_ALLOW);
        apiAlertLock!.signal()
        sendCallbackResult(plugin!, api!, AppInfo.AUTHORITY_ALLOW, pluginObj!, command!);
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
