
import UIKit

class SendViewController: UIViewController {

    @IBOutlet weak var addressTextFied: UITextField!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var memoTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var confirmContainerView: UIView!
    @IBOutlet weak var confirmTrailingConstant: NSLayoutConstraint!
    @IBOutlet weak var confirmHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var maskView: UIView!
    var balance: String = ""
    var address: String = ""
    var rawTransaction: String = ""
    var crawTxJson: String = ""
    var payPassword: String = ""
    var confirmView: ConfirmView?
    let wallet = SPVWallet.shared()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        commonInit()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        balanceLabel.text = "Balance: \(changeEla(balance))"
    }

    func commonInit() {
        confirmContainerView.backgroundColor = UIColor.clear
        let placeholserAttributes = [NSAttributedString.Key.foregroundColor : UIColor.lightText,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 11)]
        addressTextFied.attributedPlaceholder = NSAttributedString(string: "Target address",attributes: placeholserAttributes)
        amountTextField.attributedPlaceholder = NSAttributedString(string: "Amount",attributes: placeholserAttributes)
        memoTextField.attributedPlaceholder = NSAttributedString(string: "Memo",attributes: placeholserAttributes)
        confirmView = Bundle.main.loadNibNamed("ConfirmView", owner: nil)![0] as? ConfirmView
        self.confirmContainerView.addSubview(confirmView!)
        confirmView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 260)
        confirmView?.cancelButton.addTarget(self, action: #selector(closeAction), for: UIControl.Event.touchUpInside)
        confirmView?.confirmButton.addTarget(self, action: #selector(confirmAction), for: UIControl.Event.touchUpInside)
        self.confirmView?.passwordTextField.isSecureTextEntry = true
        self.maskView.isHidden = true
    }

    func checkIsAddressValidAndCreateTransaction() -> Bool {
        do {
            let re: Bool = ((try wallet?.isAddressValid(masterWalletID, addr: addressTextFied.text)) != nil)
            guard re else {
                let hud = SwiftProgressHUD.showHUDAddedTo(self.view, animated: true)
                hud.titleText = "Invalid address, please check the transfer address."
                hud.mode = .text
                hud.afterDelay = 2
                return false
            }
            let balance = try wallet!.getBalance(masterWalletID, chainID: chainID)
            if amountTextField.text! >= changeEla(balance) {
                let hud = SwiftProgressHUD.showHUDAddedTo(self.view, animated: true)
                hud.titleText = "Insufficient balance."
                hud.mode = .text
                hud.afterDelay = 2
                return false
            }
            rawTransaction = try wallet!.createTransaction(masterWalletID, chainID: chainID, fromAddress: "", toAddress: addressTextFied.text!, amount: changeSEla(amountTextField.text!), memo: memoTextField.text ?? "")
            print(rawTransaction)
        } catch {
            print("isAddressValid error.")
            let hud = SwiftProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.titleText = "Failed to create transaction."
            hud.mode = .text
            hud.afterDelay = 2
            return false
        }
        return true
    }

    func confirmTransaction() {
        guard checkPayPassword() else {
            return
        }
        do {
            crawTxJson = try wallet!.signTransaction(masterWalletID, chainID: chainID, rawTransaction: rawTransaction, payPassword: confirmView?.passwordTextField.text)
            let re = try wallet!.publishTransaction(masterWalletID, chainID: chainID, rawTxJson: crawTxJson)
            print(re)
        } catch {
        }
    }

    func checkPayPassword() -> Bool {
        if confirmView?.passwordTextField.text == nil || confirmView!.passwordTextField.text!.count < 8 {
            let hud = SwiftProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.titleText = "Please enter the correct payment password"
            hud.mode = .text
            hud.afterDelay = 2
            return false
        }
        return true
    }

    func renderConfirmView() {
        confirmView?.cancelButton.setImage(UIImage(named: "ic_close"), for: .normal)
        confirmView?.cancelButton.widthAnchor.constraint(equalToConstant: 18.0).isActive = true
        confirmView?.cancelButton.heightAnchor.constraint(equalToConstant: 18.0).isActive = true
        confirmView?.addressLabel.text = addressTextFied.text
        confirmView?.amountLabel.text = amountTextField.text
        let placeholserAttributes = [NSAttributedString.Key.foregroundColor : UIColor.lightText,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 11)]
        confirmView?.passwordTextField.attributedPlaceholder = NSAttributedString(string: "Input paypassword",attributes: placeholserAttributes)
    }

    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @objc
    @IBAction func sendAction(_ sender: UIButton) {
        guard checkInput() else {
            return
        }
        guard checkIsAddressValidAndCreateTransaction() else {
            return
        }
        renderConfirmView()
        UIView.animate(withDuration: 0.4) {
            if self.confirmTrailingConstant.constant == 0 {
                self.confirmTrailingConstant.constant = -self.confirmHeightConstant.constant + 5
                self.maskView.isHidden = true
                self.navigationController?.setNavigationBarHidden(false, animated: false)
                self.view.layoutIfNeeded()
            } else {
                self.confirmTrailingConstant.constant = 0 + 120
                self.maskView.isHidden = false
                self.navigationController?.setNavigationBarHidden(true, animated: false)
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc func confirmAction(_ sender: UIButton) {
        confirmTransaction()
        closeAction(sender)
        self.navigationController?.view.removeFromSuperview()
    }

    @objc func closeAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.4) {
            if self.confirmTrailingConstant.constant == 0 {
                self.confirmTrailingConstant.constant = -self.confirmHeightConstant.constant
                self.maskView.isHidden = true
                self.navigationController?.setNavigationBarHidden(false, animated: false)
                self.view.layoutIfNeeded()
            } else {
                self.confirmTrailingConstant.constant = 0
                self.maskView.isHidden = false
                self.navigationController?.setNavigationBarHidden(true, animated: false)
                self.view.layoutIfNeeded()
            }
        }
    }

    func checkInput() -> Bool {
        if (addressTextFied.text?.count == 0) {
            let hud = SwiftProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.titleText = "Please enter wallet address"
            hud.mode = .text
            hud.afterDelay = 2
            return false
        }
        if amountTextField.text!.count == 0 {
            let hud = SwiftProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.titleText = "Please enter the transfer amount"
            hud.mode = .text
            hud.afterDelay = 2
            return false
        }

        if memoTextField.text?.count == 0 {
            let hud = SwiftProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.titleText = "Please enter a mnemonic password"
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
