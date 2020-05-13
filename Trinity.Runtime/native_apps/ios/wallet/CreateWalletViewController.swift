
import Foundation

class CreateWalletViewController: UIViewController {
    var basePlugin: AppBasePlugin?

    @IBOutlet weak var walletNameTF: UITextField!
    @IBOutlet weak var payPasswordTF: UITextField!
    @IBOutlet weak var rePasswordTF: UITextField!
    @IBOutlet weak var confirmBtn: UIButton!
    let wallet: SPVWallet = SPVWallet.shared()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Create Wallet"
        self.navigationController?.navigationBar.isHidden = true
        self.hideKeyboardWhenTappedAround()
        commonInit()
    }

    func commonInit() {
        let placeholserAttributes = [NSAttributedString.Key.foregroundColor : UIColor.lightText,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 11)]
        walletNameTF.attributedPlaceholder = NSAttributedString(string: "Wallet can not be empty",attributes: placeholserAttributes)
        payPasswordTF.attributedPlaceholder = NSAttributedString(string: "must be 8 or more characters",attributes: placeholserAttributes)
        rePasswordTF.attributedPlaceholder = NSAttributedString(string: "repeat paypassword",attributes: placeholserAttributes)
    }

    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.view.removeFromSuperview()
    }
    
    @IBAction func confirmAction(_ sender: UIButton) {
        guard checkInput() else {
            return
        }
        do {
            mnemonic = try wallet.generateMnemonic(withLanguage: mnemonicLang)
            masterWalletName = walletNameTF.text!
            masterWalletID = getMasterWalletID()
            payPassword = payPasswordTF.text!
            let showVC = ShowmMnomicViewController()
            let navigationDic = [NSAttributedString.Key.foregroundColor : UIColor.white]
            showVC.navigationController?.navigationBar.titleTextAttributes = navigationDic
            self.navigationController?.pushViewController(showVC, animated: true)
        } catch {
            print("error: generateMnemonic error")
            return
        }
    }

    func checkInput() -> Bool {
        if (walletNameTF.text?.count == 0) {
            let hud = SwiftProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.titleText = "Please input the wallet name"
            hud.mode = .text
            hud.afterDelay = 2
            return false
        }
        if payPasswordTF.text!.count == 0 {
            let hud = SwiftProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.titleText = "Please enter the payment password"
            hud.mode = .text
            hud.afterDelay = 2
            return false
        }
        else if payPasswordTF.text!.count < 8 {
            let hud = SwiftProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.titleText = "The minimum password length is 8 bits"
            hud.mode = .text
            hud.afterDelay = 2
            return false
        }

        if rePasswordTF.text?.count == 0 {
            let hud = SwiftProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.titleText = "Please confirm the password again"
            hud.mode = .text
            hud.afterDelay = 2
            return false
        }
        else if payPasswordTF.text != rePasswordTF.text {
            let hud = SwiftProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.titleText = "The two passwords are inconsistent"
            hud.mode = .text
            hud.afterDelay = 2
            return false
        }

        return true
    }

    // hidekeyboard
      func hideKeyboardWhenTappedAround() {
          let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
          tap.cancelsTouchesInView = false
          view.addGestureRecognizer(tap)
      }

      @objc private func dismissKeyboard() {
          view.endEditing(true)
      }
}
