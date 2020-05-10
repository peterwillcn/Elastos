
import UIKit

class HeaderView: UIView {

    @IBOutlet weak var countLable: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let view = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)![0] as! UIView
        view.frame = self.frame
        view.bounds = self.bounds
        self.addSubview(view)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
