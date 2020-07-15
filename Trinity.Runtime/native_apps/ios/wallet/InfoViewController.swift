
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
    let wallet: SPVWallet = SPVWallet.shared()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()
    }

    func refreshData() {
        do {
            let info = JSON(try wallet.getAllTransaction(masterWalletID, chainID: chainID, start: "0", count: "200", addressOrTxId: model?.txHash))
            let detials = JSON(info["Transactions"][0])
            model?.status = detials["Status"].stringValue
            model?.timestamp = detials["Timestamp"].stringValue
            model?.fee = detials["Fee"].stringValue
            model?.memo = detials["Memo"].stringValue
            render(model!)
        } catch {
            print(error)
        }
    }

    func render(_ model: DetailsModel) {
        do {
            tx_amountLabel.text = "- \(changeEla(model.amount)) ELA"
            if model.direction == "Received" {
                tx_amountLabel.text = "+ \(changeEla(model.amount)) ELA"
            }
            confirmTimeLabel.text = timeIntervalChangeToTimeStr(timeInterval: try TimeInterval.init(value: model.timestamp))
            tx_idLabel.text = model.txHash
            confirmCountLabel.text = model.confirmStatus
            memoLabel.text = model.memo
            transactionFeeLabel.text = changeEla(model.fee)
            stateLabel.text = model.status
        } catch {
            print("timeIntervalChangeToTimeStr error.")
        }
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

