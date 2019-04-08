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
    
    func setInfo(_ info: AppInfo) {
        self.appInfo = info;
    }
    
    override func urlAuthority(_ obj:NSObject) -> Bool {
        guard  self.appInfo != nil else {
            return false;
        }
        
        for (url, pattern) in self.appWhitelist as! [String: NSObject] {
            if (pattern == obj) {
                let authority = AppManager.appManager!.getUrlAuthority(appInfo!.app_id, url);
                if (authority == AppInfo.AUTHORITY_ALLOW) {
                    return true;
                }
                else if (authority == AppInfo.AUTHORITY_NOINIT || authority == AppInfo.AUTHORITY_ASK) {
                    AppManager.appManager!.runAlertUrlAuth(appInfo!, url);
                }
                break;
            }
        }
        return false;
    }
    
 }
