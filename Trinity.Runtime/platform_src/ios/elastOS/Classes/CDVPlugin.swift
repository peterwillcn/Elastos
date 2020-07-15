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

@objc(CDVPlugin)
extension CDVPlugin {

    @objc func execute(_ command: CDVInvokedUrlCommand) -> Bool {
        let methodName = command.methodName + ":";
        let normalSelector:Selector = Selector(methodName);
        if (self.responds(to: normalSelector)) {
            self.perform(normalSelector, with: command);
            return true;
        } else {
            let msg = "ERROR: Method '" + methodName + "' not defined in Plugin '" + command.className + "'";
            let result = CDVPluginResult(status: CDVCommandStatus_ERROR,
                                         messageAs: msg);
            self.commandDelegate.send(result, callbackId: command.callbackId)
            return false;
        }
    }
    
    
    func refuseAccess(_ command: CDVInvokedUrlCommand) {
        let msg = "'" + pluginName + "." + command.methodName + "' have not permssion.";
        let result = CDVPluginResult(status: CDVCommandStatus_ERROR,
                                     messageAs: msg);

        self.commandDelegate.send(result, callbackId: command.callbackId);
    }
        

    @objc func trinityExecute(_ command: CDVInvokedUrlCommand) -> Bool {
            let appView: AppViewController? = self.viewController as? AppViewController
            if (appView != nil ) {
                //checkApiPermission
                let ret = appView!.getPermissionGroup().getApiPermission(pluginName, command.methodName);
                if (!ret) {
                    refuseAccess(command);
                    return true;
                }
                
                let authority = ApiAuthorityManager.getShareInstance().getApiAuthority(appView!.id, self.pluginName, self, command);
                if (authority == AppInfo.AUTHORITY_NOEXIST || authority == AppInfo.AUTHORITY_DENY) {
                    refuseAccess(command);
                    return true;
                }
                else if (authority == AppInfo.AUTHORITY_NOINIT || authority == AppInfo.AUTHORITY_ASK) {
                    return true;
                }
            }
            return self.execute(command);
        }
     }
