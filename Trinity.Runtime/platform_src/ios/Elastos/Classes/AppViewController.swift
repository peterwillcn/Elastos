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
    ]
    
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
                let nullPlugin = NullPlugin("pluginName");
                self.pluginObjects[className as Any] = nullPlugin;
                return nullPlugin;
            }
            
        }
        
        obj = super.getCommandInstance(pluginName)
        let trinityPlugin = obj as? TrinityPlugin
        
        if trinityPlugin != nil {
            trinityPlugin!.setWhitelistFilter(self.whitelistFilter);
            let authorityPlugin = super.getCommandInstance("authorityplugin") as? AuthorityPlugin
            guard authorityPlugin != nil else {
                return authorityPlugin as Any;
            }
            authorityPlugin!.setInfo(pluginName, trinityPlugin!, appInfo!);
            self.pluginObjects[className as Any] = authorityPlugin;
            self.pluginObjects["AuthorityPlugin"] = nil
            obj = authorityPlugin;
        }

        return obj as Any;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
//        let frame = self.view.bounds;
//        let titleHeight = CGFloat(20);
//        print(frame.origin.y);
//        
//        let labelRect = CGRect(x: frame.origin.x, y: frame.origin.y,
//                               width: frame.size.width, height: titleHeight);
//        let label = UILabel.init(frame: labelRect);
//        label.text = "Text";
//        self.view.addSubview(label)
//        self.webViewEngine.engineWebView.frame = CGRect(x: frame.origin.x,
//                                                        y: frame.origin.y + titleHeight,
//                                                        width: frame.width,
//                                                        height: frame.height - titleHeight);
        
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
    }
 }
