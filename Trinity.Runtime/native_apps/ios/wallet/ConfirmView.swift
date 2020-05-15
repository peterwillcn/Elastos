
import UIKit

class ConfirmView: UIView {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        let view = Bundle.main.loadNibNamed("ConfirmView", owner: self, options: nil)![0] as! UIView
        view.frame = self.frame
        view.bounds = self.bounds
        self.addSubview(view)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
    }
}
