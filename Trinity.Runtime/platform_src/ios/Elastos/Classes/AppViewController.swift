 /*
  * Copyright (c) 2018 Elastos Foundation
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
 
 class AppViewController : TrinityViewController {
    static var originalPluginsMap = [String: String](minimumCapacity: 30);
    static var originalStartupPluginNames = [String]();
    static var originalSettings: NSMutableDictionary?;
    
    var titlebar: UIView?;
    
    var appInfo: AppInfo?;
    var trinityPluginsMap = [String: String]();
    let defaultPlugins = [
        "gesturehandler",
        "appmanager",
        "console",
        "localstorage",
        "handleopenurl",
        "intentandnavigationfilter",
        "appservice",
        "authorityplugin",
    ];
    
    func setInfo(_ id: String, _ appInfo: AppInfo) {
        self.id = id;
        self.appInfo = appInfo;
        self.whitelistFilter = WhitelistFilter();
        self.whitelistFilter?.setList(appInfo);
    }
    
    override func loadSettings() {
        // Get the plugin dictionary, whitelist and settings from the delegate.
        self.pluginsMap = [String: String]();
        for (name, className) in AppViewController.originalPluginsMap as [String: String] {
            if (name == "intentandnavigationfilter") {
                self.pluginsMap[name] = "WhitelistFiter";
            }
            else {
                self.pluginsMap[name] = className;
            }
        }
        self.pluginsMap["authorityplugin"] = "AuthorityPlugin";
        
        self.startupPluginNames = NSMutableArray(capacity: 30);
        for name in AppViewController.originalStartupPluginNames {
            self.startupPluginNames.add(name);
        }
        
        self.settings = AppViewController.originalSettings
        
        // And the start folder/page.
        if(self.wwwFolderName == nil){
            self.wwwFolderName = "www";
        }
        if (self.startPage == nil){
            self.startPage = AppManager.appManager!.getStartPath(self.appInfo!);
        }
        
        // Initialize the plugin objects dict.
        self.pluginObjects = NSMutableDictionary(capacity: 30);
    }
    
    override func getCommandInstance(_ name: String) -> Any {
        let pluginName = name.lowercased();
        let className = self.pluginsMap[pluginName];
        var obj = self.pluginObjects[className as Any];
        guard obj == nil else {
            return obj as Any;
        }
        
        if !self.defaultPlugins.contains(pluginName) {
            var setPlugin = false;
            for pluginAuth in (appInfo?.plugins)! {
                if pluginName == pluginAuth.plugin {
                    setPlugin = true;
                    break;
                }
            }
            if !setPlugin {
                let nullPlugin = NullPlugin(pluginName);
                self.pluginObjects[className as Any] = nullPlugin;
                return nullPlugin;
            }
            
        }
        
        obj = super.getCommandInstance(pluginName)
        let trinityPlugin = obj as? TrinityPlugin
        
        if trinityPlugin != nil {
            let dataPath = AppManager.appManager!.getDataPath(self.id);
            let appPath = AppManager.appManager!.getAppPath(self.appInfo!);
            trinityPlugin!.trinityInitialize(pluginName, 
                whitelistFilter:self.whitelistFilter, checkAuthority:true, 
                dataPath:dataPath, appPath:appPath);
        }

        return obj as Any;
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        let frame = self.view.bounds;
        let titleHeight = CGFloat(45);
        print(frame.origin.y);
        
        let titleRect = CGRect(x: frame.origin.x, y: frame.origin.y + 20,
                               width: frame.size.width, height: titleHeight);
        titlebar = UIView(frame: titleRect);
        titlebar!.backgroundColor = UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.5)
        
        let btnClose = UIButton(type: .custom);
        btnClose.frame = CGRect(x:frame.size.width - 80, y: 5, width:70, height:35);
        btnClose.setTitle("Close", for:.normal);
        btnClose.backgroundColor = UIColor.black;
        btnClose.layer.cornerRadius = 5;
        btnClose.addTarget(self, action:#selector(btnClick), for:.touchDown);
        
        titlebar!.addSubview(btnClose);
        titlebar!.isHidden = true;
        self.view.addSubview(titlebar!);
        self.view.bringSubviewToFront(titlebar!);
//        self.webViewEngine.engineWebView.frame = CGRect(x: frame.origin.x,
//                                                        y: frame.origin.y + titleHeight,
//                                                        width: frame.width,
//                                                        height: frame.height - titleHeight);
        
        
    }
    
    
    @objc func btnClick(){
        try? AppManager.appManager!.close(id);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        for (name , value) in self.pluginObjects as! [String: CDVPlugin] {
            if (name == "AppServicePlugin") {
                let plugin = value as! AppServicePlugin;
                plugin.setId(id);
                self.basePlugin = plugin;
            }
        }
        
        let swipe = UISwipeGestureRecognizer(target:self, action:#selector(handleSwipes(_:)));
        swipe.direction = .down;
        self.webView.addGestureRecognizer(swipe);
        self.webView.scrollView.panGestureRecognizer.require(toFail: swipe);
    }
    
    @objc func handleSwipes(_ recognizer:UISwipeGestureRecognizer){
//        print("swipe ok")
//        let point=recognizer.location(in: self.view)
//        print(point.x)
//        print(point.y)
        titlebar!.isHidden = !titlebar!.isHidden;
    }
 }
