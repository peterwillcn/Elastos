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
    @IBOutlet weak var lblFeature: UILabel!
    @IBOutlet weak var lblFeatureValue: UILabel!
    @IBOutlet weak var lblCapability: UILabel!
    @IBOutlet weak var lblCapabilitiesValue: UILabel!
    @IBOutlet weak var contentBackgorund: UIView!
    @IBOutlet weak var imgRisk: UIImageView!
    @IBOutlet weak var lblRisk: UILabel!
    @IBOutlet weak var btnDeny: AdvancedButton!
    @IBOutlet weak var btnAccept: AdvancedButton!
    
    var appInfo: AppInfo?
    var plugin: String?
    var api: String?
    
    var onClickedListener: ((_ auth: Int)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let authInfo = ApiAuthorityManager.getShareInstance().getApiAuthorityInfo(plugin!, api!)!
        
        // Customize colors
        view.layer.cornerRadius = 20
        view.backgroundColor = UIStyling.popupMainBackgroundColor
        contentBackgorund.backgroundColor = UIStyling.popupSecondaryBackgroundColor
        lblAppName.textColor = UIStyling.popupMainTextColor
        lblIntroduction.textColor = UIStyling.popupMainTextColor
        lblFeature.textColor = UIStyling.popupMainTextColor
        lblFeatureValue.textColor = UIStyling.popupMainTextColor
        lblCapability.textColor = UIStyling.popupMainTextColor
        lblCapabilitiesValue.textColor = UIStyling.popupMainTextColor
        lblRisk.textColor = UIStyling.popupMainTextColor
        btnDeny.bgColor = UIStyling.popupSecondaryBackgroundColor
        btnDeny.titleColor = UIStyling.popupMainTextColor
        btnDeny.cornerRadius = 8
        btnAccept.bgColor = UIStyling.popupSecondaryBackgroundColor
        btnAccept.titleColor = UIStyling.popupMainTextColor
        btnAccept.cornerRadius = 8
        
        // Apply data
        lblAppName.text = appInfo!.name
        lblIntroduction.text = "This capsule is requesting access to a sensitive feature"
        lblFeatureValue.text = authInfo.getLocalizedTitle()
        lblCapabilitiesValue.text = authInfo.getLocalizedDescription();
        
        if authInfo.dangerLevel == ApiDangerLevel.LOW.rawValue {
            imgRisk.image = UIImage(named: "ic_risk_green")
            lblRisk.text = "Low Risk"
            view.layer.borderColor = UIColor(hex: "#5cd552")?.cgColor
            view.layer.borderWidth = 1
            
        }
        else if authInfo.dangerLevel == ApiDangerLevel.HIGH.rawValue {
            imgRisk.image = UIImage(named: "ic_risk_red")
            lblRisk.text = "Average Risk"
            view.layer.borderColor = UIColor(hex: "#f55555")?.cgColor
            view.layer.borderWidth = 1
        }
        else {
            imgRisk.image = UIImage(named: "ic_risk_yellow")
            lblRisk.text = "Potentially Harmful"
            view.layer.borderColor = UIColor(hex: "#fdd034")?.cgColor
            view.layer.borderWidth = 1
        }
        
        let iconPaths = AppManager.getShareInstance().getIconPaths(appInfo!)
        if (iconPaths.count > 0) {
            let appIconPath = iconPaths[0]
            let image = UIImage(contentsOfFile: appIconPath)
            imgIcon.image = image
        }
    }

    func setData(_ appInfo: AppInfo, _ plugin: String, _ api: String) {
        self.appInfo = appInfo
        self.plugin = plugin
        self.api = api
    }
    
    public func setOnClickedListener(_ listener: @escaping (_ auth: Int)-> Void) {
        self.onClickedListener = listener
    }

    @IBAction func denyClicked(_ sender: Any) {
        self.onClickedListener!(AppInfo.AUTHORITY_DENY);
    }
    
    @IBAction func allowClicked(_ sender: Any) {
        self.onClickedListener!(AppInfo.AUTHORITY_ALLOW);
    }
}
