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
 
 @objc(AuthorityPlugin)
 class AuthorityPlugin : CDVPlugin {
    var originalPlugin: TrinityPlugin?;
    var appInfo: AppInfo?;
    var pluginName: String?;
    
    func setInfo(_ name: String, _ originalPlugin: TrinityPlugin, _ info: AppInfo) {
        self.appInfo = info;
        self.pluginName = name;
        self.originalPlugin = originalPlugin;
    }
    
    @objc func trinityExecute(_ command: CDVInvokedUrlCommand) -> Bool {
        if originalPlugin != nil {
            let authority = AppManager.appManager!.getPluginAuthority(appInfo!.id, pluginName!);
            if (authority == AppInfo.AUTHORITY_ALLOW) {
                return originalPlugin!.trinityExecute(command);
            }
            else if (authority == AppInfo.AUTHORITY_NOINIT || authority == AppInfo.AUTHORITY_ASK) {
                AppManager.appManager!.runAlertPluginAuth(appInfo!, pluginName!);
            }
            let err = "The plugin:'" + pluginName! + "' isn't add plugin access list!!"
            let result = CDVPluginResult(status: CDVCommandStatus_ERROR,
                                         messageAs: err);
            if command.callbackId != nil {
                self.commandDelegate.send(result, callbackId: command.callbackId)
            }
        }
        return true;
    }
    
//    @objc override var webView: UIView? {
//        get {
//            return originalPlugin!.webView;
//        }
//    }
    
//    @objc override var viewController: UIViewController? {
//        get{
//            return originalPlugin!.viewController;
//        }
//    }
    
//    @property (nonatomic, readonly, weak) id <CDVWebViewEngineProtocol> webViewEngine;
//
//    @property (nonatomic, weak) UIViewController* viewController;
//
//    @property (readonly, assign) BOOL hasPendingOperation;

    
//    @objc override var hasPendingOperation: Bool? {
//        get {
//            return originalPlugin!.hasPendingOperation;
//        }
//    }
    
    @objc override func pluginInitialize() {
        return originalPlugin!.pluginInitialize();
    }
    
    @objc override func dispose() {
        originalPlugin!.dispose();
    }

    @objc override func handleOpenURL(_ notification: Notification) {
        originalPlugin!.handleOpenURL(notification);
    }
    
    @objc override func handleOpenURL(withApplicationSourceAndAnnotation notification: Notification) {
        originalPlugin!.handleOpenURL(withApplicationSourceAndAnnotation: notification);
    }
    
    @objc override func onAppTerminate() {
        originalPlugin!.onAppTerminate();
    }
    
    @objc override func onMemoryWarning() {
        originalPlugin!.onMemoryWarning();
    }
    
    @objc override func onReset() {
        originalPlugin!.onReset();
    }
    
    @objc override func appDelegate() -> Any {
        return originalPlugin!.appDelegate();
    }
    
 }
