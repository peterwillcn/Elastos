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

class MasterPasswordCreatorAlertController: UIViewController {
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblIntroduction: UILabel!
    @IBOutlet weak var contentBackground: UIView!
    @IBOutlet weak var etPassword: UITextField!
    @IBOutlet weak var etPasswordRepeat: UITextField!
    @IBOutlet weak var btCancel: AdvancedButton!
    @IBOutlet weak var btNext: AdvancedButton!
    @IBOutlet weak var passwordUnderline: UIView!
    @IBOutlet weak var passwordRepeatUnderline: UIView!
    
    private var canDisableMasterPasswordUse = true
    
    var onPasswordCreatedListener: ((_ password: String)->Void)?
    var onCancelListener: (()->Void)?
    var onDontUseMasterPasswordListener: (()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize colors
        view.layer.cornerRadius = 20
        view.backgroundColor = UIStyling.popupMainBackgroundColor
        contentBackground.backgroundColor = UIStyling.popupSecondaryBackgroundColor
        lblTitle.textColor = UIStyling.popupMainTextColor
        lblIntroduction.textColor = UIStyling.popupMainTextColor
        btCancel.bgColor = UIStyling.popupSecondaryBackgroundColor
        btCancel.titleColor = UIStyling.popupMainTextColor
        btCancel.cornerRadius = 8
        btNext.bgColor = UIStyling.popupSecondaryBackgroundColor
        btNext.titleColor = UIStyling.popupMainTextColor
        btNext.cornerRadius = 8
        etPassword.textColor = UIStyling.popupMainTextColor
        etPasswordRepeat.textColor = UIStyling.popupMainTextColor
        passwordUnderline.backgroundColor = UIStyling.popupMainBackgroundColor
        passwordRepeatUnderline.backgroundColor = UIStyling.popupMainBackgroundColor
        
        // Input placeholders
        etPassword.attributedPlaceholder = NSAttributedString(string: "Enter password",
        attributes: [NSAttributedString.Key.foregroundColor: UIStyling.popupInputHintTextColor])
        etPasswordRepeat.attributedPlaceholder = NSAttributedString(string: "Repeat password",
                                                                    attributes: [NSAttributedString.Key.foregroundColor: UIStyling.popupInputHintTextColor])
        
        // Focus password field when entering, so we can start typing at once
        etPassword.becomeFirstResponder()
    }
    
    public func setCanDisableMasterPasswordUse (_ canDisableMasterPasswordUse: Bool) {
        self.canDisableMasterPasswordUse = canDisableMasterPasswordUse
    }
    
    public func setOnCancelListener(_ listener: @escaping ()->Void) {
        self.onCancelListener = listener
    }

    public func setOnPasswordCreatedListener(_ listener: @escaping (_ password: String)->Void) {
        self.onPasswordCreatedListener = listener
    }

    @IBAction func cancelClicked(_ sender: Any) {
        self.onCancelListener?()
    }
    
    @IBAction func createClicked(_ sender: Any) {
        if let password = etPassword.text, let passwordConfirm = etPasswordRepeat.text, password != "", password == passwordConfirm {
            self.onPasswordCreatedListener?(password)
        }
    }
}
