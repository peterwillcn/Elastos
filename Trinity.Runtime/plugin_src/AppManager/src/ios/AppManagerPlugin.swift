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

@objc(AppManagerPlugin)
class AppManagerPlugin : AppBasePlugin {

    var index: Int = 0;
    var iconList = [String]();

    override init() {
        super.init();
        self.id = "launcher"
    }

    @objc func getIconPath(_ index: Int)  -> String {
        return iconList[index];
    }

    @objc func setCurrentLocale(_ command: CDVInvokedUrlCommand) {
        let code = command.arguments[0] as? String ?? ""
        AppManager.getShareInstance().setCurrentLocale(code);
        self.success(command, "ok");
    }

    @objc override func jsonAppIcons(_ info: AppInfo) -> [Dictionary<String, String>] {
        var ret = [Dictionary<String, String>]()
        let appUrl = AppManager.getShareInstance().getIconPath(info);

        for icon in info.icons {
            let src = "icon:///" + String(index);
            iconList.insert(resetPath(appUrl, icon.src), at: index);
            index += 1;
            ret.append(["src": src,
                        "sizes": icon.sizes,
                        "type": icon.type])
        }

        return ret;
    }


    @objc func install(_ command: CDVInvokedUrlCommand) {
        let url = command.arguments[0] as? String ?? ""
        do {
            let info = try AppManager.getShareInstance().install(url);

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
            try AppManager.getShareInstance().unInstall(id);
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
        iconList = [String]();
        index = 0;

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
        let authority = command.arguments[1] as? Int ?? 0

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

        AppManager.getShareInstance().mainViewController.present(alertController, animated: true, completion: nil)
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
}
