/*
 * Copyright (c) 2020 Elastos Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import UIKit

class WalletMainViewController: NativeAppMainViewController, ElISubWalletDelegate {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var walletNameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var clickButton: UIButton!
    @IBOutlet weak var settingLabel: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var createWalletButton: UIButton!
    @IBOutlet weak var elaIcon: UIImageView!
    @IBOutlet weak var rowIcon: UIImageView!
    var isHasWallet = true
    let wallet: SPVWallet = SPVWallet.shared()
    let userDefault = UserDefaults.standard
    var navi: UINavigationController?
    var balance: String = ""
    @IBOutlet weak var coinListLabel: UILabel!
    @IBOutlet weak var listBgView: UIView!
    @IBOutlet weak var noticeBgView: UIView!
    var showHint: Bool = false
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(walletSyncStart), name: syncStart, object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(showCreateWallet), name: createWallet, object: nil)
        commonInit()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        wallet.setInfo(self.appInfo)
        let list: [String] = wallet.getAllMasterWallets()
        if list.count <= 0 {
            isHasWallet = false
            refreshUI()
            return
        }
        refreshUI()
        syncStartWalletInfo(list)
    }

    func refreshUI() {
        createWalletButton.isHidden = isHasWallet
        noticeBgView.isHidden = isHasWallet
        bgView.isHidden = !isHasWallet
        coinListLabel.isHidden = !isHasWallet
        listBgView.isHidden = !isHasWallet
        homeButton.isHidden = !isHasWallet
        settingButton.isHidden = !isHasWallet
    }

    func commonInit() {
        setCAGradientLayer(bgView)
        walletNameLabel.text = masterWalletName
        settingLabel.text = "Wallet Setting"
        setBorder(settingLabel, UIColor.white, 0.5, 10)
        var icon = Bundle.main.path(forResource: "www/built-in/org.elastos.trinity.dapp.wallet/assets/images/ela-coin", ofType: "png")
        elaIcon.image = UIImage(contentsOfFile: icon!)
        icon = Bundle.main.path(forResource: "www/built-in/org.elastos.trinity.dapp.wallet/assets/images/right", ofType: "png")
        rowIcon.image = UIImage(contentsOfFile: icon!)
        settingButton.widthAnchor.constraint(equalToConstant: 19.0).isActive = true
        settingButton.heightAnchor.constraint(equalToConstant: 19.0).isActive = true
    }

    func syncStartWalletInfo(_ masterIdList: [String]) {
        do {
            for masterId in masterIdList {
                masterWalletID = masterId
                let stringValue = userDefault.string(forKey: masterWalletID)
                if stringValue != nil && stringValue != "" {
                    masterWalletName = stringValue!
                }
                walletNameLabel.text = masterWalletName
                let info = try wallet.getMasterWalletBasicInfo(masterId)
                print(info)
                let coins: [String] = try wallet.getAllSubWallets(withMasterWalletID: masterId)
                for coin in coins {
                    wallet.registerListener(masterId, chainID: coin, delegate: self)
                    balance = try wallet.getBalance(masterWalletID, chainID: coin)
                    count.text = changeEla(balance)
                    countLabel.text = changeEla(balance)
                    try wallet.syncStartMasterWalletID(masterId, chainID: coin)
                }
                print(info)
            }
        } catch {
            print(error)
        }
    }

    @objc func showCreateWallet() {
        isHasWallet = false
        refreshUI()
    }

    @IBAction func createWalletAction(_ sender: UIButton) {
        let createVC = CreateWalletViewController()
        navi = UINavigationController.init(rootViewController: createVC)
        self.view.addSubview(navi!.view)
        navi!.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
    }

    @objc func walletSyncStart(nofi : Notification){
        isHasWallet = true
        refreshUI()
        userDefault.set(masterWalletName, forKey: masterWalletID)
        syncStartWalletInfo([masterWalletID])
    }

    override func setReady() {
        super.setReady();
    }

    override func onReceiveMessage(_ type: Int, _ msg: String, _ fromId: String) {        let params = getParams(msg);

        switch (type) {
        case AppManager.MSG_TYPE_IN_REFRESH:
            switch (params?["action"] as! String) {
            case "currentLocaleChanged":
                //                        setCurLang(params["data"]);
                break;
            default:
                break;
            }
            break;
        default:
            break;
        }
    }

    override func onReceiveIntent(_ action: String, _ params: String?, _ fromId: String, _ intentId: Int64) {
        showHint = true
        let syncVC = SyncViewController()
        navi = UINavigationController.init(rootViewController: syncVC)
        self.view.addSubview(navi!.view)

        navi!.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        /*
        let params = getParams(params);
        switch (action) {
        case "pay":
            try? self.basePlugin!.sendIntentResponse("Sorry, this feature is not yet available in this early version of the iOS wallet. This is going to be solved soon.", intentId);
        default:
            break;
        }
         */
    }

    func setCAGradientLayer(_ view: UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.colors = [UIColor(hex: "#7450fc")!.cgColor,
                                UIColor(hex: "#ab4ed8")!.cgColor,
                                UIColor(hex: "#b1429d")!.cgColor]
        let gradientLocations:[NSNumber] = [0.0,0.8,1.0]
        gradientLayer.locations = gradientLocations
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 1)
    }

    func setBorder(_ lable: UILabel, _ color: UIColor, _ width: CGFloat, _ cornerRadius: CGFloat) {
        lable.layer.cornerRadius = cornerRadius
        var frame = lable.frame
        frame.size.width += 10
        frame.size.height = 20
        lable.frame = frame
        lable.layer.borderColor = color.cgColor
        lable.layer.borderWidth = width
        lable.layer.masksToBounds = true
    }

    @IBAction func detailAction(_ sender: UIButton) {
        let detailVC = DetailsViewController()
        detailVC.balance = balance
        navi = UINavigationController.init(rootViewController: detailVC)
        detailVC.navigationController?.navigationBar.barTintColor = UIColor.black
        let navigationDic = [NSAttributedString.Key.foregroundColor : UIColor.white]
        detailVC.navigationController?.navigationBar.titleTextAttributes = navigationDic
        self.view.addSubview(navi!.view)
    }

    @IBAction func homeAction(_ sender: UIButton) {
    }

    @IBAction func settingAction(_ sender: UIButton) {
        let setVC = WalletSettingViewController()
        navi = UINavigationController.init(rootViewController: setVC)
        setVC.navigationController?.navigationBar.barTintColor = UIColor.black
        let navigationDic = [NSAttributedString.Key.foregroundColor : UIColor.white]
        setVC.navigationController?.navigationBar.titleTextAttributes = navigationDic
        self.view.addSubview(navi!.view)

        navi!.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
    }

    @IBAction func close(_ sender: Any) {
        try? self.basePlugin!.close();
    }

    func onBlockSyncProgress(withProgressInfo info: [AnyHashable : Any]!) {
        let info = JSON(info as Any)
        let lastBlockTime = info["LastBlockTime"].intValue
        let time = timeIntervalChangeToTimeStr(timeInterval: TimeInterval.init(lastBlockTime))
        let progress = info["Progress"].stringValue
        DispatchQueue.main.async {
            lastBlockTimeAndProgress = "\(time)  \(progress)%"
            self.dateLabel.text = lastBlockTimeAndProgress
            NotificationCenter.default.post(name: refreshTransaction, object: self, userInfo: nil)
        }
    }

    func onTransactionStatusChangedTxId(_ txIdStr: String!, status statusStr: String!, desc descStr: String!, confirm confirmNum: NSNumber!) {
        if statusStr == "Added" {
            DispatchQueue.main.async {
                let hud = SwiftProgressHUD.showHUDAddedTo(self.view, animated: true)
                hud.titleText = "sent"
                hud.mode = .text
                hud.afterDelay = 2
            }
        }
    }

    func onBalanceChangedAsset(_ assetString: String!, balance balanceString: String!) {
        DispatchQueue.main.async {
            self.countLabel.text = changeEla(balanceString)
            self.count.text = changeEla(balanceString)
        }
    }

    func onTxPublishedHash(_ hashString: String!, result resultString: Dictionary<AnyHashable, Any>!) {
        DispatchQueue.main.async {
            let result = JSON(resultString as Any)
            let code = result["Code"].intValue
            let reason = result["Reason"].stringValue
            if code != 0 {
                let hud = SwiftProgressHUD.showHUDAddedTo(self.view, animated: true)
                hud.titleText = "transaction-fail \(String(describing: hashString)) \(reason)"
                hud.mode = .text
                hud.afterDelay = 2
                return
            }
            let hud = SwiftProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.titleText = reason
            hud.mode = .text
            hud.afterDelay = 2
        }
    }

    func onAssetRegisteredAsset(_ assetString: String!, info infoString: String!) {
    }

    func onConnectStatusChangedStatus(_ statusString: String!) {
    }
}


