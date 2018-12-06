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
 
 class LauncherViewController : TrinityViewController {
    

    override func loadSettings() {
        super.loadSettings();
        self.id = "launcher";
        
        let obj = super.getCommandInstance("intentandnavigationfilter");
        self.whitelistFilter = WhitelistFilter();
        self.whitelistFilter?.setFilter(obj as! CDVIntentAndNavigationFilter);
        
        for (key, value) in pluginsMap {
            let name = key as! String;
            let className = value as! String;
            if (name != "appmanager") {
                AppViewController.originalPluginsMap[name] = className;
            }
        }
        pluginsMap["appservice"] = nil;
        
        for item in self.startupPluginNames {
            let name = item as! String;
            if (name != "appmanager") {
                AppViewController.originalStartupPluginNames.append(name);
            }
        }
        self.startupPluginNames.remove("appservice");
        
        AppViewController.originalSettings = self.settings;
    }
    
    override func getCommandInstance(_ name: String) -> Any {
        let pluginName = name.lowercased();
        let className = self.pluginsMap[pluginName];
        var obj = self.pluginObjects[className as Any];
        guard obj == nil else {
            return obj as Any;
        }
        
        obj = super.getCommandInstance(pluginName)
        let trinityPlugin = obj as? TrinityPlugin
        
        if trinityPlugin != nil {
            trinityPlugin!.setWhitelistFilter(self.whitelistFilter);
        }
        
        return obj as Any;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        for (name , value) in self.pluginObjects as! [String: CDVPlugin] {
            if (name == "AppManagerPlugin") {
                self.basePlugin = value as! AppManagerPlugin;
                break;
            }
        }
        
    }
 }
