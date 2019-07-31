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
    
    let viewController: AppViewController;
    let btnBack = UIButton(type: .custom);
    let btnLauncher = UIButton(type: .custom);
    let btnClose = UIButton(type: .custom);
    
    
    init(_ viewController: AppViewController, _ frame: CGRect) {
        self.viewController = viewController;
        super.init(frame: frame);
        
        self.backgroundColor = UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.5);
        self.isHidden = true;
        
//        btnBack.frame = CGRect(x:10, y: 5, width:35, height:35);
//        btnBack.setImage(UIImage(named:"back"), for:.normal)
//        btnBack.addTarget(self, action:#selector(clickBack), for:.touchDown);
//        self.addSubview(btnBack);
        
//        btnLauncher.frame = CGRect(x:frame.size.width - 80, y: 8, width:35, height:35);
//        btnLauncher.setImage(UIImage(named:"dot"), for:.normal)
        btnLauncher.frame = CGRect(x:frame.size.width - 175, y: 5, width:85, height:35);
        btnLauncher.setTitle("Launcher", for:.normal);
        btnLauncher.backgroundColor = UIColor.black;
        btnLauncher.layer.cornerRadius = 5;
        btnLauncher.addTarget(self, action:#selector(clickLaunchr), for:.touchDown);
        self.addSubview(btnLauncher);
        
//        btnClose.frame = CGRect(x:frame.size.width - 40, y: 8, width:30, height:30);
//        btnClose.setImage(UIImage(named:"dot-circle"), for:.normal);
        btnClose.frame = CGRect(x:frame.size.width - 80, y: 5, width:70, height:35);
        btnClose.setTitle("Close", for:.normal);
        btnClose.backgroundColor = UIColor.black;
        btnClose.layer.cornerRadius = 5;
        btnClose.addTarget(self, action:#selector(clickClose), for:.touchDown);
        self.addSubview(btnClose);
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
    
    @objc func clickBack() {
        self.viewController.webViewEngine.evaluateJavaScript("window.history.back();", completionHandler: nil);
    }
    
    
}

