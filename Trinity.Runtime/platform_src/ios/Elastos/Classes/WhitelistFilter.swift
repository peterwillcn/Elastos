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
 
 @objc class WhitelistFilter: CDVIntentAndNavigationFilter {
    var appInfo: AppInfo?;
    
    func setList(_ info: AppInfo) {
        self.appInfo = info;
        
        let appPath = AppManager.appManager!.getAppUrl(info) + "*";
        let dataPath = AppManager.appManager!.getDataUrl(info) + "*";
        let wwwPath = "file://" + getAbsolutePath("www");
        let pluginsPath = wwwPath + "/plugins/*";
        let cordovaPath = wwwPath + "/cordova*";
        
        var allowNavigations = [String]();
        allowNavigations.append(appPath);
        allowNavigations.append(dataPath);
        allowNavigations.append(pluginsPath);
        allowNavigations.append(cordovaPath);
        
        for urlAuth in info.urls {
            allowNavigations.append(urlAuth.url);
        }
        
        let whitelist = AppWhitelist(array: allowNavigations);
        whitelist?.setInfo(info);
        
        self.allowNavigationsWhitelist = whitelist
        self.allowIntentsWhitelist = CDVWhitelist()
    }
    
    func setFilter(_ filter: CDVIntentAndNavigationFilter) {
        self.allowIntentsWhitelist = filter.allowIntentsWhitelist;
        self.allowNavigationsWhitelist = filter.allowNavigationsWhitelist;
    }
    
    @objc func shouldAllowNavigation(_ url: String) -> Bool {
        let str = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let urlv = URL(string: str!)
        let value = CDVIntentAndNavigationFilter.filterUrl(urlv, intentsWhitelist: self.allowIntentsWhitelist,
                navigationsWhitelist: self.allowNavigationsWhitelist)
        if value == CDVIntentAndNavigationFilterValue.navigationAllowed {
            return true;
        }
        else {
            return false;
        }
        
    }
    
    @objc func checkPluginAuthority(_ pluginName: String) -> Bool {
        let authority = AppManager.appManager!.getPluginAuthority(appInfo!.id, pluginName);
        if (authority == AppInfo.AUTHORITY_ALLOW) {
            return true;
        }
        else if (authority == AppInfo.AUTHORITY_NOINIT || authority == AppInfo.AUTHORITY_ASK) {
            AppManager.appManager!.runAlertPluginAuth(appInfo!, pluginName);
        }
        return false;
    }
 }
