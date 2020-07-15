import Foundation

class CustomView: UIView {

    @IBOutlet weak var showNameLabel: UILabel!
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rowImageView: UIImageView!
    @IBOutlet weak var clickButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
