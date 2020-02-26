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
 
 @objc class AppWhitelist : CDVWhitelist {
    var appInfo: AppInfo?
    var urlType = 0;
    
    @objc static let TYPE_URL = 0;
    @objc static let TYPE_INTENT = 1;
    
    func setInfo(_ info: AppInfo, _ type: Int) {
        self.appInfo = info;
        self.urlType = type;
    }
    
    func getAuth(_ url: String) -> Int {
        if (urlType == AppWhitelist.TYPE_URL) {
            return AppManager.getShareInstance().getUrlAuthority(appInfo!.app_id, url);
        }
        else {
            return AppManager.getShareInstance().getIntentAuthority(appInfo!.app_id, url);
        }
    }

    func runAlert(_ url: String, _ authority: Int) -> Int {
        if (urlType == AppWhitelist.TYPE_URL) {
            AppManager.getShareInstance().runAlertUrlAuth(appInfo!, url);
            return authority;
        }
        else {
            return authority;
        }
    }
    
    override func urlAuthority(_ obj:NSObject) -> Bool {
        guard  self.appInfo != nil else {
            return false;
        }
        
        for (url, pattern) in self.appWhitelist as! [String: NSObject] {
            if (pattern == obj) {
                var authority = getAuth(url);
                if (authority == AppInfo.AUTHORITY_ALLOW) {
                    return true;
                }
                else if (authority == AppInfo.AUTHORITY_NOINIT || authority == AppInfo.AUTHORITY_ASK) {
                    authority = runAlert(url, authority);
                }
                break;
                
                if (authority == AppInfo.AUTHORITY_ALLOW) {
                    return true;
                }
            }
        }
        return false;
    }
    
 }
