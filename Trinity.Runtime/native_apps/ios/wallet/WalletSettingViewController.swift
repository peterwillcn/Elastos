
import UIKit

class WalletSettingViewController: UIViewController {
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var rowIcon: UIImageView!
    @IBOutlet weak var clickButton: UIButton!
    let wallet: SPVWallet = SPVWallet.shared()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        commonInit()
    }

    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.view.removeFromSuperview()
    }

    func commonInit() {
        let icon = Bundle.main.path(forResource: "www/built-in/org.elastos.trinity.dapp.wallet/assets/images/right", ofType: "png")
        rowIcon.image = UIImage(contentsOfFile: icon!)
    }

    @IBAction func deleteAction(_ sender: UIButton) {
        let alertController = UIAlertController(title: "confirm",
                                                message: "Are you sure you want log out this wallet?",
                                                preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancle", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "Confirm", style: .default, handler: { action in
            do {
                _ = try self.wallet.destroy(masterWalletID)
                NotificationCenter.default.post(name: createWallet, object: self, userInfo: nil)
                self.navigationController?.view.removeFromSuperview()
            }catch {
                print(error)
            }
        })

        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

    @IBAction func clickAction(_ sender: UIButton) {
        self.navigationController?.pushViewController(ExportMnemonicViewController(), animated: true)
    }
}

