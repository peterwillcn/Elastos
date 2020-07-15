
import UIKit

class DetailsCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func renderCell(_ model: DetailsModel) {
        do {
            var img = Bundle.main.path(forResource: "www/built-in/org.elastos.trinity.dapp.wallet/assets/images/exchange-sub", ofType: "png")
            statusLabel.text = model.direction
            let time = timeIntervalChangeToTimeStr(timeInterval: try TimeInterval.init(value: model.timestamp))
            timeLabel.text = time
            countLabel.text = "- \(changeEla(model.amount))  "
            if model.direction == "Received" {
                countLabel.text = "+ \(changeEla(model.amount))  "
                img = Bundle.main.path(forResource: "www/built-in/org.elastos.trinity.dapp.wallet/assets/images/exchange-add", ofType: "png")
            }
            icon.image = UIImage(contentsOfFile: img!)

        } catch {
            print("timeIntervalChangeToTimeStr error.")
        }
    }
    
}
