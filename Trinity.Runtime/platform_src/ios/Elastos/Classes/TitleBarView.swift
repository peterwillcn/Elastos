//
//  TestView.swift
//  elastOS
//
//  Created by Benjamin Piette on 16/02/2020.
//

import Foundation
import UIKit

public enum TitleBarActivityType: Int {
    /** There is an on going download. */
    case DOWNLOAD = 0
    /** There is an on going upload. */
    case UPLOAD = 1
    /** There is on going application launch. */
    case LAUNCH = 2
    /** There is another on going operation of an indeterminate type. */
    case OTHER = 3
}

public enum TitleBarForegroundMode: Int {
    case LIGHT = 0
    case DARK = 1
}

public enum TitleBarBehavior: Int {
    case DEFAULT = 0
    case DESKTOP = 1
}

public enum TitleBarNavigationMode: Int {
    case HOME = 0
    case CLOSE = 1
    case BACK = 2
    case NONE = 3
}

public class TitleBarMenuItem {
    var key: String
    var iconPath: String
    var title: String

    init(key: String, iconPath: String, title: String) {
        self.key = key
        self.iconPath = iconPath
        self.title = title
    }

    public func toJson() throws -> NSDictionary  {
        let jsonObject = NSMutableDictionary()
        jsonObject["key"] = key
        jsonObject["iconPath"] = iconPath
        jsonObject["title"] = title
        return jsonObject
    }
}

class TitleBarView: UIView {
    // Model
    var viewController: TrinityViewController?
    var appId: String?
    var isLauncher = false
    var activityCounters = Dictionary<TitleBarActivityType, Int>()
    var customBackgroundUsed = false
    var menuItems: [TitleBarMenuItem] = []
    var onMenuItemSelection : ((TitleBarMenuItem)->Void)? = nil
    var currentNavigationMode = TitleBarNavigationMode.NONE
    
    // UI
    @IBOutlet var rootView: UIView!
    
    @IBOutlet weak var btnLauncher: AdvancedButton!
    @IBOutlet weak var btnClose: AdvancedButton!
    @IBOutlet weak var btnBack: AdvancedButton!
    @IBOutlet weak var btnFav: AdvancedButton!
    @IBOutlet weak var btnMenu: AdvancedButton!
    @IBOutlet weak var btnNotifs: AdvancedButton!
    @IBOutlet weak var btnRunning: AdvancedButton!
    @IBOutlet weak var btnScan: AdvancedButton!
    @IBOutlet weak var btnSettings: AdvancedButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var progressBarBackground: UIView!
    @IBOutlet weak var progressBar: UIView!
    
    var gradientLayer: CAGradientLayer? = nil
    
    init(_ viewController: TrinityViewController, _ frame: CGRect, _ isLauncher: Bool, _ appId: String) {
        super.init(frame: frame)
        
        self.viewController = viewController;
        self.isLauncher = isLauncher;
        self.appId = appId

        let view = loadViewFromNib();
        
        addSubview(view)
        self.addMatchChildConstraints(child: view)
        
        activityCounters[.LAUNCH] = 0
        activityCounters[.DOWNLOAD] = 0
        activityCounters[.UPLOAD] = 0
        activityCounters[.OTHER] = 0

        setBackgroundColor("#7A81F1")
        setForegroundMode(.LIGHT)
        
        btnFav.isHidden = true // TODO: Waiting until the favorite management is available in system settings
        btnMenu.isHidden = true
        
        if (isLauncher) {
            btnClose.isHidden = true
            setNavigationMode(.NONE)
            setBehavior(.DESKTOP)
        }
        else {
            setNavigationMode(.HOME)
            setBehavior(.DEFAULT)
        }
    }
    
    override init(frame: CGRect) {
        self.viewController = nil
        self.appId = ""
        self.isLauncher = false
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*func setHorizontalGradientBackground(from: String, to: String) {
        if gradientLayer == nil {
            gradientLayer = CAGradientLayer()
            layer.insertSublayer(gradientLayer!, at: 0)
        }
        
        let fromColor = UIColor(hex: from)!
        let toColor = UIColor(hex: to)!
        
        gradientLayer!.colors = [fromColor.cgColor, toColor.cgColor]
        gradientLayer!.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer!.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer!.locations = [0, 1]
        gradientLayer!.frame = bounds
    }*/
    
    @IBAction func closeClicked(_ sender: Any) {
        try? AppManager.getShareInstance().close(self.viewController!.appInfo!.app_id)
    }
    
    @IBAction func launcherClicked(_ sender: Any) {
        do {
            if (!isLauncher) {
                try AppManager.getShareInstance().loadLauncher()
                try AppManager.getShareInstance().sendLauncherMessageMinimize(appId!)
            }
        }
        catch {
            print(error)
        }
    }
    
    @IBAction func backClicked(_ sender: Any) {
        // Send "navback" message to the active app
        do {
            try AppManager.getShareInstance().sendMessage(appId!, AppManager.MSG_TYPE_INTERNAL, "navback", appId!)
        }
        catch {
            print("Send message: navback error!")
        }
    }
    
    @IBAction func menuClicked(_ sender: Any) {
        let menuView = TitleBarMenuView(titleBar: self, frame: CGRect.null, appId: appId!, menuItems: menuItems)
        
        menuView.setOnMenuItemClickedListened() { menuItem in
            self.onMenuItemSelection?(menuItem)
        }
        
        menuView.show(inRootView: self.viewController!.view)
    }
    
    @IBAction func notifsClicked(_ sender: Any) {
        sendMessageToLauncher(message: "notifications-toggle")
    }
    
    @IBAction func runningClicked(_ sender: Any) {
        sendMessageToLauncher(message: "runningapps-toggle")
    }
    
    @IBAction func scanClicked(_ sender: Any) {
        sendMessageToLauncher(message: "scan-clicked")
    }
    
    @IBAction func settingsClicked(_ sender: Any) {
        sendMessageToLauncher(message: "settings-clicked")
    }
    
    private func sendMessageToLauncher(message: String) {
        do {
            try AppManager.getShareInstance().sendLauncherMessage(AppManager.MSG_TYPE_INTERNAL, message, appId!)
        }
        catch {
            print("Send message: '\(message)' error!")
        }
    }

    public func showActivityIndicator(activityType: TitleBarActivityType) {
        // Increase reference count for this progress animation type
        activityCounters[activityType] = activityCounters[activityType]! + 1
        updateAnimation(activityType: activityType)
    }

    public func hideActivityIndicator(activityType: TitleBarActivityType) {
        // Decrease reference count for this progress animation type
        activityCounters[activityType] = max(0, activityCounters[activityType]! - 1)
        updateAnimation(activityType: activityType)
    }

    public func setTitle(_ title: String?) {
        if title != nil {
            titleLabel.text = title!//.uppercased()
        }
        else {
            titleLabel.text = AppManager.getShareInstance().getAppInfo(appId!)?.name//.uppercased()
        }
    }

    public func setBackgroundColor(_ hexColor: String) -> Bool {
        if let color = UIColor.init(hex: hexColor) {
            // Remove default gradient layer if any
            if gradientLayer != nil {
                gradientLayer!.removeFromSuperlayer()
                gradientLayer = nil
            }
            
            // Set custom background color
            rootView.backgroundColor = color
            
            customBackgroundUsed = true
            
            return true
        }
        else {
            return false
        }
    }

    public func setForegroundMode(_ mode: TitleBarForegroundMode) {
        var color: UIColor

        if (mode == .DARK) {
            color = UIColor.init(hex: "#444444")!
        }
        else {
            color = UIColor.init(hex: "#FFFFFF")!
        }
        
        titleLabel.textColor = color

        btnMenu.leftImageColor = color
        btnClose.leftImageColor = color
        btnLauncher.leftImageColor = color
        btnBack.leftImageColor = color
        btnNotifs.leftImageColor = color
        btnRunning.leftImageColor = color
        btnScan.leftImageColor = color
        btnSettings.leftImageColor = color
    }
    
    public func setBehavior(_ behavior: TitleBarBehavior) {
        if behavior == .DESKTOP {
            // DESKTOP
            btnBack.isHidden = true
            btnClose.isHidden = true
            btnLauncher.isHidden = true
            btnFav.isHidden = true
            btnMenu.isHidden = true
            
            btnNotifs.isHidden = false
            btnRunning.isHidden = false
            btnScan.isHidden = false
            btnSettings.isHidden = false
        }
        else {
            // DEFAULT
            btnBack.isHidden = false
            btnClose.isHidden = false
            btnLauncher.isHidden = false
            btnFav.isHidden = true // TMP
            btnMenu.isHidden = (menuItems.count > 0 ? false : true)
            
            btnNotifs.isHidden = true
            btnRunning.isHidden = true
            btnScan.isHidden = true
            btnSettings.isHidden = true
            
            setNavigationMode(currentNavigationMode)
        }
    }
    
    public func setNavigationMode(_ navigationMode: TitleBarNavigationMode) {
        btnClose.isHidden = true
        btnBack.isHidden = true
        btnLauncher.isHidden = true

        if (navigationMode == .HOME) {
            btnLauncher.isHidden = false
        }
        else if (navigationMode == .BACK) {
            btnBack.isHidden = false
        }
        else if (navigationMode == .CLOSE) {
            btnClose.isHidden = false
        }
        else {
            // Default = NONE
        }
        
        currentNavigationMode = navigationMode
    }

    public func setupMenuItems(menuItems: [TitleBarMenuItem], onMenuItemSelection: @escaping (TitleBarMenuItem)->Void) {
        self.menuItems = menuItems
        self.onMenuItemSelection = onMenuItemSelection

        if (menuItems.count > 0) {
            btnMenu.isHidden = false
        }
        else {
            btnMenu.isHidden = true
        }
    }
    
    /** Tells if the progress bar has to be animated or not. */
    private func stillHasOnGoingProgressActivity() -> Bool {
        return
            activityCounters[.LAUNCH]! > 0 ||
            activityCounters[.DOWNLOAD]! > 0 ||
            activityCounters[.UPLOAD]! > 0 ||
            activityCounters[.OTHER]! > 0
    }
    
    private func onGoingProgressActivityCount() -> Int {
        return
            activityCounters[.LAUNCH]! +
                activityCounters[.DOWNLOAD]! +
                activityCounters[.UPLOAD]! +
                activityCounters[.OTHER]!
    }
    
    /**
     * Based on the counters for each activity, determines which activity type has the priority and plays the appropriate animation.
     * If no more animation, the animation is stopped
     */
    private func updateAnimation(activityType: TitleBarActivityType) {
        // Check if an animation should be launched, and which one
        var backgroundColor: String? = nil
        if (activityCounters[.LAUNCH] ?? 0) > 0 {
            backgroundColor = "#FFFFFF"
        }
        else if (activityCounters[.DOWNLOAD] ?? 0) > 0
            || (activityCounters[.UPLOAD] ?? 0) > 0 {
            backgroundColor = "#ffde6e"
        }
        else if (activityCounters[.OTHER] ?? 0) > 0 {
            backgroundColor = "#20e3d2"
        }

        if (backgroundColor != nil) {
            progressBar.isHidden = false
            progressBar.backgroundColor = UIColor.init(hex: backgroundColor!)

            // Only start a new animation if we are the first animation to start.
            if onGoingProgressActivityCount() == 1 {
                animateProgressBarIn()
            }
        }
        else {
            progressBar.isHidden = true
        }
    }

    private func animateProgressBarIn() {
        let onGoingProgressAnimation = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut, animations: {
            self.progressBar.alpha = 1.0
        })
        onGoingProgressAnimation.addCompletion { _ in
            if self.stillHasOnGoingProgressActivity() {
                self.animateProgressBarOut()
            }
        }
        onGoingProgressAnimation.startAnimation()
    }

    private func animateProgressBarOut() {
        let onGoingProgressAnimation = UIViewPropertyAnimator(duration: 1.0, curve: .easeOut, animations: {
            self.progressBar.alpha = 0.0
        })
        
        onGoingProgressAnimation.addCompletion { _ in
            if self.stillHasOnGoingProgressActivity() {
                self.animateProgressBarIn()
            }
        }
        onGoingProgressAnimation.startAnimation()
    }
}
