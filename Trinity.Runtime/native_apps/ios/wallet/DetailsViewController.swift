
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
        self.title = "Wallet"
        commonInit()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTransactionAction), name: refreshTransaction, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh([masterWalletID])
    }

    func commonInit() {
        let leftBtn = UIButton(frame: CGRect(x: 0,y: 0,width: 0,height: 0))
        leftBtn.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        leftBtn.widthAnchor.constraint(equalToConstant: 18.0).isActive = true
        leftBtn.heightAnchor.constraint(equalToConstant: 18.0).isActive = true
        leftBtn.setImage(UIImage(named: "ic_close"), for: .normal)
        let leftBtnItem = UIBarButtonItem(customView: leftBtn)
        self.navigationItem.leftBarButtonItem = leftBtnItem

        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 140), style: .grouped)
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
           let all = try wallet.getAllTransaction(masterWalletID, chainID: chainID, start: "0", count: "200", addressOrTxId: "")
            let allHistory = all["Transactions"]  as! Array<Dictionary<String, Any>>
            dataSource.removeAll()
            allHistory.forEach { obj in
                let mode = DetailsModel()
                mode.amount = obj["Amount"] as! String
                mode.direction = obj["Direction"] as! String
                mode.height = "\(obj["Height"] as! Int)"
                mode.status = obj["Status"] as! String
                mode.timestamp = "\(obj["Timestamp"] as! Int)"
                mode.confirmStatus = "\(obj["ConfirmStatus"] as! Int)"
                mode.txHash = obj["TxHash"] as! String
                mode.type = "\(obj["Type"] as! Int)"
                dataSource.append(mode)
            }
            MaxCount = all["MaxCount"] as! Int
            mainTableView.reloadData()
        } catch {
            print(error)
        }
    }
    
    @IBAction func sendAction(_ sender: UIButton) {
        let sendVC = SendViewController()
        sendVC.balance = balance
        self.navigationController?.pushViewController(sendVC, animated: true)
    }

    @IBAction func receiveAction(_ sender: UIButton) {
        self.navigationController?.pushViewController(ReceiveViewController(), animated: true)
    }

    @objc func closeAction() {
    //     try? self.basePlugin!.close();
        self.dismiss(animated: true, completion: nil)
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
        view.countLable.text = balance
        view.timeLabel.text = lastBlockTimeAndProgress
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 160
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let infoVC = InfoViewController()
        infoVC.model = dataSource[indexPath.row]
        self.navigationController?.pushViewController(infoVC, animated: true)
    }
}
