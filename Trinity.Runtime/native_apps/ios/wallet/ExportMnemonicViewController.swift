
import UIKit

class ExportMnemonicViewController: UIViewController {

    @IBOutlet weak var iconImagview: UIImageView!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var showMnemonicView: UIView!
    @IBOutlet weak var memonicLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var passWordLabel: UILabel!
    let wallet: SPVWallet = SPVWallet.shared()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Export mnemonics"
        showMnemonicView.isHidden = true
        let icon = Bundle.main.path(forResource: "www/built-in/org.elastos.trinity.dapp.wallet/assets/images/logo", ofType: "ico")
        iconImagview.image = UIImage(contentsOfFile: icon!)
        passWordLabel.isHidden = false
        passwordTextField.isHidden = false
        showMnemonicView.isHidden = true
        noticeLabel.isHidden = true
        self.hideKeyboardWhenTappedAround()
    }

    func addDashdeBorderLayleter(byView view:UIView, color:UIColor,lineWidth width:CGFloat) {
        let shapeLayer = CAShapeLayer()
        view.layoutIfNeeded()
        let size = view.frame.size

        let shapeRect = CGRect(x: 10, y: 10, width: (screenw - 24 - 20), height: size.height - 20)
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: (screenw - 24) / 2, y: size.height / 2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round

        shapeLayer.lineDashPattern = [3,4]
        let path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5)
        shapeLayer.path = path.cgPath
        view.layer.addSublayer(shapeLayer)
    }

    @IBAction func confirmAction(_ sender: UIButton) {
        do {
            if showMnemonicView.isHidden == false {
                self.navigationController?.view.removeFromSuperview()
                return
            }
            if passwordTextField.text == nil || passwordTextField.text!.count < 8 {
                let hud = SwiftProgressHUD.showHUDAddedTo(self.view, animated: true)
                hud.titleText = "Password format is incorrect."
                hud.mode = .text
                hud.afterDelay = 2
                return
            }
            let password = passwordTextField.text
            let mno = try wallet.exportMnemonicWithmasterWalletID(masterWalletID, backupPassword: password)
            showMnemonicView.isHidden = false
            passWordLabel.isHidden = true
            passwordTextField.isHidden = true
            memonicLabel.text = mno
            noticeLabel.isHidden = false
            noticeLabel.text = "Please write down your mnemonics on the paper. If you lose your mnemonics, you will lose your wallet forever"
            confirmButton.setTitle("I have wrritten it down", for: .normal)
        } catch {
            print(error)
        }
    }

    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
