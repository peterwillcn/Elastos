
import UIKit

class ReceiveViewController: UIViewController {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var copyButton: UIButton!
    let wallet: SPVWallet = SPVWallet.shared()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Receive"
        addressLabel.text = ""
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        do {
            addressLabel.text = try wallet.createAddress(masterWalletID, chainID: chainID)
        } catch {
            print("error: createAddress")
        }
    }

    @IBAction func copyAction(_ sender: Any) {
        UIPasteboard.general.string = addressLabel.text
        let hud = SwiftProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.titleText = "Copy successful"
        hud.mode = .text
        hud.afterDelay = 2
    }

    @objc func closeAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
