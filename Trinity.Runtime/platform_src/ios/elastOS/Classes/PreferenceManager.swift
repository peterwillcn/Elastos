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

//For system preference
 @objc(PreferenceManager)
 class PreferenceManager: NSObject {
    private static var preferenceManager: PreferenceManager?;
    private var defaultPreferences = [String: Any]();
    let dbAdapter: ManagerDBAdapter;
    public var versionChanged: Bool = false;

    override init() {
        dbAdapter = AppManager.getShareInstance().getDBAdapter();
        super.init();

        parsePreferences();
        PreferenceManager.preferenceManager = self;

        // Make some services ready
        let darkMode = getBoolValue("ui.darkmode", false)
        prepareUIStyling(useDarkMode: darkMode)
    }

    @objc static func getShareInstance() -> PreferenceManager {
        if (PreferenceManager.preferenceManager == nil) {
            PreferenceManager.preferenceManager = PreferenceManager();
        }
        return PreferenceManager.preferenceManager!;
    }

    func parsePreferences() {
        do {
            let path = getAbsolutePath("www/config/preferences.json");
            defaultPreferences = try getJsonFromFile(path);
            defaultPreferences["version"] = try getNativeSystemVersion();
        }
        catch let error {
            print("Parse preferences.json error: \(error)");
        }
    }

    private func anyToString(_ value: Any) -> String? {
        if (value is String) {
            return (value as! String);
        }
        else if (value is Bool) {
            return (value as! Bool).toString();
        }
        else if (value is [String]) {
            return (value as! [String]).description
        }
        else if (value is [String: Any]) {
            return (value as! [String: Any]).toString()!;
        }
        else if (value is Int) {
            return String(value as! Int)
        }
        else if (value is Double) {
            return String(value as! Double)
        }
        else if (value is NSNull) {
            return "null"
        }

        return nil;
    }

    private func getDefaultValue(_ key: String) -> Any? {
        let value = defaultPreferences[key];
        return value;
    }

    func getPreference(_ key: String) throws -> [String: Any] {
        let defaultValue = getDefaultValue(key);
        guard defaultValue != nil else {
            throw AppError.error("getPreference error: no such preference!");
        }

        var ret = try dbAdapter.getPreference(key);
        if (ret == nil) {
            ret = ["key": key, "value": defaultValue!] as [String : Any];
        }

        if (key == "locale.language" && ret!["value"] as? String == "native system") {
            ret![key] = getCurrentLanguage();
        }

        return ret!;
    }

    func getPreferences() throws -> [String: Any] {
        var values = try dbAdapter.getPreferences();
        for (key, value) in defaultPreferences {
            if (values[key] == nil) {
                values[key] = value;
            }
            if (key == "locale.language" && (values[key] as! String) == "native system") {
                values[key] = getCurrentLanguage();
            }
        }

        return values;
    }

    static let refuseSetPreferences = [
        "version"
    ];

    private func isAllowSetPreference(_ key: String) -> Bool {
        if (!PreferenceManager.refuseSetPreferences.contains(key)) {
            return true;
        }
        else {
            return false;
        }
    }

    @objc func setPreference(_ key: String, _ value: Any?) throws {
        if (!isAllowSetPreference(key)) {
            throw AppError.error("setPreference error: \(key) can't be set!");
        }

        let defaultValue = getDefaultValue(key);
        guard defaultValue != nil else {
            throw AppError.error("setPreference error: no such preference!");
        }

        try dbAdapter.setPreference(key, value);
        if (key == "developer.mode") {
            var isMode = false;
            if (value != nil && (value is Bool)) {
                isMode = value! as! Bool;
            }

            if (isMode) {
                CLIService.getShareInstance().start();
            }
            else {
                CLIService.getShareInstance().stop();
            }
        }
        else if (key == "ui.darkmode") {
            prepareUIStyling(useDarkMode: value as! Bool)
        }

        let dict = ["action": "preferenceChanged", "data": ["key": key, "value": value]] as [String : Any];
        AppManager.getShareInstance().broadcastMessage(AppManager.MSG_TYPE_IN_REFRESH, dict.toString()!, "system");
    }

    func getDeveloperMode() -> Bool {
        return getBoolValue("developer.mode", false)
    }

    func setDeveloperMode(_ value: Bool) {
        try? setPreference("developer.mode", value);
    }

    func getCurrentLocale() throws -> String {
        let value = try getPreference("locale.language");
        var ret = value["value"] as! String;
        if (ret == "native system") {
            ret = getCurrentLanguage();
        }
        return ret;
    }

    func setCurrentLocale(_ code: String) throws {
        let dict = ["action": "currentLocaleChanged", "data": code] as [String : Any];
        try setPreference("locale.language", code);
        AppManager.getShareInstance().broadcastMessage(AppManager.MSG_TYPE_IN_REFRESH, dict.toString()!, "launcher");
    }

    func getNativeSystemVersion() throws -> String {
        let infoDictionary = Bundle.main.infoDictionary
        let majorVersion = infoDictionary? ["CFBundleShortVersionString"] as? String;
        
        //check version
        let json = try dbAdapter.getPreference("version");
        var version: String? = nil
        if (json != nil) {
            if !(json!["value"] is NSNull) {
                version = anyToString(json!["value"]!);
            }
        }

        if (json == nil || majorVersion != version) {
            try dbAdapter.setPreference("version", majorVersion);
            versionChanged = true;
        }

        return majorVersion!;
    }
    
    func getVersion() -> String {
        var version = "";
        if (defaultPreferences["version"] != nil) {
            version = anyToString(defaultPreferences["version"] as Any)!;
        }
        return version;
    }

    @objc func getWalletNetworkType() -> String {
        return getStringValue("chain.network.type", "MainNet");
     }

    @objc func getWalletNetworkConfig() -> String {
        return getStringValue("chain.network.config", "");
     }

    @objc func getDIDResolver() -> String {
       return getStringValue("did.resolver", "http://api.elastos.io:20606");
    }

    @objc func getStringValue(_ key: String, _ defaultValue: String) -> String {
        var value: String? = nil;
        do {
            let item = try getPreference(key);
            if !(item["value"] is NSNull) {
                value = anyToString(item["value"]!);
            }
        }
        catch let error {
           print("getStringValue \(key) error: \(error)");
        }

        if (value == nil) {
            value = defaultValue;
        }
        return value!;
    }

    @objc func getBoolValue(_ key: String, _ defaultValue: Bool) -> Bool {
        var value: Bool? = nil;
        do {
            let item = try getPreference(key);
            if (!(item["value"] is NSNull) && item["value"] is Bool) {
                value = item["value"] as? Bool;
            }
        }
        catch let error {
           print("getStringValue \(key) error: \(error)");
        }

        if (value == nil) {
            value = defaultValue;
        }
        return value!;
    }

    func getStringArrayValue(_ key: String, _ defaultValue: [String]) -> [String] {
        var value: [String]? = nil;
        do {
            let item = try getPreference(key);
            if (!(item["value"] is NSNull) && item["value"] is [String]) {
                value = item["value"] as? [String];
            }
        }
        catch let error {
           print("getStringValue \(key) error: \(error)");
        }

        if (value == nil) {
            value = defaultValue;
        }
        return value!;
    }

    private func prepareUIStyling(useDarkMode: Bool) {
        UIStyling.prepare(useDarkMode: useDarkMode)
    }
}

