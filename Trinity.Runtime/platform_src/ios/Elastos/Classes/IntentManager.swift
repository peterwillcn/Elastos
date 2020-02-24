 /*
  * Copyright (c) 2020 Elastos Foundation
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
import SwiftJWT
import AnyCodable
import PopupDialog


 extension AnyCodable : Claims {}

 class Intent {
    @objc dynamic var app_id = "";
    @objc dynamic var action = "";

    init(_ app_id: String, _ action: String) {
        self.app_id = app_id;
        self.action = action;
    }
 }

 class IntentInfo {
    @objc static let API = 0;
    @objc static let JWT = 1;
    @objc static let URL = 2;
    
    @objc static let REDIRECT_URL = "redirecturl";
    @objc static let CALLBACK_URL = "callbackurl";
    @objc static let REDIRECT_APP_URL = "redirectappurl";
    
    @objc dynamic var action: String;
    @objc dynamic var params: String?;
    @objc dynamic var fromId: String;
    @objc dynamic var toId: String?;
    @objc dynamic var intentId: Int64 = 0;
    @objc dynamic var callbackId: String?;

    @objc dynamic var redirecturl: String?;
    @objc dynamic var callbackurl: String?;
    @objc dynamic var redirectappurl: String?;
    @objc dynamic var aud: String?;
    @objc dynamic var req: String?;
    @objc dynamic var type = API;

    init(_ action: String, _ params: String?, _ fromId: String, _ toId: String?,
         _ intentId: Int64, _ callbackId: String?) {
        self.action = action;
        self.params = params;
        self.fromId = fromId;
        self.toId = toId;
        self.intentId = intentId;
        self.callbackId = callbackId;
    }
 }
 
class IntentPermission {
    let name: String;
    var senderList = [String]();
    var receiverList = [String]();

    init(_ name: String) {
        self.name = name;
    }

    func addSender(_ appId: String) {
        senderList.append(appId);
    }
    
    func addReceiver(_ appId: String) {
        receiverList.append(appId);
    }
    
    func senderIsAllow(_ appId: String) -> Bool {
        return senderList.contains(appId);
    }
    
    func receiverIsAllow(_ appId: String) -> Bool {
        return receiverList.contains(appId);
    }
 }

 class IntentManager {
    static let MAX_INTENT_NUMBER = 20;
    static let JWT_SECRET = "secret";

    private var intentList = [String: [IntentInfo]]();
    private var intentContextList = [Int64: IntentInfo]();
    private var intentIdList = [String: [Int64]]();

    private var permissionList = [String: IntentPermission]();
    
    private let appManager: AppManager;
    private static var intentManager: IntentManager?;

    static let trinitySchemes: [String] = [
            "elastos://",
            "https://scheme.elastos.org/",
    ];

    init() {
        self.appManager = AppManager.getShareInstance();
        do {
            try parseIntentPermission();
        }
        catch let error {
            print("Parse intent.json error: \(error)");
        }
        IntentManager.intentManager = self;
    }

    static func getShareInstance() -> IntentManager {
        if (IntentManager.intentManager == nil) {
            IntentManager.intentManager = IntentManager();
        }
        return IntentManager.intentManager!;
    }
    
    static func checkTrinityScheme(_ url: String) -> Bool {
        for trinityScheme in IntentManager.trinitySchemes {
            if (url.hasPrefix(trinityScheme)) {
                return true;
            }
        }
        return false;
    }
    
    private func putIntentToList(_ app_id: String, _ info: IntentInfo) {
        var infos = intentList[app_id];
        if (infos == nil) {
            infos = [IntentInfo]();
            intentList[app_id] = infos;
        }
        infos!.append(info);
    }

    func setIntentReady(_ id: String)  throws {
        var infos = intentList[id];
        if (infos == nil || infos!.count < 1) {
            return;
        }

        for info in infos! {
            try sendIntent(info);
        }

        infos!.removeAll();
        intentList.removeValue(forKey: id);
    }

    func getIntentCount(_ id: String) ->Int {
        let infos = intentList[id];
        if ((infos == nil) || (infos!.count < 1)) {
            return 0;
        }

        return infos!.count;
    }
    
    //TODO:: synchronized
    private func putIntentContext(_ info: IntentInfo) {
        var intentInfo = intentContextList[info.intentId];
        while (intentInfo != nil) {
            info.intentId += 1;
            intentInfo = intentContextList[info.intentId];
        }

        intentContextList[info.intentId] = info;
        var ids = intentIdList[info.fromId];
        if (ids != nil) {
            while (ids!.count > IntentManager.MAX_INTENT_NUMBER) {
                let intentId = ids![0];
                ids!.remove(at: 0);
                intentContextList.removeValue(forKey: intentId);
            }
        }
        else {
            ids = [Int64]();
            intentIdList[info.fromId] = ids;
        }
        ids!.append(info.intentId);
    }
    
    func getIntentFilter(_ action: String) throws -> [String] {
        let ids = try appManager.dbAdapter.getIntentFilter(action);
        var list = [String]();

        for id in ids {
            if (getIntentReceiverPermission(action, id)) {
                list.append(id);
            }
        }

        if (list.isEmpty) {
            throw AppError.error(action + " isn't support!");
        }

        return list;
    }

    func sendIntent(_ info: IntentInfo) throws {
        if (info.toId == nil) {
            let ids = try getIntentFilter(info.action);

            if (!getIntentSenderPermission(info.action, info.fromId)) {
                throw AppError.error(info.action + " isn't permission!");
            }
            
            // If there is only one application able to handle this intent, we directly use it.
            // Otherwise, we display a prompt so that user can pick the right application.
            if (ids.count == 1) {
                info.toId = ids[0]
                try sendIntentReal(info: info)
            }
            else {
                // More than one possible handler, show a chooser and pass it the selectable apps info.
                var appInfos: [AppInfo] = []
                for id in ids {
                    if let info = appManager.getAppInfo(id) {
                        appInfos.append(info)
                    }
                }
                
                // Create the dialog
                let vc = IntentActionChooserController(nibName: "IntentActionChooserController", bundle: Bundle.main)
                
                vc.setAppManager(appManager: appManager)
                vc.setAppInfos(appInfos: appInfos)
                
                let popup = PopupDialog(viewController: vc)
                let cancelButton = CancelButton(title: "Cancel") {}
                popup.addButtons([cancelButton])
                
                vc.setListener() { selectedAppInfo in
                    popup.dismiss()
                    
                    // Now we know the real app that should receive the intent.
                    info.toId = selectedAppInfo.app_id
                    try! self.sendIntentReal(info: info)
                }
                
                // Present the dialog
                self.appManager.mainViewController.present(popup, animated: true, completion: nil)
            }
        }
    }
    
    private func sendIntentReal(info: IntentInfo) throws {
        let viewController = appManager.viewControllers[info.toId!]
        if (viewController != nil && viewController!.basePlugin!.isIntentReady()) {
            putIntentContext(info);
            try appManager.start(info.toId!);
            viewController!.basePlugin!.onReceiveIntent(info);
        }
        else {
            putIntentToList(info.toId!, info);
            try appManager.start(info.toId!);
        }
    }
    
    func parseJWT(_ jwt: String) throws -> [String: Any]? {
        let jwtDecoder = JWTDecoder.init(jwtVerifier: JWTVerifier.none)
        let data = jwt.data(using: .utf8) ?? nil
        if data == nil {
            throw AppError.error("parseJWT error!");
        }
        let decoded = try? jwtDecoder.decode(JWT<AnyCodable>.self, from: data!)
        if decoded == nil {
            throw AppError.error("parseJWT error!");
        }
        return decoded?.claims.value as? [String: Any]
    }
    
    func getParamsByJWT(_ jwt: String, _ info: IntentInfo) throws {
        var jwtPayload = try parseJWT(jwt);
        if jwtPayload == nil {
            throw AppError.error("getParamsByJWT error!");
        }

        jwtPayload!["type"] = "jwt";
        info.params = jwtPayload!.toString();

        if (jwtPayload!["iss"] != nil) {
            info.aud = (jwtPayload!["iss"] as! String);
        }
        if (jwtPayload!["appid"] != nil) {
            info.req = (jwtPayload!["appid"] as! String);
        }
        if (jwtPayload![IntentInfo.REDIRECT_URL] != nil) {
            info.redirecturl = (jwtPayload![IntentInfo.REDIRECT_URL] as! String);
        }
        else if (jwtPayload![IntentInfo.CALLBACK_URL] != nil) {
            info.callbackurl = (jwtPayload![IntentInfo.CALLBACK_URL] as! String);
        }
        info.type = IntentInfo.JWT;
    }


    func getParamsByUri(_ params: [String: String], _ info: IntentInfo) {
        for (key, value) in params {
            if (key == IntentInfo.REDIRECT_URL) {
                info.redirecturl = value;
            }
            else if (key == IntentInfo.CALLBACK_URL) {
                info.callbackurl = value;
            }
            else if (key == IntentInfo.REDIRECT_APP_URL) {
                info.redirectappurl = value;
            }
            else {
                if (key == "iss") {
                    info.aud = value;
                }
                else if (key == "appid") {
                    info.req = value;
                }
            }
            info.type = IntentInfo.URL;
            info.params = params.toString() ?? "";
        }
    }

    func  parseIntentUri(_ _uri: URL, _ fromId: String) throws -> IntentInfo? {
        var info: IntentInfo? = nil;
        var uri = _uri;
        var url = uri.absoluteString;
        if (url.hasPrefix("elastos://") && !url.hasPrefix("elastos:///")) {
            url = "elastos:///" + (url as NSString).substring(from: 10);
            uri = URL(string: url)!;
        }
        var pathComponents = uri.pathComponents;
        pathComponents.remove(at: 0);
            
        if (pathComponents.count > 0) {
            let action = pathComponents[0];
            let params = uri.parametersFromQueryString;
            if params == nil {
                return nil
            }
            
            let currentTime = Int64(Date().timeIntervalSince1970);

            info = IntentInfo(action, nil, fromId, nil, currentTime, nil);
            if (params!.count > 0) {
                try getParamsByUri(params!, info!);
            }
            else if (uri.pathComponents.count == 2) {
                try getParamsByJWT(pathComponents[1], info!);
            }
        }
        return info;
    }

    func sendIntentByUri(_ uri: URL, _ fromId: String) throws {
        let info = try parseIntentUri(uri, fromId);
        if (info != nil && info!.params != nil) {
            try sendIntent(info!);
        }
    }

    func doIntentByUri(_ uri: URL) {
        do {
            try sendIntentByUri(uri, "system");
        }
        catch let error {
            print("doIntentByUri: \(error)");
        }
    }

    func createJWTResponse(_ info: IntentInfo, _ result: String) throws -> String? {
        
        var claims = result.toDict();
        if (claims == nil) {
            throw AppError.error("createJWTResponse: result error!");
        }
        claims!["req"] = info.req;
        let jwt = JWT<AnyCodable>(claims: AnyCodable(claims!))
        let jwtEncoder = JWTEncoder(jwtSigner: JWTSigner.none)
        let encodedData = try jwtEncoder.encode(jwt)
        return String(data:encodedData, encoding: .utf8)
    }

    func createUrlResponse(_ info: IntentInfo, _ result: String) -> String? {
        var ret = result.toDict();
        if ret == nil {
            ret = [String: Any]();
        }
        if (info.req != nil) {
            ret!["req"] = info.req;
        }
        if (info.aud != nil) {
            ret!["aud"] = info.aud;
        }
        ret!["iat"] = Int64(Date().timeIntervalSince1970)/1000;
        ret!["method"] = info.action;
        return ret!.toString();
    }

    func postCallback(_ name: String, _ value: String, _ callbackurl: String) throws {
        
        let url = URL(string: callbackurl)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: String] = [
            name: value
        ]
        request.httpBody = parameters.percentEncoded()

        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                print("error", error ?? "Unknown error")
//                throw AppError.error("postCallback error:" + error ?? "Unknown error");
                return
            }
            
            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }

            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString!)")

        })

        task.resume()
    }

    func getResultUrl(_ url: String, _ result: String) -> String {
        var param = "?result=";
        if (url.contains("?")) {
            param = "&result=";
        }
        return url + param + result.encodingQuery();
    }

    func sendIntentResponse(_ result: String, _ intentId: Int64, _ fromId: String) throws  {
        let info = intentContextList[intentId];
        if (info == nil) {
            throw AppError.error(String(intentId) + " isn't support!");
        }

        var viewController: TrinityViewController? = nil;
//        if (info!.fromId != nil) {
            //TODO:: findViewControllerById
            viewController = appManager.viewControllers[info!.fromId]
            if (viewController != nil) {
                try appManager.start(info!.fromId);
            }
//        }

        if (info!.type == IntentInfo.API) {
            if (viewController != nil) {
                info!.params = result;
                info!.fromId = fromId;
                viewController!.basePlugin!.onReceiveIntentResponse(info!);
            }
        }
            //TODO::
//        else if (info!.redirectappurl != nil && viewController != nil && viewController!.basePlugin!.isUrlApp()) {
//            let url = getResultUrl(info!.redirectappurl!, result);
//            //TODO::
////            viewController!.loadUrl(url);
//        }
        else {
            var url = info!.redirecturl;
            if (url == nil) {
                url = info!.callbackurl;
            }

            if (url != nil) {
                if (info!.type == IntentInfo.JWT) {
                    let jwt = try createJWTResponse(info!, result);
                    if (IntentManager.checkTrinityScheme(url!)) {
                        url = url! + "/" + jwt!;
                        try sendIntentByUri(URL(string: url!)!, info!.fromId);
                    } else {
                        if (info!.redirecturl != nil) {
                            url = info!.redirecturl! + "/" + jwt!;
                            //TODO::
//                                basePlugin.webView.showWebPage(url, true, false, null);
                        } else if (info!.callbackurl != nil) {
                            try postCallback("jwt", jwt!, info!.callbackurl!);
                        }
                    }
                }
                else if (info!.type == IntentInfo.URL){
                    let ret = createUrlResponse(info!, result);
                    if (IntentManager.checkTrinityScheme(url!)) {
                        url = getResultUrl(url!, ret!);
                        try sendIntentByUri(URL(string: url!)!, info!.fromId);
                    } else {
                        if (info!.redirecturl != nil) {
                            url = getResultUrl(url!, ret!);
                            //TODO::
//                                basePlugin.webView.showWebPage(url, true, false, null);
                        } else if (info!.callbackurl != nil) {
                            try postCallback("result", ret!, info!.callbackurl!);
                        }
                    }
                }
            }

        }

        intentContextList[intentId] = nil;
    }
    
    func parseIntentPermission() throws {
        let path = getAbsolutePath("www/config/permission/intent.json");
        let json = try getJsonFromFile(path) as! [String: [String: [String]]];
        
        for (intent, value) in json {
            let intentPermission = IntentPermission(intent);
            let senders = value["sender"]!;
            for appId in senders {
                intentPermission.addSender(appId);
            }
            
            let receivers = value["receiver"]!;
            for appId in receivers {
                intentPermission.addReceiver(appId);
                permissionList[intent] = intentPermission;
            }
        }
    }
    
    func getIntentSenderPermission(_ intent: String, _ appId: String) ->Bool {
        let intentPermission = permissionList[intent];
        if (intentPermission == nil) {
            return true;
        }

        return intentPermission!.senderIsAllow(appId);
    }

    func getIntentReceiverPermission(_ intent: String, _ appId: String) ->Bool {
        let intentPermission = permissionList[intent];
        if (intentPermission == nil) {
            return true;
        }

        return intentPermission!.receiverIsAllow(appId);
    }

 }

