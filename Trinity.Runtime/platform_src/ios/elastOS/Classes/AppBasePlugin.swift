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
 class AppBasePlugin : TrinityPlugin {
    var callbackId: String?
    var intentCallbackId: String? = nil;

    var isLauncher = false;
    var isChangeIconPath = false;

    func success(_ command: CDVInvokedUrlCommand) {
        let result = CDVPluginResult(status: CDVCommandStatus_OK)

        self.commandDelegate.send(result, callbackId: command.callbackId)
    }

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
    
    @objc func getVersion(_ command: CDVInvokedUrlCommand) {
        let version = PreferenceManager.getShareInstance().getVersion();
        self.success(command, version);
    }

    @objc func getLocale(_ command: CDVInvokedUrlCommand) {
        let info = AppManager.getShareInstance().getAppInfo(self.appId!);

        do {
            let ret = [
                "defaultLang": info!.default_locale,
                "currentLang": try PreferenceManager.getShareInstance().getCurrentLocale(),
                "systemLang": getCurrentLanguage()
                ] as [String : String]
            self.success(command, retAsDict: ret);
        } catch AppError.error(let err) {
            self.error(command, err);
        } catch let error {
            self.error(command, error.localizedDescription);
        }
    }

    @objc func setCurrentLocale(_ command: CDVInvokedUrlCommand) {
        let code = command.arguments[0] as? String ?? ""

        do {
            try PreferenceManager.getShareInstance().setCurrentLocale(code);
            self.success(command, "ok");
        } catch AppError.error(let err) {
            self.error(command, err);
        } catch let error {
            self.error(command, error.localizedDescription);
        }
    }

    @objc(launcher:)
    func launcher(_ command: CDVInvokedUrlCommand) {
        do {
            try AppManager.getShareInstance().loadLauncher();
            try AppManager.getShareInstance().sendLauncherMessageMinimize(self.appId);
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
                try AppManager.getShareInstance().start(id);
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
        do {
            try AppManager.getShareInstance().close(self.appId);
            self.success(command, "ok");
        } catch AppError.error(let err) {
            self.error(command, err);
        } catch let error {
            self.error(command, error.localizedDescription);
        }
    }

    @objc(closeApp:)
    func closeApp(_ command: CDVInvokedUrlCommand) {
        let appId = command.arguments[0] as? String ?? "";

        if (appId == "") {
            self.error(command, "Invalid id.")
            return
        }

        do {
            try AppManager.getShareInstance().close(appId);
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

    @objc func getIconPath(_ url: String)  -> String? {
        guard isChangeIconPath else {
            return nil;
        }

        let str = (url as NSString).substring(from: 7);
        var index = str.index(of: "/");
        guard index != nil else {
            return nil;
        }
        let app_id = String(str[..<index!]);
        index = str.index(index!, offsetBy: 1);
        guard index != nil else {
            return nil;
        }
        let i = Int(str[index!...]);
        guard i != nil else {
            return nil;
        }

        let info = AppManager.getShareInstance().getAppInfo(app_id);
        guard info != nil else {
            return nil;
        }

        let icon = info!.icons[i!];
        let appUrl = AppManager.getShareInstance().getIconPath(info!);
        return resetPath(appUrl, icon.src);
    }

    func jsonAppIcons(_ info: AppInfo) -> [Dictionary<String, String>] {
        var ret = [Dictionary<String, String>]()
        for i in 0..<info.icons.count {
            let icon = info.icons[i];
            var src = icon.src;
            if (isChangeIconPath) {
                src = "icon://" + info.app_id + "/" + String(i);
            }
            ret.append(["src": src,
                        "sizes": icon.sizes,
                        "type": icon.type])
        }

        return ret;
    }

    func jsonAppLocales(_ info: AppInfo) -> Dictionary<String, Any> {
        var ret = Dictionary<String, Any>()
        for locale in info.locales {
            let language = ["name": locale.name,
                             "shortName": locale.short_name,
                             "description": locale.desc,
                             "authorName": locale.author_name] as [String : String];
            ret[locale.language] = language;
        }

        return ret;
    }

    func jsonAppFrameworks(_ info: AppInfo) -> [Dictionary<String, String>] {
        var ret = [Dictionary<String, String>]()
        for framework in info.frameworks {
            ret.append(["name": framework.name,
                        "version": framework.version])
        }

        return ret;
    }

    func jsonAppPlatforms(_ info: AppInfo) -> [Dictionary<String, String>] {
        var ret = [Dictionary<String, String>]()
        for platform in info.platforms {
            ret.append(["name": platform.name,
                        "version": platform.version])
        }

        return ret;
    }

    func jsonAppInfo(_ info: AppInfo) -> [String : Any] {
        let appUrl = AppManager.getShareInstance().getAppUrl(info);
        let dataUrl = AppManager.getShareInstance().getDataUrl(info.app_id);
        return [
            "id": info.app_id,
            "version": info.version,
            "versionCode": info.version_code,
            "name": info.name,
            "shortName": info.short_name,
            "description": info.desc,
            "startUrl": resetPath(appUrl, info.start_url),
            "startVisible": info.start_visible,
            "icons": jsonAppIcons(info),
            "authorName": info.author_name,
            "authorEmail": info.author_email,
            "defaultLocale": info.default_locale,
            "category": info.category,
            "keyWords": info.key_words,
            "plugins": jsonAppPlugins(info.plugins),
            "urls": jsonAppUrls(info.urls),
            "backgroundColor": info.background_color,
            "themeDisplay": info.theme_display,
            "themeColor": info.theme_color,
            "themeFontName": info.theme_font_name,
            "themeFontColor": info.theme_font_color,
            "installTime": info.install_time,
            "builtIn": info.built_in,
            "remote": info.remote,
            "appPath": appUrl,
            "dataPath": dataUrl,
            "locales": jsonAppLocales(info),
            "frameworks": jsonAppFrameworks(info),
            "platforms": jsonAppPlatforms(info),
            ] as [String : Any]
    }

    @objc func getInfo(_ command: CDVInvokedUrlCommand) {
        let info = AppManager.getShareInstance().getAppInfo(self.appId!);

        if (info != nil) {
           self.success(command, retAsDict: jsonAppInfo(info!));
        }
        else {
            self.error(command, "No such app!");
        }
    }

    @objc func getAppInfo(_ command: CDVInvokedUrlCommand) {
        let appId = command.arguments[0] as? String ?? ""

        let info = AppManager.getShareInstance().getAppInfo(appId);

        if (info != nil) {
            isChangeIconPath = true;
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
            try AppManager.getShareInstance().sendMessage(toId, type, msg, self.appId!);
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

        if (AppManager.getShareInstance().isLauncher(self.appId)) {
            AppManager.getShareInstance().setLauncherReady();
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

    @objc func sendIntent(_ command: CDVInvokedUrlCommand) {
        let action = command.arguments[0] as? String ?? "";
        let params = command.arguments[1] as? String ?? "";
        let currentTime = Int64(Date().timeIntervalSince1970);
        let options = command.arguments[2] as? [String: Any] ?? nil
        var toId: String? = nil;

        if (options != nil) {
            if (options!["appId"] != nil) {
                toId = options!["appId"] as? String ?? "";
            }
        }

        let info = IntentInfo(action, params, self.appId!, toId, currentTime, command.callbackId);

        do {
            try IntentManager.getShareInstance().doIntent(info);
            let result = CDVPluginResult(status: CDVCommandStatus_NO_RESULT);
            result?.setKeepCallbackAs(true);
            self.commandDelegate.send(result, callbackId: command.callbackId)
        } catch AppError.error(let err) {
            self.error(command, err);
        } catch let error {
            self.error(command, error.localizedDescription);
        }
    }

    @objc func sendUrlIntent(_ command: CDVInvokedUrlCommand) {
        let urlString = command.arguments[0] as? String ?? "";
        let url = URL(string: urlString)

        if (IntentManager.checkTrinityScheme(urlString)) {
            do {
                try IntentManager.getShareInstance().sendIntentByUri(url!, self.appId!);
                self.success(command, "ok");
            } catch AppError.error(let err) {
                self.error(command, err);
            } catch let error {
                self.error(command, error.localizedDescription);
            }
        }
        else if (shouldOpenExternalIntentUrl(urlString)) {
            IntentManager.openUrl(url!);
            self.success(command, "ok");
        }
        else {
            self.error(command, "Can't access this url: " + urlString);
        }
    }

    @objc func sendIntentResponse(_ command: CDVInvokedUrlCommand) {
//        let action = command.arguments[0] as? String ?? "";
        let result = command.arguments[1] as? String ?? "";
        let intentId = command.arguments[2] as? Int64 ?? -1
        do {
            try IntentManager.getShareInstance().sendIntentResponse(result, intentId, self.appId!);
            self.success(command, "ok");
        } catch AppError.error(let err) {
            self.error(command, err);
        } catch let error {
            self.error(command, error.localizedDescription);
        }
    }

    @objc func setIntentListener(_ command: CDVInvokedUrlCommand) {
        self.intentCallbackId = command.callbackId;
        // Don't return any result now
        let result = CDVPluginResult(status: CDVCommandStatus_NO_RESULT);
        result?.setKeepCallbackAs(true);
        self.commandDelegate.send(result, callbackId: command.callbackId)
        try? IntentManager.getShareInstance().setIntentReady(self.appId!);
    }

    @objc func hasPendingIntent(_ command: CDVInvokedUrlCommand) {
        let ret = IntentManager.getShareInstance().getIntentCount(self.appId!) != 0;
        self.success(command, ret.description);
    }

    func isIntentReady() -> Bool {
        return (self.intentCallbackId != nil);
    }

    func onReceiveIntent(_ info: IntentInfo) {
        guard self.intentCallbackId != nil else {
            return
        }

        let ret = [
            "action": info.action,
            "params": info.params!,
            "from": info.fromId,
            "intentId": info.intentId,
            ] as [String : Any]
        let result = CDVPluginResult(status: CDVCommandStatus_OK,
                                     messageAs: ret);
        result?.setKeepCallbackAs(true);
        self.commandDelegate?.send(result, callbackId:self.intentCallbackId);
    }

    func onReceiveIntentResponse(_ info: IntentInfo) {
        let ret = [
            "action": info.action,
            "result": info.params!,
            "from": info.fromId
        ]

        let result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: ret);
        result?.setKeepCallbackAs(false);
        self.commandDelegate.send(result, callbackId: info.callbackId)
    }

    @objc func install(_ command: CDVInvokedUrlCommand) {
        var url = command.arguments[0] as? String ?? ""
        let update = command.arguments[1] as? Bool ?? false

        do {
            if (url.hasPrefix("trinity://")) {
                url = try getCanonicalPath(url);
            }
            
            try AppManager.getShareInstance().checkInProtectList(url);
            let info = try AppManager.getShareInstance().install(url, update);

            if (info != nil) {
                self.success(command, retAsDict: jsonAppInfo(info!));
            }
            else {
                self.error(command, "error");
            }
        } catch AppError.error(let err) {
            self.error(command, err);
        } catch let error {
            self.error(command, error.localizedDescription);
        }
    }

    @objc func unInstall(_ command: CDVInvokedUrlCommand) {
        let id = command.arguments[0] as? String ?? ""

        do {
            try AppManager.getShareInstance().unInstall(id, false);
            self.success(command, id);
        } catch AppError.error(let err) {
            self.error(command, err);
        } catch let error {
            self.error(command, error.localizedDescription);
        }
    }

    @objc func getAppInfos(_ command: CDVInvokedUrlCommand) {
        let appInfos = AppManager.getShareInstance().getAppInfos();
        var infos = [String: Any]()
        isChangeIconPath = true;

        for (key, info) in appInfos {
            infos[key] = jsonAppInfo(info);
        }

        let list = AppManager.getShareInstance().getAppIdList();
        let ret = ["infos": infos,
                   "list": filterList(list),
            ] as [String : Any];

        self.success(command, retAsDict: ret);
    }

    @objc func setPluginAuthority(_ command: CDVInvokedUrlCommand) {
        let id = command.arguments[0] as? String ?? ""
        let plugin = command.arguments[1] as? String ?? ""
        let authority = command.arguments[2] as? Int ?? 0

        if (id == "") {
            self.error(command, "Invalid id.")
            return
        }

        do {
            try AppManager.getShareInstance().setPluginAuthority(id, plugin, authority);
            self.success(command, "ok");
        } catch AppError.error(let err) {
            self.error(command, err);
        } catch let error {
            self.error(command, error.localizedDescription);
        }
    }

    @objc func setUrlAuthority(_ command: CDVInvokedUrlCommand) {
        let id = command.arguments[0] as? String ?? ""
        let url = command.arguments[1] as? String ?? ""
        let authority = command.arguments[1] as? Int ?? 0

        if (id == "") {
            self.error(command, "Invalid id.")
            return
        }

        do {
            try AppManager.getShareInstance().setUrlAuthority(id, url, authority);
            self.success(command, "ok");
        } catch AppError.error(let err) {
            self.error(command, err);
        } catch let error {
            self.error(command, error.localizedDescription);
        }
    }

    func filterList(_ list: [String]) -> [String] {
        var ret = [String]();
        for id in list {
            if (id != "launcher") {
                ret.append(id);
            }
        }
        return ret;
    }

    @objc(getRunningList:)
    func getRunningList(_ command: CDVInvokedUrlCommand) {
        let list = AppManager.getShareInstance().getRunningList();
        self.success(command, retAsArray: filterList(list));
    }

    @objc(getAppList:)
    func getAppList(_ command: CDVInvokedUrlCommand) {
        let list = AppManager.getShareInstance().getAppIdList();
        self.success(command, retAsArray: filterList(list));
    }

    @objc(getLastList:)
    func getLastList(_ command: CDVInvokedUrlCommand) {
        let list = AppManager.getShareInstance().getLastList();
        self.success(command, retAsArray: filterList(list));
    }

    func alertDialog(_ command: CDVInvokedUrlCommand, _ icon: Int,
                     _ cancel: Bool  = false) {

        let title = command.arguments[0] as? String ?? ""
        let msg = command.arguments[1] as? String ?? ""

        func doOKHandler(alerAction:UIAlertAction) {
            if (cancel) {
                self.success(command, "ok");
            }
        }

        func doCancelHandler(alerAction:UIAlertAction) {

        }

        let alertController = UIAlertController(title: title,
                                        message: msg,
                                        preferredStyle: UIAlertController.Style.alert)
        if (cancel) {
            let cancelAlertAction = UIAlertAction(title: "Cancel", style:
                UIAlertAction.Style.cancel, handler: doCancelHandler)
            alertController.addAction(cancelAlertAction)
        }
        let sureAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: doOKHandler)
        alertController.addAction(sureAlertAction)

        DispatchQueue.main.async {
            AppManager.getShareInstance().mainViewController.present(alertController, animated: true, completion: nil)
        }
    }

    @objc func alertPrompt(_ command: CDVInvokedUrlCommand) {
        alertDialog(command, 0);
    }

    @objc func infoPrompt(_ command: CDVInvokedUrlCommand) {
        alertDialog(command, 1);
    }

    @objc func askPrompt(_ command: CDVInvokedUrlCommand) {
        alertDialog(command, 0, true);
    }

    @objc func setVisible(_ command: CDVInvokedUrlCommand) {
        var visible = command.arguments[0] as? String ?? "show"

        if (visible != "hide") {
            visible = "show";
        }

        do {
            let appManager = AppManager.getShareInstance();

            appManager.setAppVisible(self.appId, visible);
            if (visible == "show") {
                try appManager.start(self.appId);
            }
            else {
                try appManager.loadLauncher();
            }

            try appManager.sendLauncherMessage(AppManager.MSG_TYPE_INTERNAL,
            "{\"visible\": \"" + visible + "\"}", self.appId);
            self.success(command, "ok");
        } catch AppError.error(let err) {
            self.error(command, err);
        } catch let error {
            self.error(command, error.localizedDescription);
        }
    }

    @objc func getSetting(_ command: CDVInvokedUrlCommand) {
        let key = command.arguments[0] as? String ?? "";

        let dbAdapter = AppManager.getShareInstance().getDBAdapter();

        do {
            let value = try dbAdapter.getSetting(self.appId, key)
            if (value != nil) {
                self.success(command, retAsDict: value!);
            }
            else {
                self.error(command, "'\(key)' isn't exist value.");
            }
        } catch AppError.error(let err) {
            self.error(command, err);
        } catch let error {
            self.error(command, error.localizedDescription);
        }
    }

    @objc func getSettings(_ command: CDVInvokedUrlCommand) {
        let dbAdapter = AppManager.getShareInstance().getDBAdapter();

        do {
            let values = try dbAdapter.getSettings(self.appId);
            self.success(command, retAsDict: values);
        } catch AppError.error(let err) {
            self.error(command, err);
        } catch let error {
            self.error(command, error.localizedDescription);
        }
    }

    @objc func setSetting(_ command: CDVInvokedUrlCommand) {
        let key = command.arguments[0] as? String ?? "";
        let value = command.arguments[1] as? Any ?? nil;
        let dbAdapter = AppManager.getShareInstance().getDBAdapter();

        do {
            try dbAdapter.setSetting(self.appId, key, value);
            self.success(command, "ok");
        } catch AppError.error(let err) {
            self.error(command, err);
        } catch let error {
            self.error(command, error.localizedDescription);
        }
    }

    @objc func getPreference(_ command: CDVInvokedUrlCommand) {
        let key = command.arguments[0] as? String ?? "";

        do {
            let value = try PreferenceManager.getShareInstance().getPreference(key);
                self.success(command, retAsDict: value);
        } catch AppError.error(let err) {
            self.error(command, err);
        } catch let error {
            self.error(command, error.localizedDescription);
        }
    }

    @objc func getPreferences(_ command: CDVInvokedUrlCommand) {
        do {
            let values = try PreferenceManager.getShareInstance().getPreferences();
            self.success(command, retAsDict: values);
        } catch AppError.error(let err) {
            self.error(command, err);
        } catch let error {
            self.error(command, error.localizedDescription);
        }
    }

    @objc func setPreference(_ command: CDVInvokedUrlCommand) {
        let key = command.arguments[0] as? String ?? "";
        let value = command.arguments[1] as? Any;

        do {
            try PreferenceManager.getShareInstance().setPreference(key, value);
            self.success(command, "ok");
        } catch AppError.error(let err) {
            self.error(command, err);
        } catch let error {
            self.error(command, error.localizedDescription);
        }
    }

    @objc func resetPreferences(_ command: CDVInvokedUrlCommand) {
        let dbAdapter = AppManager.getShareInstance().getDBAdapter();

        do {
            try dbAdapter.resetPreferences();
            self.success(command, "ok");
        } catch AppError.error(let err) {
            self.error(command, err);
        } catch let error {
            self.error(command, error.localizedDescription);
        }
    }

    @objc func broadcastMessage(_ command: CDVInvokedUrlCommand) {
        let type = command.arguments[0] as? Int ?? 0;
        let msg = command.arguments[1] as? String ?? "";
        AppManager.getShareInstance().broadcastMessage(type, msg, self.appId);
        self.success(command, "ok");
    }
 }
