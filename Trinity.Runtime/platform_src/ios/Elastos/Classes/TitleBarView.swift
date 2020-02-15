 /*
  * Copyright (c) 2019 Elastos Foundation
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

import Foundation
import UIKit

class TitleBarView: UIView {
    
//    static let HEIGHT: CGFloat = 45;
    
    let viewController: TrinityViewController;
    var isLauncher = false;
    
    @IBOutlet weak var btnToggle: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnLauncher: UIButton!
    
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    
    init(_ viewController: TrinityViewController, _ frame: CGRect, _ isLauncher: Bool) {
        self.viewController = viewController;
        super.init(frame: frame);
        
//        self.backgroundColor = UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.5);

        let view = loadViewFromNib();
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
        
        if (isLauncher) {
            let bounds = progress.frame;
            progress.frame = CGRect(x: bounds.origin.x, y: bounds.origin.y,  width: bounds.size.width + btnLauncher.frame.size.width, height: bounds.size.height);
            btnClose.isHidden = true;
            btnLauncher.isHidden = true;
            //            btnLauncher.removeFromSuperview();
            btnToggle.addTarget(self, action:#selector(clickToggle), for:.touchDown);
        }
        else {
            btnToggle.isHidden = true;
            btnToggle.removeFromSuperview();
            btnLauncher.addTarget(self, action:#selector(clickLaunchr), for:.touchDown);
            btnClose.addTarget(self, action:#selector(clickClose), for:.touchDown);
        }
        hideProgress();
    }
    
    func loadViewFromNib() ->UIView {
        let className = type(of:self)
        let bundle = Bundle(for:className)
        let name = NSStringFromClass(className).components(separatedBy: ".").last
        let nib = UINib(nibName: name!, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func clickClose() {
        try? AppManager.getShareInstance().close(self.viewController.appInfo!.app_id);
    }
    
    @objc func clickLaunchr() {
        try? AppManager.getShareInstance().loadLauncher();
    }
    
    @objc func clickToggle() {
        let msg = "{\"action\":\"toggle\"}";
        do {
            try AppManager.getShareInstance().sendMessage("launcher", AppManager.MSG_TYPE_IN_REFRESH, msg, "system");
        }
        catch let error {
            print("Send message: " + msg + " error!");
        }
    }
    
    @objc func clickBack() {
        self.viewController.webViewEngine.evaluateJavaScript("window.history.back();", completionHandler: nil);
    }
    
    @objc func showProgress() {
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
    }
}

