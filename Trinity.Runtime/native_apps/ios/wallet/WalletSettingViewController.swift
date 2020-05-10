
import UIKit

class WalletSettingViewController: UIViewController {
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var rowIcon: UIImageView!
    @IBOutlet weak var clickButton: UIButton!
    let wallet: SPVWallet = SPVWallet.shared()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Wallet Setting"
        commonInit()
    }

    func commonInit() {
        let leftBtn = UIButton(frame: CGRect(x: 0,y: 0,width: 0,height: 0))
        leftBtn.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        leftBtn.widthAnchor.constraint(equalToConstant: 18.0).isActive = true
        leftBtn.heightAnchor.constraint(equalToConstant: 18.0).isActive = true
        leftBtn.setImage(UIImage(named: "ic_close"), for: .normal)
        let leftBtnItem = UIBarButtonItem(customView: leftBtn)
        self.navigationItem.leftBarButtonItem = leftBtnItem
        let icon = Bundle.main.path(forResource: "www/built-in/org.elastos.trinity.dapp.wallet/assets/images/right", ofType: "png")
        rowIcon.image = UIImage(contentsOfFile: icon!)
    }

    @objc func closeAction() {
        self.dismiss(animated: false, completion: nil)
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    self.dismiss(animated: true, completion: nil)
                }
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

