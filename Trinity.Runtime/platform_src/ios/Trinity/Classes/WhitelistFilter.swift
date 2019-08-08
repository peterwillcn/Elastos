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
    var appManager: AppManager;
    var appWiteList: AppWhitelist?;

    override init() {
        self.appManager = AppManager.getShareInstance();
    }

    convenience init(_ appInfo: AppInfo) {
        self.init();
        self.setList(appInfo);
    }

    func setList(_ info: AppInfo) {
        self.appInfo = info;

        let appPath = self.appManager.getAppUrl(info) + "*";
        let dataPath = self.appManager.getDataUrl(info.app_id) + "*";
        let wwwPath = "file://" + getAbsolutePath("www");
        let pluginsPath = wwwPath + "/plugins/*";
        let cordovaPath = wwwPath + "/cordova*";

        var allowNavigations = [String]();
        allowNavigations.append(appPath);
        allowNavigations.append(dataPath);
        allowNavigations.append(pluginsPath);
        allowNavigations.append(cordovaPath);
        allowNavigations.append("trinity:///asset/*");
        allowNavigations.append("trinity:///data/*");

        allowNavigations.append("ionic://*");
        let whitelist = CDVWhitelist(array: allowNavigations)

        self.allowNavigationsWhitelist = whitelist
        self.allowIntentsWhitelist = whitelist

        var allowUrls = [String]();
        for urlAuth in info.urls {
            allowUrls.append(urlAuth.url);
        }
        self.appWiteList = AppWhitelist(array: allowUrls);
        self.appWiteList!.setInfo(info);
    }

    func setFilter(_ filter: CDVIntentAndNavigationFilter) {
        self.allowIntentsWhitelist = filter.allowIntentsWhitelist;
        self.allowNavigationsWhitelist = filter.allowNavigationsWhitelist;
    }

    @objc func shouldAllowNavigation(_ url: String) -> Bool {
        let str = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let urlStr = URL(string: str!)
        var ret = self.allowNavigationsWhitelist.urlisAllowed(urlStr);
        if (!ret) {
            ret = self.appWiteList!.urlisAllowed(urlStr);
        }
        return ret;
    }

    @objc func shouldOverrideLoad(request:URLRequest, navigationType:UIWebView.NavigationType )  -> Bool {
        return self.shouldAllowNavigation(request.url!.absoluteString);
//        return CDVIntentAndNavigationFilter.shouldOverrideLoad(with: request, navigationType: navigationType, filterValue: self.filterUrl(request.url!));
    }

    @objc func filterUrl(_ url:URL) -> CDVIntentAndNavigationFilterValue {
        return CDVIntentAndNavigationFilter.filterUrl(url, intentsWhitelist:self.allowIntentsWhitelist, navigationsWhitelist:self.allowNavigationsWhitelist);
    }

 }
