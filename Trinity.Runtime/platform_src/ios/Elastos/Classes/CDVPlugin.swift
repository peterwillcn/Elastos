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
            return true;
        }
    }
    
    @objc func trinityExecute(_ command: CDVInvokedUrlCommand) -> Bool {
        let appView: AppViewController? = self.viewController as? AppViewController
        if (appView != nil ) {
            // This call is asynchronous because there can be a UI interaction to request user authorization
            // to use a plugin, and we cannot block the UI thread
            appView!.getPluginAuthority(self.pluginName, self, command) { authority in
                if (authority == AppInfo.AUTHORITY_NOEXIST || authority == AppInfo.AUTHORITY_DENY) {
                    let msg = "Plugin:'" + self.pluginName + "' doesn't have permission to run."
                    let result = CDVPluginResult(status: CDVCommandStatus_ERROR,
                                                 messageAs: msg);

                    self.commandDelegate.send(result, callbackId: command.callbackId)
                }
                else if (authority == AppInfo.AUTHORITY_NOINIT || authority == AppInfo.AUTHORITY_ASK) {
                    let result = CDVPluginResult(status: CDVCommandStatus_NO_RESULT);
                    result?.setKeepCallbackAs(true);
                    self.commandDelegate.send(result, callbackId: command.callbackId)
                }
                else if (authority == AppInfo.AUTHORITY_ALLOW) {
                    _ = self.execute(command)
                }
                else {
                    throw ("Authority value \(authority) not handled in trinityExecute()")
                }
            }
            return true // Assume successful execution (synchronous)
            
//            let ret = appView!.getPermissionGroup().getApiPermission(pluginName, command.methodName);
//            if (!ret) {
//                let msg = "'" + pluginName + "." + command.methodName + "' have not permssion.";
//                let result = CDVPluginResult(status: CDVCommandStatus_ERROR,
//                                             messageAs: msg);
//
//                self.commandDelegate.send(result, callbackId: command.callbackId)
//                return true;
//            }
        }
        else {
            return self.execute(command)
        }
    }
 }
