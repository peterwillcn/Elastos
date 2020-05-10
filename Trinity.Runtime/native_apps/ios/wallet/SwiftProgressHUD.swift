
import UIKit

enum SwiftProgressHUDModel {
    case text
    case customView
    case animationImage
    case circular
    case rectangle
    case chrysanthemum
}

class SwiftProgressHUD: UIView {
    
    var cycyleTimer : Timer?
    open var currentView:UIView!
    open var hudMaskView:UIView!
    open var hudView:UIView!
    open var blurView:UIVisualEffectView!
    open var circularView:ProgressView!
    open var rectView:ProgressRectView!
    open var animationImageView:UIImageView!
    open var animationImageViewArr:[UIImage]!
    open var animationImageViewindex:Int = 0
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
    fileprivate var defaultHudSize:CGSize = CGSize(width: 150, height: 100)
    fileprivate var hudAnimated:Bool = false

    open var currentHudSize:CGSize = CGSize.zero {
        didSet{
            defaultHudSize = currentHudSize
            hudView.frame = CGRect(x: 0, y: 0, width: defaultHudSize.width, height: defaultHudSize.height)
            blurView.frame = CGRect(x: 0, y: 0, width:defaultHudSize.width, height: defaultHudSize.height)
            hudView.center = CGPoint(x:currentView.frame.size.width/2 , y: currentView.frame.size.height/2)
        }
    }

    open var afterDelay:CGFloat = 0.0 {
        didSet{
            hideView(afterDelay: afterDelay)
        }
    }

    open var titleText:String = "" {
        didSet{
            if(self.mode == .text) {
                setupHudTitle(title: titleText)
            }else if ( self.mode == .chrysanthemum) {
                setupChrysanthemum(title: titleText)
            }
        }
    }

    open var progress:CGFloat = 0.0 {
        didSet{
            
            if(self.mode == .circular) {
                if(progress < 1){
                    self.circularView.progress = progress
                }else{
                    hideView(afterDelay: 0)
                }
            }else if (self.mode == .rectangle) {
                if(progress < 1){
                    self.rectView.progress = progress
                }else{
                    hideView(afterDelay: 0)
                }
            }
        }
    }

    open var mode:SwiftProgressHUDModel = .text {
        didSet{
            if mode == .circular {
                self.setupcircularView()
            } else if mode == .rectangle {
                self.setupRectView()
            }
        }
    }

    open var hudColor:UIColor! {
        didSet{
            hudView.backgroundColor = hudColor
        }
    }

    open var maskColor:UIColor! {
        didSet{
            hudMaskView.backgroundColor = maskColor
        }
    }

    open var animationImage = [UIImage]() {
        didSet{
            if mode == .animationImage {
                setupAnimationImage(imgArr:animationImage)
            }
        }
    }

    open var customView:UIView! {
        didSet{
            if mode == .customView {
                self.currentHudSize = CGSize(width: customView.frame.size.width, height: customView.frame.size.height)
                setupHudCustomView(view: customView)
            }
        }
    }

    class func showHUDAddedTo(_ view: UIView, animated: Bool)->Self {
        let hud = self.init()
        hud.hudAnimated = animated
        hud.currentView = view
        hud.setupMaskView()
        hud.setupHudView()
        return hud
    }
    
}

extension SwiftProgressHUD {

    func setupMaskView() {
        hudMaskView = UIView()
        currentView.addSubview(hudMaskView)
        hudMaskView.frame = CGRect(x: 0, y: 0, width: currentView.frame.size.width, height: currentView.frame.size.height)
        hudMaskView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
    }

    func setupHudView() {
        hudView = UIView()
        hudMaskView.addSubview(hudView)
        hudView.frame = CGRect(x: 0, y: 0, width: defaultHudSize.width, height: defaultHudSize.height)
        hudView.center = hudMaskView.center
        hudView.layer.cornerRadius = 8
        hudView.layer.masksToBounds = true
        hudView.backgroundColor = UIColor.black

        let blurEffect: UIBlurEffect = UIBlurEffect(style: .light)
        blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = CGRect(x: 0, y: 0, width: defaultHudSize.width, height: defaultHudSize.height)
        hudView.addSubview(blurView)
        
        if hudAnimated {
            hudView.alpha = 0.1
            UIView.animate(withDuration: 0.5, animations: {
                self.hudView.alpha = 1
                
            })
        }
    }

    func setupHudTitle(title: String) {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.text = title
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(rawValue: 0.8))
        
        hudView.addSubview(titleLabel)
        if currentHudSize.width > 0 {
            titleLabel.frame = CGRect(x: 0, y: 0, width: currentHudSize.width - 20 , height: currentHudSize.height - 20)
        }else {
            let limitSize = CGSize(width: currentView.frame.size.width - 20, height: 100)
            let currentSize = self.getTextRectSize(text: title as NSString, font: UIFont.systemFont(ofSize: 15, weight:  UIFont.Weight(rawValue: 0.8)), size: limitSize)
            self.currentHudSize = CGSize(width: currentSize.size.width + 20 , height: currentSize.size.height + 20 )
           titleLabel.frame = CGRect(x: 0, y: 0, width: currentSize.width , height: currentSize.height)
        }
        titleLabel.center =  CGPoint(x:hudView.frame.size.width/2 , y: hudView.frame.size.height/2)
    }

    func setupChrysanthemum(title: String) {
    
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.text = title
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(rawValue: 0.8))
        hudView.addSubview(titleLabel)

        if currentHudSize.width > 0 {
            titleLabel.frame = CGRect(x: 0, y: 0, width: currentHudSize.width - 20 , height: currentHudSize.height - 20)
            titleLabel.center =  CGPoint(x:hudView.frame.size.width/2 , y: hudView.frame.size.height/2 + 25)
            hudView.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            activityIndicator.center = CGPoint(x:hudView.frame.size.width/2 , y: hudView.frame.size.height/2 - 15)
        }else {

            let limitSize = CGSize(width: currentView.frame.size.width - 20, height: 150)
            let currentSize = self.getTextRectSize(text: title as NSString, font: UIFont.systemFont(ofSize: 15, weight:  UIFont.Weight(rawValue: 0.8)), size: limitSize)
            self.currentHudSize = CGSize(width: currentSize.size.width + 20 , height: currentSize.size.height + 60 )
            titleLabel.frame = CGRect(x: 0, y: 0, width: currentSize.width , height: currentSize.height)
            titleLabel.center =  CGPoint(x:hudView.frame.size.width/2 , y: hudView.frame.size.height/2 + 20)
            
            hudView.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            activityIndicator.center = CGPoint(x:hudView.frame.size.width/2 , y: hudView.frame.size.height/2 - 10)
        }
        
        

    }

    func setupHudCustomView(view: UIView) {
        view.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height:  view.frame.size.height)
        hudView.addSubview(view)
        view.center = CGPoint(x:hudView.frame.size.width/2 , y: hudView.frame.size.height/2)
    }

    func setupAnimationImage(imgArr: [UIImage]) {
        blurView.isHidden = true
        animationImageViewArr = imgArr
        animationImageView = UIImageView(image: imgArr[0])
        animationImageView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        currentHudSize =  CGSize(width: 100, height: 100)
        self.addCycleTimer()
        //imageView.highlightedAnimationImages = imgArr
        //imageView.animationImages = imgArr
        //imageView.animationDuration = 0.5
        //imageView.animationRepeatCount = LONG_MAX
        //imageView.startAnimating()
        self.setupHudCustomView(view: animationImageView)
    }

    func setupcircularView() {
        circularView = ProgressView()
        circularView.progress = 0.0
        circularView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        circularView.backgroundColor = UIColor.white
        self.setupHudCustomView(view: circularView)
    }

    func setupRectView() {
        rectView = ProgressRectView()
        rectView.progress = 0.0
        rectView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        rectView.backgroundColor = UIColor.white
        self.setupHudCustomView(view: rectView)
    }
    
}

extension SwiftProgressHUD {
    func hideView(afterDelay: CGFloat) {
        let after =  TimeInterval(afterDelay)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(after * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
            self.removeCycleTimer()
            self.hudMaskView.removeFromSuperview()
        })
    }
}

extension SwiftProgressHUD {

    func getTextRectSize(text: NSString,font: UIFont,size: CGSize) -> CGRect {
        let attributes = [NSAttributedString.Key.font: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = text.boundingRect(with: size, options: option, attributes: attributes, context: nil)
        return rect;
    }

    fileprivate func addCycleTimer() {
        cycyleTimer = Timer(timeInterval: 0.3, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycyleTimer!, forMode:RunLoop.Mode.common)
    }

    fileprivate func removeCycleTimer() {
        cycyleTimer?.invalidate()
        cycyleTimer = nil
    }

    @objc fileprivate func scrollToNext() {
        let count = animationImageViewArr.count
        
        if animationImageViewindex == count - 1 {
            animationImageViewindex = 0
        }else{
            animationImageViewindex =  animationImageViewindex + 1
        }
        animationImageView.image = animationImageViewArr[animationImageViewindex]
    }
}


class ProgressRectView: UIView {
    var progress : CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: rect.height/2, width: rect.width * progress, height: 5), cornerRadius: 2.5)
        //path.addLine(to: center)
        //path.close()
        UIColor(white: 0.5, alpha: 0.8).setFill()
        path.fill()
    }
    
}


class ProgressView: UIView {
    var progress : CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let center = CGPoint(x: rect.width * 0.5, y: rect.height * 0.5)
        let radius = rect.width * 0.5 - 3
        let startAngle = CGFloat(-M_PI_2)
        let endAngle = CGFloat(2 * M_PI) * progress + startAngle

        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.addLine(to: center)
        path.close()
        UIColor(white: 0.5, alpha: 0.8).setFill()
        path.fill()
    }
    
}

