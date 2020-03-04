//
//  TestView.swift
//  elastOS
//
//  Created by Benjamin Piette on 16/02/2020.
//

import Foundation
import UIKit

class TitleBarView: UIView {
    var viewController: TrinityViewController?;
    var isLauncher = false;
    
    @IBOutlet var rootView: UIView!
    
    @IBOutlet weak var btnClose: AdvancedButton!
    @IBOutlet weak var btnMenu: AdvancedButton!
    
    @IBOutlet weak var progressBarBackground: UIView!
    @IBOutlet weak var progressBar: UIView!
    
    init(_ viewController: TrinityViewController, _ frame: CGRect, _ isLauncher: Bool) {
        super.init(frame: frame);
        self.viewController = viewController;

//        self.backgroundColor = UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.5);

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

       // hideProgress()
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
        try? AppManager.getShareInstance().loadLauncher();
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
    
    /*@objc func showProgress() {
        progress.isHidden = false;
    }

    @objc func hideProgress() {
        // TODO: For now if setting visibility to INVISIBLE, setting it to VISIBLE later doesn't work any more.
        // We will change the  progress bar soon any way so just set progress to 0 for now.
        progress.progress = 0;
    }

    @objc func setBarProgress(_ value: Float) {
        showProgress();
        progress.progress = value;
    }*/
}
