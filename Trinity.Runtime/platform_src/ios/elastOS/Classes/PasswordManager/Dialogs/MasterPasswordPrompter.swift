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
import LocalAuthentication

class MasterPasswordPrompterAlertController: UIViewController {
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblIntroduction: UILabel!
    @IBOutlet weak var lblTryAgain: UILabel!
    @IBOutlet weak var contentBackground: UIView!
    @IBOutlet weak var etPassword: UITextField!
    @IBOutlet weak var btCancel: AdvancedButton!
    @IBOutlet weak var btNext: AdvancedButton!
    @IBOutlet weak var passwordUnderline: UIView!
    @IBOutlet weak var swBiometric: UISwitch!
    @IBOutlet weak var lblBiometricSwitch: UILabel!
    @IBOutlet weak var passwordContainer: UIView!
    
    private var passwordManager: PasswordManager? = nil
    
    private var isPasswordRetry: Bool = false
    private var shouldInitiateBiometry: Bool = false // Whether biometry should be prompted to save password, or just used (previously saved)
    
    var onPasswordTypedListener: ((_ password: String, _ shouldSavePasswordToBiometric: Bool)->Void)?
    var onCancelListener: (()->Void)?
    var onErrorListener: ((_ error: String)->Void)?
    
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
        passwordUnderline.backgroundColor = UIStyling.popupMainBackgroundColor
        lblBiometricSwitch.textColor = UIStyling.popupMainTextColor
        
        // Input placeholders
        etPassword.attributedPlaceholder = NSAttributedString(string: "Enter password",
        attributes: [NSAttributedString.Key.foregroundColor: UIStyling.popupInputHintTextColor])
        
        // Focus password field when entering, so we can start typing at once
        etPassword.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Handle wrong password case
        if isPasswordRetry {
            lblTryAgain.isHidden = false
        }
        else {
            lblTryAgain.isHidden = true
        }
        
        // Biometry
        swBiometric.isOn = passwordManager!.isBiometricAuthEnabled()
        
        // If biometric auth is not enabled, we will follow the flow to initiate it during this prompter session.
        shouldInitiateBiometry = !passwordManager!.isBiometricAuthEnabled()

        if (canUseBiometrictAuth()) {
            if (shouldInitiateBiometry) {
                setTextPasswordVisible(true)
            }
            else {
                setTextPasswordVisible(false)
            }
        }
        else {
            // No biometric auth mechanism available - hide the feature
            swBiometric.isHidden = true
            lblBiometricSwitch.isHidden = true
        }
    }
    
    public func setPasswordManager(_ passwordManager: PasswordManager) {
        self.passwordManager = passwordManager
    }
    
    public func setPreviousAttemptWasWrong(_ previousAttemptWasWrong: Bool) {
        self.isPasswordRetry = previousAttemptWasWrong
    }
    
    private func setTextPasswordVisible(_ shouldShow: Bool) {
        if shouldShow {
            passwordContainer.isHidden = false
        }
        else {
            passwordContainer.isHidden = true
        }
    }

    private func canUseBiometrictAuth() -> Bool {
        let context = LAContext()
        var error: NSError?
        
        let evaluation = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        if evaluation {
            return true
        }
        else {
            return false
        }
    }
    
    public func setOnCancelListener(_ listener: @escaping ()->Void) {
        self.onCancelListener = listener
    }
    
    public func setOnErrorListener(_ listener: @escaping (_ error: String)->Void) {
        self.onErrorListener = listener
    }

    public func setOnPasswordTypedListener(_ listener: @escaping (_ password: String, _ shouldSavePasswordToBiometric: Bool)->Void) {
        self.onPasswordTypedListener = listener
    }

    @IBAction func cancelClicked(_ sender: Any) {
        self.onCancelListener?()
    }
    
    @IBAction func nextClicked(_ sender: Any) {
        // Disable biometric auth for next times if user doesn't want to use that any more
        if (!swBiometric.isOn) {
            passwordManager!.setBiometricAuthEnabled(false)
        }
        
        let shouldSaveToBiometric = shouldInitiateBiometry && swBiometric.isOn
        if (swBiometric.isOn && !shouldInitiateBiometry) {
            let fingerPrintAuthHelper = FingerPrintAuthHelper(dAppID: PasswordManager.FAKE_PASSWORD_MANAGER_PLUGIN_APP_ID)
            
            
            fingerPrintAuthHelper.authenticateAndGetPassword(passwordKey: PasswordManager.MASTER_PASSWORD_BIOMETRIC_KEY) { password, error  in
                if error == nil {
                    self.onPasswordTypedListener?(password!, shouldSaveToBiometric)
                }
                else {
                    self.onErrorListener?("Fingerprint plugin error: \(error.debugDescription)")
                }
            }
        }
        else {
            // Only allow validating the popup if some password is set
            if let password = etPassword.text, password != "" {
                self.onPasswordTypedListener?(password, shouldSaveToBiometric)
            }
        }
    }
    
    @IBAction func swBiometricValueChanged(_ sender: UISwitch) {
        print("changed")
        print(sender.isOn)
        
        if (sender.isOn) {
            // Willing to enable biometric auth?
        }
        else {
            // Willing to disable biometric auth?
            shouldInitiateBiometry = true
            setTextPasswordVisible(true)

            // Focus the password input
            etPassword.becomeFirstResponder()
        }
    }
}
