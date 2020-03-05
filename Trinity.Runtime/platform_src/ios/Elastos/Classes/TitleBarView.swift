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
/*
    private int mValue;

    TitleBarActivityType(int value) {
        mValue = value;
    }

    public static TitleBarActivityType fromId(int value) {
        for(TitleBarActivityType t : values()) {
            if (t.mValue == value) {
                return t;
            }
        }
        return OTHER;
    }*/
}

public enum TitleBarForegroundMode: Int {
    case LIGHT = 0
    case DARK = 1

    /*private int mValue;

    TitleBarForegroundMode(int value) {
        mValue = value;
    }

    public static TitleBarForegroundMode fromId(int value) {
        for(TitleBarForegroundMode t : values()) {
            if (t.mValue == value) {
                return t;
            }
        }
        return LIGHT;
    }*/
}

class TitleBarView: UIView {
    // Model
    var viewController: TrinityViewController?
    var appId: String?
    var isLauncher = false
    var activityCounters = Dictionary<TitleBarActivityType, Int>()
    
    // UI
    @IBOutlet var rootView: UIView!
    
    @IBOutlet weak var btnClose: AdvancedButton!
    @IBOutlet weak var btnMenu: AdvancedButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var progressBarBackground: UIView!
    @IBOutlet weak var progressBar: UIView!
    
    init(_ viewController: TrinityViewController, _ frame: CGRect, _ isLauncher: Bool, _ appId: String) {
        super.init(frame: frame)
        
        self.viewController = viewController;
        self.appId = appId

        let view = loadViewFromNib();
        self.addConstraint(NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0))
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        
        if (isLauncher) {
            btnClose.isHidden = true
        }
        
        setForegroundMode(.LIGHT)
    }
    
    func loadViewFromNib() ->UIView {
        let className = type(of:self)
        let bundle = Bundle(for:className)
        let name = NSStringFromClass(className).components(separatedBy: ".").last
        let nib = UINib(nibName: name!, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
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
    
    @IBAction func closeClicked(_ sender: Any) {
        try? AppManager.getShareInstance().close(self.viewController!.appInfo!.app_id);
    }
    
    @IBAction func minimizeClicked(_ sender: Any) {
        do {
            // Go back to launcher if in an app, and ask to show the menu panel
            if (!isLauncher) {
                try AppManager.getShareInstance().loadLauncher();
                try AppManager.getShareInstance()
                    .sendLauncherMessage(AppManager.MSG_TYPE_INTERNAL, "menu-show", self.appId!)
            }
            else {
                // If we are in the launcher, toggle the menu visibility
                try AppManager.getShareInstance()
                    .sendLauncherMessage(AppManager.MSG_TYPE_INTERNAL, "menu-toggle", self.appId!)
            }
        }
        catch {
            print(error)
        }
    }
    
    @IBAction func toggleClicked(_ sender: Any) {
        let msg = "{\"action\":\"toggle\"}";
        do {
            try AppManager.getShareInstance().sendMessage("launcher", AppManager.MSG_TYPE_IN_REFRESH, msg, "system");
        }
        catch {
            print("Send message: " + msg + " error!");
        }
    }
    
    @objc func clickBack() {
        self.viewController!.webViewEngine.evaluateJavaScript("window.history.back();", completionHandler: nil);
    }
    
    public func showActivityIndicator(activityType: TitleBarActivityType) {
        // Increase reference count for this progress animation type
        activityCounters[activityType] = (activityCounters[activityType] ?? 0) + 1
        updateAnimation()
    }

    public func hideActivityIndicator(activityType: TitleBarActivityType) {
        // Decrease reference count for this progress animation type
        activityCounters[activityType] = (activityCounters[activityType] ?? 0) - 1
        updateAnimation()
    }

    public func setTitle(_ title: String) {
        titleLabel.text = title.uppercased()
    }

    public func setBackgroundColor(_ hexColor: String) -> Bool {
        if let color = UIColor.init(hex: hexColor) {
            rootView.backgroundColor = color
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

        btnMenu.leftImageColor = color
        btnClose.leftImageColor = color
        titleLabel.textColor = color
    }
    
    /**
     * Based on the counters for each activity, determines which activity type has the priority and plays the appropriate animation.
     * If no more animation, the animation is stopped
     */
    private func updateAnimation() {
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
            self.progressBar.alpha = 0.0

            // If an animation is already in progress, don't interrupt it and just change the background color instead.
            // Otherwise, start an animation
            if (onGoingProgressAnimation == nil) {
                animateProgressBarIn()
            }
        }
        else {
            stopProgressAnimation()
            progressBar.isHidden = true
        }
    }

    private var onGoingProgressAnimation: UIViewPropertyAnimator?
    
    private func animateProgressBarIn() {
        onGoingProgressAnimation = UIViewPropertyAnimator(duration: 1.0, curve: .easeOut, animations: {
                self.progressBar.alpha = 1.0
        })
        
        onGoingProgressAnimation!.addCompletion { _ in
                self.onGoingProgressAnimation = nil
                self.animateProgressBarOut()
        }
        onGoingProgressAnimation!.startAnimation(afterDelay: 0.0)
    }

    private func animateProgressBarOut() {
        onGoingProgressAnimation = UIViewPropertyAnimator(duration: 1.0, curve: .easeOut, animations: {
                self.progressBar.alpha = 0.0
        })
        
        onGoingProgressAnimation!.addCompletion { _ in
                self.onGoingProgressAnimation = nil
                self.animateProgressBarIn()
        }
        onGoingProgressAnimation!.startAnimation(afterDelay: 0.0)
    }

    private func stopProgressAnimation() {
        if let animation = onGoingProgressAnimation {
            animation.finishAnimation(at: .start)
            onGoingProgressAnimation = nil
        }
    }
}
