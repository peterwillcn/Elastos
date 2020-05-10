

import Foundation

let screenw = UIScreen.main.bounds.size.width
class ShowmMnomicViewController: UIViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var mnomicLabel: UILabel!
    @IBOutlet weak var writtenDownBtn: UIButton!
    let wallet: SPVWallet = SPVWallet.shared()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Mnemonic"
        commonInit()
    }

    func commonInit() {
        let leftBtn = UIButton(frame: CGRect(x: 0,y: 0,width: 0,height: 0))
        leftBtn.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        leftBtn.widthAnchor.constraint(equalToConstant: 18.0).isActive = true
        leftBtn.heightAnchor.constraint(equalToConstant: 18.0).isActive = true
        leftBtn.setImage(UIImage(named: "ic_close"), for: .normal)
        let leftBtnItem = UIBarButtonItem(customView: leftBtn)
        self.navigationItem.leftBarButtonItem = leftBtnItem
        addDashdeBorderLayer(byView: bgView, color: UIColor.white, lineWidth: 1)
        mnomicLabel.text = mnemonic
    }

    func addDashdeBorderLayer(byView view:UIView, color:UIColor,lineWidth width:CGFloat) {
        let shapeLayer = CAShapeLayer()
        view.layoutIfNeeded()
        let size = view.frame.size
        
        let shapeRect = CGRect(x: 10, y: 10, width: (screenw - 24 - 20), height: size.height - 20)
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: (screenw - 24) / 2, y: size.height / 2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round

        shapeLayer.lineDashPattern = [3,4]
        let path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5)
        shapeLayer.path = path.cgPath
        view.layer.addSublayer(shapeLayer)
    }

    @IBAction func writtenDownAction(_ sender: UIButton) {
        let phrasePassword = ""
        do {
            _ = try wallet.createMasterWallet(withMasterWalletID: masterWalletID, mnemonic: mnemonic, phrasePassword: phrasePassword, payPassword: payPassword, singleAddress: false)
            _ = try wallet.createSubWallet(masterWalletID, chainID: chainID)

            NotificationCenter.default.post(name: syncStart, object: self, userInfo: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.dismiss(animated: true, completion: nil)
            }
        } catch {
            print("error: createMasterWallet with masterWalletID: \(masterWalletID) error.")
        }
    }

    @objc func closeAction() {
        self.dismiss(animated: true, completion: nil)
    }
}
