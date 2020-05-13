
import UIKit

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var mainTableView: UITableView!
    let cellID = "DetailsCell"
    @IBOutlet weak var receiveButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    let wallet: SPVWallet = SPVWallet.shared()
    var balance = "0"
    var dataSource:[DetailsModel] = []
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        commonInit()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTransactionAction), name: refreshTransaction, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh([masterWalletID])
    }

    func commonInit() {
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 44, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 110 - 44 - 64), style: .grouped)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.backgroundColor = UIColor.clear
        mainTableView.estimatedRowHeight = 44
        mainTableView .register(UINib.init(nibName: "DetailsCell", bundle: nil), forCellReuseIdentifier: cellID)
        self.view .addSubview(mainTableView)
    }

    @objc func refreshTransactionAction(nofi : Notification){
        refresh([masterWalletID])
    }

    func refresh(_ masterIdList: [String]) {
        do {
            balance = try wallet.getBalance(masterWalletID, chainID: chainID)
           let allJson = JSON(try wallet.getAllTransaction(masterWalletID, chainID: chainID, start: "0", count: "200", addressOrTxId: ""))
            let allHistory = allJson["Transactions"].arrayValue
            dataSource.removeAll()
            allHistory.forEach { obj in
                let mode = DetailsModel()
                mode.amount = obj["Amount"].stringValue
                mode.direction = obj["Direction"].stringValue
                mode.height = obj["Height"].stringValue
                mode.status = obj["Status"].stringValue
                mode.timestamp = obj["Timestamp"].stringValue
                mode.confirmStatus = obj["ConfirmStatus"].stringValue
                mode.txHash = obj["TxHash"].stringValue
                mode.type = obj["Type"].stringValue
                dataSource.append(mode)
            }
            MaxCount = allJson["MaxCount"].intValue
            mainTableView.reloadData()
        } catch {
            print(error)
        }
    }

    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.view.removeFromSuperview()
    }
    
    @IBAction func sendAction(_ sender: UIButton) {
        let sendVC = SendViewController()
        sendVC.balance = balance
        self.navigationController?.pushViewController(sendVC, animated: true)
    }

    @IBAction func receiveAction(_ sender: UIButton) {
        self.navigationController?.pushViewController(ReceiveViewController(), animated: true)
    }

    // MARK:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DetailsCell = tableView.dequeueReusableCell(withIdentifier: cellID) as! DetailsCell
        cell.renderCell(dataSource[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HeaderView()
        view.countLable.text = changeEla(balance)
        view.timeLabel.text = lastBlockTimeAndProgress
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 140
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let infoVC = InfoViewController()
        infoVC.model = dataSource[indexPath.row]
        self.navigationController?.pushViewController(infoVC, animated: true)
    }
}
