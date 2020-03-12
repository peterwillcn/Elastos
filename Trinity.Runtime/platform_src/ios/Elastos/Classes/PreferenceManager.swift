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
class PreferenceManager {
    private static var preferenceManager: PreferenceManager?;
    private var defaultPreferences = [String: String]();
    let dbAdapter: ManagerDBAdapter;

    init() {
        dbAdapter = AppManager.getShareInstance().getDBAdapter();
        PreferenceManager.preferenceManager = self;
        parsePreferences();
    }

    static func getShareInstance() -> PreferenceManager {
        if (PreferenceManager.preferenceManager == nil) {
            PreferenceManager.preferenceManager = PreferenceManager();
        }
        return PreferenceManager.preferenceManager!;
    }

    func parsePreferences() {
        do {
            let path = getAbsolutePath("www/config/preferences.json");
            let dict = try getJsonFromFile(path);
            for (key, value) in dict {
                defaultPreferences[key] = anyToString(value);
                if (defaultPreferences[key] == nil) {
                    print("Parse preferences.json error: \(key)'s value Type can't resolve");
                }
            }
        }
        catch let error {
            print("Parse preferences.json error: \(error)");
        }
    }

    private func anyToString(_ value: Any) -> String? {
//        return "\(value)"; //Bool will be return 0 or 1
        
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

        return nil;
    }

    private func getDefaultValue(_ key: String) -> String? {
        let value = defaultPreferences[key];
        return value;
    }

    func getPreference(_ key: String) throws -> String {
        let defaultValue = getDefaultValue(key);
        guard defaultValue != nil else {
            throw AppError.error("getPreference error: no such preference!");
        }

        var value = try dbAdapter.getPreference(key);
        if (value == nil) {
            value = defaultValue!;
        }
        else if (value == "native system") {
            value = getCurrentLanguage();
        }
        
        return value!;
    }

    func getPreferences() throws -> [String: String] {
        var values = try dbAdapter.getPreferences();
        for (key, value) in defaultPreferences {
            if (values[key] == nil) {
                values[key] = value;
            }
        }
    
        return values;
    }

    @objc func setPreference(_ key: String, _ value: String?) throws {
        let defaultValue = getDefaultValue(key);
        guard defaultValue != nil else {
            throw AppError.error("setPreference error: no such preference!");
        }

        try dbAdapter.setPreference(key, value);
        if (key == "developer.mode") {
            var isMode = false;
            if (value != nil) {
                isMode = value!.toBool();
            }

            if (isMode) {
                CLIService.getShareInstance().start();
            }
            else {
                CLIService.getShareInstance().stop();
            }
        }
        
        AppManager.getShareInstance().broadcastMessage(AppManager.MSG_TYPE_IN_REFRESH,
                         "{\"action\":\"preferenceChanged\", \"" + key + "\":\""
                         + value! + "\"}", "system");
    }

    func getDeveloperMode() -> Bool {
        let value = try? getPreference("developer.mode").toBool();
        guard value != nil else {
            return false;
        }
        return value!;
    }

    func setDeveloperMode(_ value: Bool) {
        try? setPreference("developer.mode", value.toString());
    }

    func getCurrentLocale() throws -> String {
        var value = try getPreference("locale.language");
        if (value == "native system") {
            value = getCurrentLanguage();
        }
        return value;
    }

    func setCurrentLocale(_ code: String) throws {
        try setPreference("locale.language", code);
        AppManager.getShareInstance().broadcastMessage(AppManager.MSG_TYPE_IN_REFRESH,
                         "{\"action\":\"currentLocaleChanged\", \"code\":\""
                         + code + "\"}", "launcher");
    }
}

