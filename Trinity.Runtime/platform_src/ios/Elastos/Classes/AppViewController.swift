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

    var permissionGroup: PermissionGroup?;

    var trinityPluginsMap = [String: String]();
    let defaultPlugins = [
        "gesturehandler",
        "appmanager",
        "console",
        "localstorage",
        "handleopenurl",
        "intentandnavigationfilter",
        "authorityplugin",
        "statusbar"
    ];

    convenience init(_ appInfo: AppInfo, _ filter: WhitelistFilter) {
        self.init();
        self.appInfo = appInfo;
        self.id = appInfo.app_id;
        self.whitelistFilter = filter;
//        self.permissionGroup = PermissionManager.getShareInstance().getPermissionGroup(appInfo.app_id);
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
//        self.pluginsMap["authorityplugin"] = "AuthorityPlugin";

        self.startupPluginNames = NSMutableArray(capacity: 30);
        for name in AppViewController.originalStartupPluginNames {
            self.startupPluginNames.add(name);
        }

        self.settings = AppViewController.originalSettings

        self.startPage = AppManager.getShareInstance().getStartPath(self.appInfo!);

        // Initialize the plugin objects dict.
        self.pluginObjects = NSMutableDictionary(capacity: 30);
        self.pluginObjects["WhitelistFiter"] = self.whitelistFilter;

//        self.settings["cordovawebviewengine"] = "CDVUIWebViewEngine";
    }

    override func filterPlugin(_ pluginName: String, _ className: String) -> NullPlugin? {
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
                self.register(nullPlugin, withClassName: className);
                return nullPlugin;
            }

        }
        return nil;
    }

    override func getCommandInstance(_ name: String) -> Any {
        let obj = super.getCommandInstance(name);
        if (appInfo!.type == "url") {
            print(name);
            if (name == "statusbar") {
                let command = CDVInvokedUrlCommand(arguments: [false] as! [Any], callbackId: nil, className: nil, methodName: "overlaysWebView")!;
                (obj as! CDVPlugin).execute(command);
            }
        }
        return obj;
    }

    func getPluginAuthority(_ pluginName: String,
                                  _ plugin: CDVPlugin,
                                  _ command: CDVInvokedUrlCommand) -> Int {
        if (self.defaultPlugins.contains(pluginName)) {
            return AppInfo.AUTHORITY_ALLOW;
        }

        let authority = AppManager.getShareInstance().getPluginAuthority(appInfo!.app_id, pluginName);
        if (authority == AppInfo.AUTHORITY_NOINIT || authority == AppInfo.AUTHORITY_ASK) {
            AppManager.getShareInstance().runAlertPluginAuth(appInfo!, pluginName, plugin, command);
        }
        return authority;
    }

    func getPermissionGroup() -> PermissionGroup {
        return self.permissionGroup!;
    }
 }
