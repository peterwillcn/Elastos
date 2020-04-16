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

 //For publish config
@objc(ConfigManager)
class ConfigManager: NSObject {
    private static var configManager: ConfigManager?;
    private var configPreferences: [String: Any]?;

    override init() {
        super.init();
        ConfigManager.configManager = self;
        parseConfig();
    }

    @objc static func getShareInstance() -> ConfigManager {
        if (ConfigManager.configManager == nil) {
            ConfigManager.configManager = ConfigManager();
        }
        return ConfigManager.configManager!;
    }
    
    @objc func parseConfig() {
        do {
            let path = getAbsolutePath("www/config/config.json");
            configPreferences = try getJsonFromFile(path);
        }
        catch let error {
            print("Parse config.json error: \(error)");
        }
        
    }

    @objc func getStringValue(_ key: String, _ defaultValue: String) -> String {
        guard configPreferences != nil else {
            return defaultValue;
        }
        
        var ret = configPreferences![key] as? String;
        if (ret == nil) {
            ret = defaultValue;
        }
        return ret!;
    }

    @objc func getBoolValue(_ key: String, _ defaultValue: Bool) -> Bool {
        guard configPreferences != nil else {
            return defaultValue;
        }
        
        var ret = configPreferences![key] as? Bool;
        if (ret == nil) {
            ret = defaultValue;
        }
        return ret!;
    }

    func getStringArrayValue(_ key: String, _ defaultValue: [String]) -> [String] {
        guard configPreferences != nil else {
            return defaultValue;
        }
        
        var ret = configPreferences![key] as? [String];
        if (ret == nil) {
            ret = defaultValue;
        }
        return ret!;
    }
    
    func stringArrayContains(_ key: String, _ value: String) -> Bool {
        let array = getStringArrayValue(key, [String]());
        return array.contains(value);
    }
    
}

