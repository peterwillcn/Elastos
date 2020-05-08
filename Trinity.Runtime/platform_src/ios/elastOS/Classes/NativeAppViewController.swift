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

 import Foundation

 class NativeAppViewController : AppViewController {
    var mainView: UIView?;
    var mainViewController: NativeAppMainViewController?;
    
    convenience init(_ appInfo: AppInfo, _ vcClassName: String) {
        self.init(appInfo);
        
        self.basePlugin = AppBasePlugin();
        self.basePlugin!.setWhitelist(self.whitelistFilter)
        self.basePlugin!.setInfo(self.appInfo);
        
        let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String;
        let cls:AnyClass? = NSClassFromString(nameSpace + "." + vcClassName);
        let clsType = cls as! NativeAppMainViewController.Type;
        mainViewController = clsType.init(appInfo, basePlugin!);
        mainView = mainViewController!.view;
    }
    
    override func setReady() {
        mainViewController!.setReady();
    }
    
    override func loadSettings() {
        self.pluginObjects = NSMutableDictionary();
        AppManager.getShareInstance().setAppVisible(id, "show");
    }
    
    func addControllerView(_ container: UIView) {
        container.addSubview(mainView!);
        self.addMatchParentConstraints(view: mainView!, parent: container)
    }

    override func newCordovaView(withFrame bounds: CGRect) -> UIView {
        let container = super.newCordovaView(withFrame: bounds);
        self.addControllerView(container);
        return container;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    override func isNativeApp() -> Bool {
        return true;
    }
 }
