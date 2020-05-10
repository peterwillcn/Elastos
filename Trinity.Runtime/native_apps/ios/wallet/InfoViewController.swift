
import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var tx_amountLabel: UILabel!
    @IBOutlet weak var tx_idLabel: UILabel!
    @IBOutlet weak var confirmTimeLabel: UILabel!
    @IBOutlet weak var transactionFeeLabel: UILabel!
    @IBOutlet weak var confirmCountLabel: UILabel!
    @IBOutlet weak var memoLabel: UILabel!
    var model: DetailsModel?
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        render(model!)
    }

    func render(_ model: DetailsModel) {
        do {
            tx_amountLabel.text = "- \(model.amount) ELA"
            if model.direction == "Received" {
                tx_amountLabel.text = "+ \(model.amount) ELA"
            }
            confirmTimeLabel.text = timeIntervalChangeToTimeStr(timeInterval: try TimeInterval.init(value: model.timestamp))
            tx_idLabel.text = model.txHash
            confirmCountLabel.text = model.confirmStatus
            memoLabel.text = ""

        } catch {
            print("timeIntervalChangeToTimeStr error.")
        }
    }
}

