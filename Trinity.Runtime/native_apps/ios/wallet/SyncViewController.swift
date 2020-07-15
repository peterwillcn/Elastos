
import UIKit

class SyncViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }

    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.view.removeFromSuperview()
    }
}
