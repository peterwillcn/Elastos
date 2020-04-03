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
    @IBOutlet weak var lblAppName: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblIntroduction: UILabel!
    @IBOutlet weak var lblCategoryValue: UILabel!
    @IBOutlet weak var lblFeatureValue: UILabel!
    @IBOutlet weak var lblCapabilitiesValue: UILabel!
    
    @IBOutlet weak var btnDeny: UIButton!
    @IBOutlet weak var btnAllow: UIButton!
    
    var apiAlertLock: DispatchSemaphore?
    var appInfo: AppInfo?
    var plugin: String?
    var api: String?
    var pluginObj: CDVPlugin?
    var command: CDVInvokedUrlCommand?
    
    var onAllowListener: (()->Void)?
    var onDenyListener: (()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let authInfo = ApiAuthorityManager.getShareInstance().getApiAuthorityInfo(plugin!, api!)!
        
        lblAppName.text = appInfo!.name
        lblIntroduction.text = "This application is requesting access to a sensitive feature"
        lblFeatureValue.text = authInfo.getLocalizedTitle()
        lblCapabilitiesValue.text = authInfo.getLocalizedDescription();
        //let level = authInfo.dangerLevel;
        
        let iconPaths = AppManager.getShareInstance().getIconPaths(appInfo!)
        if (iconPaths.count > 0) {
            let appIconPath = iconPaths[0]
            let image = UIImage(contentsOfFile: appIconPath)
            imgIcon.image = image
        }
    }

    func setData(_ apiAlertLock: DispatchSemaphore,_ appInfo: AppInfo, _ plugin: String, _ api: String, _ pluginObj: CDVPlugin, _ command: CDVInvokedUrlCommand) {
        self.apiAlertLock = apiAlertLock
        self.appInfo = appInfo
        self.plugin = plugin
        self.api = api
        self.pluginObj = pluginObj
        self.command = command
    }
    
    public func setOnAllowListener(_ listener: @escaping ()-> Void) {
        self.onAllowListener = listener
    }
    
    public func setOnDenyListener(_ listener: @escaping ()-> Void) {
        self.onDenyListener = listener
    }
    
    @IBAction func denyClicked(_ sender: Any) {
        self.onDenyListener?()
    }
    
    @IBAction func allowClicked(_ sender: Any) {
        self.onAllowListener?()
    }
}
