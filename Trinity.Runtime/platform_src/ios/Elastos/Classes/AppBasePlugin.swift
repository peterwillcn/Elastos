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
 
 @objc(AppBasePlugin)
 class AppBasePlugin : CDVPlugin {
    var callbackId: String?
    var id: String?
    
    func success(_ command: CDVInvokedUrlCommand, _ retAsString: String) {
        let result = CDVPluginResult(status: CDVCommandStatus_OK,
                                     messageAs: retAsString);
        
        self.commandDelegate.send(result, callbackId: command.callbackId)
    }
    
    func success(_ command: CDVInvokedUrlCommand, retAsDict: [String : Any]) {
        let result = CDVPluginResult(status: CDVCommandStatus_OK,
                                     messageAs: retAsDict);
        
        self.commandDelegate.send(result, callbackId: command.callbackId)
    }
    
    func success(_ command: CDVInvokedUrlCommand, retAsArray: [String]) {
        let result = CDVPluginResult(status: CDVCommandStatus_OK,
                                     messageAs: retAsArray);
        
        self.commandDelegate.send(result, callbackId: command.callbackId)
    }
    
    func error(_ command: CDVInvokedUrlCommand, _ retAsString: String) {
        let result = CDVPluginResult(status: CDVCommandStatus_ERROR,
                                     messageAs: retAsString);
        
        self.commandDelegate.send(result, callbackId: command.callbackId)
    }
    
    @objc(launcher:)
    func launcher(_ command: CDVInvokedUrlCommand) {
        do {
            try AppManager.appManager!.loadLauncher();
            self.success(command, "ok");
        } catch AppError.error(let err) {
            self.error(command, err);
        } catch let error {
            self.error(command, error.localizedDescription);
        }
    }
    
    @objc(start:)
    func start(_ command: CDVInvokedUrlCommand) {
        let id = command.arguments[0] as? String ?? ""
        
        if (id == "") {
            self.error(command, "Invalid id.")
        }
        else if (id == "launcher") {
            self.error(command, "Can't start launcher! Please use launcher().")
        }
        else {
            do {
                try AppManager.appManager!.start(id);
                self.success(command, "ok");
            } catch AppError.error(let err) {
                self.error(command, err);
            } catch let error {
                self.error(command, error.localizedDescription);
            }
        }
    }
    
    @objc(close:)
    func close(_ command: CDVInvokedUrlCommand) {
        var appId = self.id;
        if (self.id == "launcher") {
            appId = command.arguments[0] as? String ?? "";
        }
        
        if (appId == nil || appId == "") {
            self.error(command, "Invalid id.")
            return
        }
        
        do {
            try AppManager.appManager!.close(appId!);
            self.success(command, "ok");
        } catch AppError.error(let err) {
            self.error(command, err);
        } catch let error {
            self.error(command, error.localizedDescription);
        }
    }
    
    func jsonAppPlugins(_ plugins: [PluginAuth]) -> [Dictionary<String, Any>] {
        var ret = [Dictionary<String, Any>]()

        for pluginAuth in plugins {
            ret.append(["plugin": pluginAuth.plugin,
                        "authority": pluginAuth.authority])
        }

        return ret;
    }

    func jsonAppUrls(_ urls: [UrlAuth]) -> [Dictionary<String, Any>] {
        var ret = [Dictionary<String, Any>]()

        for urlAuth in urls {
            ret.append(["url": urlAuth.url,
                        "authority": urlAuth.authority])
        }

        return ret;
    }

    func jsonAppIcons(_ info: AppInfo) -> [Dictionary<String, String>] {
        var ret = [Dictionary<String, String>]()
        let appUrl = AppManager.appManager!.getAppUrl(info);
        for icon in info.icons {
            ret.append(["src": resetPath(appUrl, icon.src),
                        "sizes": icon.sizes,
                        "type": icon.type])
        }

        return ret;
    }
    
    func jsonAppInfo(_ info: AppInfo) -> [String : Any] {
        let appUrl = AppManager.appManager!.getAppUrl(info);
        let dataUrl = AppManager.appManager!.getDataUrl(info.app_id);
        return [
            "id": info.app_id,
            "version": info.version,
            "name": info.name,
            "shortName": info.short_name,
            "description": info.desc,
            "startUrl": resetPath(appUrl, info.start_url),
            "icons": jsonAppIcons(info),
            "authorName": info.author_name,
            "authorEmail": info.author_email,
            "defaultLocale": info.default_locale,
            "plugins": jsonAppPlugins(info.plugins),
            "urls": jsonAppUrls(info.urls),
            "backgroundColor": info.background_color,
            "themeDisplay": info.theme_display,
            "themeColor": info.theme_color,
            "themeFontName": info.theme_font_name,
            "themeFontColor": info.theme_font_color,
            "installTime": info.install_time,
            "builtIn": info.built_in,
            "appPath": appUrl,
            "dataPath": dataUrl,
            ] as [String : Any]
    }
    
    @objc func getAppInfo(_ command: CDVInvokedUrlCommand) {
        var appId = self.id!;
        if (appId == "launcher") {
            appId = command.arguments[0] as? String ?? ""
        }
        let info = AppManager.appManager!.getAppInfo(appId);
        
        if (info != nil) {
           self.success(command, retAsDict: jsonAppInfo(info!));
        }
        else {
            self.error(command, "No such app!");
        }
    }
    
    @objc(sendMessage:)
    func sendMessage(_ command: CDVInvokedUrlCommand) {
        let toId = command.arguments[0] as? String ?? "";
        let type = command.arguments[1] as? Int ?? -1;
        let msg = command.arguments[2] as? String ?? "";
        
        if (toId == "") {
            self.error(command, "Invalid id.")
            return
        }
        
        do {
            try AppManager.appManager!.sendMessage(toId, type, msg, self.id!);
            self.success(command, "ok");
        } catch AppError.error(let err) {
            self.error(command, err);
        } catch let error {
            self.error(command, error.localizedDescription);
        }
    }

    @objc(setListener:)
    func setListener(_ command: CDVInvokedUrlCommand) {
        self.callbackId = command.callbackId;
        // Don't return any result now
        let result = CDVPluginResult(status: CDVCommandStatus_NO_RESULT);
        result?.setKeepCallbackAs(true);
        self.commandDelegate.send(result, callbackId: command.callbackId)
        
        if (id == "launcher") {
            AppManager.appManager!.setLauncherReady();
        }
    }
    
    func onReceive(_ msg: String, _ type: Int, _ from: String) {
        guard self.callbackId != nil else {
            return;
        }
        
        let ret = [
            "message": msg,
            "type": type,
            "from": from
            ] as [String : Any]
        let result = CDVPluginResult(status: CDVCommandStatus_OK,
                                     messageAs: ret);
        result?.setKeepCallbackAs(true);
        self.commandDelegate?.send(result, callbackId:self.callbackId);
    }

    
 }
