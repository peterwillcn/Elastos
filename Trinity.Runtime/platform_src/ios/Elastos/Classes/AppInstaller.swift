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
 
 class AppInstaller {
    
    let pluginWhitelist = [
        "device",
        "networkstatus",
        "splashscreen",
        ];
    
    let urlWhitelist = [
        "http://www.elastos.org/*",
        ];
    
    var appPath: String = "";
    var dataPath: String = "";
    var dbAdapter: ManagerDBAdapter;
    
    init(_ appPath: String, _ dataPath: String, _ dbAdapter: ManagerDBAdapter) {
        self.appPath = appPath;
        self.dataPath = dataPath;
        self.dbAdapter = dbAdapter;
    }
    
    func unpackZip(_ srcZip: String, _ destPath: String) -> Bool {
        return SSZipArchive.unzipFile(atPath: srcZip, toDestination: destPath);
    }
    
    func deleteAllFiles(_ path: String) throws {
        let fileManager = FileManager.default;
        try fileManager.removeItem(atPath: path)
    }
    
    func copyAssetsFolder(_ src: String, _ dest: String) throws {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: dest){
            try fileManager.removeItem(atPath: dest)
        }
        
        try fileManager.copyItem(atPath: src, toPath: dest)
    }
    
    func  install(_ appManager: AppManager, _ url: String) throws -> AppInfo? {
        var zipPath = url;
        if (url.hasPrefix("assets://")) {
            zipPath = getAssetsPath(url);
        }
        else if (url.hasPrefix("file://")) {
            let index = url.index(url.startIndex, offsetBy: 7)
            zipPath = String(url[index ..< url.endIndex]);
        }

        let temp = "tmp_" + UUID().uuidString
        let temPath = appPath + temp;
    
        if (!unpackZip(zipPath, temPath)) {
            throw AppError.error("UnpackZip fail!");
        }
        
        let fileManager = FileManager.default;
        let ret = fileManager.fileExists(atPath: temPath + "/manifest.json")
        guard ret else {
            try deleteAllFiles(temPath);
            throw AppError.error("manifest.json no exist!");
        }
        
        let info = try parseManifest(temPath + "/manifest.json");
        guard (info != nil && info!.app_id != "" && info!.app_id != "launcher"
                && appManager.getAppInfo(info!.app_id) == nil) else {
            try deleteAllFiles(temPath);
            throw AppError.error("App alreadey exist!");
        }
        
        let path = appPath + info!.app_id;
        if (fileManager.fileExists(atPath: path)) {
            try deleteAllFiles(path);
        }
        
        try fileManager.moveItem(atPath: temPath, toPath: path);
//            let dirs = try! fileManager.contentsOfDirectory(atPath: path);

        info!.built_in = false;
        try appManager.dbAdapter.addAppInfo(info!);
        return info!;
    }
    
    func unInstall(_ info: AppInfo?) throws {
        guard info != nil else {
            throw AppError.error("No such app!");
        }
        
        guard !info!.built_in else {
            throw AppError.error("App is a built in!");
        }
        
        let path = self.dataPath + info!.app_id
        try dbAdapter.removeAppInfo(info!);
        try deleteAllFiles(path);
    }
    
    private func isAllowPlugin(_ plugin: String) -> Bool {
        for item in pluginWhitelist {
            if (item == plugin) {
                return true;
            }
        }
        return false;
    }
    
    private func isAllowUrl(_ url: String) -> Bool {
        for item in urlWhitelist {
            if (item == url) {
                return true;
            }
        }
        return false;
    }
    
    private func getMustStrValue(_ json: [String: Any], _ name: String) throws -> String {
        let value = json[name] as? String;
        if (value != nil) {
            return value!
        }
        else {
            throw AppError.error("Parse Manifest.json error: '\(name)' no exist!");
        }
    }
    
    func parseManifest(_ path: String, _ launcher:Bool = false) throws -> AppInfo? {
        let appInfo = AppInfo();
        let url = URL.init(fileURLWithPath: path)
        var value: String?;

        let data = try Data(contentsOf: url);
        let json = try JSONSerialization.jsonObject(with: data,
                                                    options: []) as! [String: Any];
        
        //Must
        appInfo.app_id = try getMustStrValue(json, "id");
        appInfo.version = try getMustStrValue(json, "version");
        appInfo.name = try getMustStrValue(json, "name");
        appInfo.start_url = try getMustStrValue(json, "start_url");
        let range = appInfo.start_url.range(of: "://");
        if range != nil{
            appInfo.remote = true;
        }
        else {
            appInfo.remote = false;
        }

        let icons = json["icons"] as? [Dictionary<String, String>];
        if !launcher {
            if icons != nil {
                for icon in icons! {
                    let src = icon["src"];
                    let sizes = icon["sizes"];
                    let type = icon["type"];
                    appInfo.addIcon(src!, sizes!, type!);
                }
            }
            else {
                throw AppError.error("Parse Manifest.json error: 'icons' no exist!");
            }
        }
        
        //Optional
        value = json["short_name"] as? String;
        if value != nil {
            appInfo.short_name = value!;
        }
        
        value = json["description"] as? String;
        if value != nil {
            appInfo.desc = value!;
        }
        
        value = json["default_locale"] as? String;
        if value != nil {
            appInfo.default_locale = value!;
        }
        
        let author = json["author"] as? [String: Any];
        if author != nil {
            value = author!["name"] as? String;
            if value != nil {
                appInfo.author_name = value!;
            }
            value = author!["email"] as? String;
            if value != nil {
                appInfo.author_email = value!;
            }
        }
        
        var authority = AppInfo.AUTHORITY_NOINIT;
        let plugins = json["plugins"] as? [String];
        if (plugins != nil) {
            for plugin in plugins! {
                authority = AppInfo.AUTHORITY_NOINIT;
                let pluginName = plugin.lowercased();
                if (isAllowPlugin(pluginName)) {
                    authority = AppInfo.AUTHORITY_ALLOW;
                }
                appInfo.addPlugin(pluginName, authority);
            }
        }
        
        let urls = json["urls"] as? [String];
        if (urls != nil) {
            for url in urls! {
                authority = AppInfo.AUTHORITY_NOINIT;
                let urlString = url.lowercased();
                if (isAllowUrl(urlString)) {
                    authority = AppInfo.AUTHORITY_ALLOW;
                }
                appInfo.addUrl(urlString, authority);
            }
        }
        
        
        value = json["background_color"] as? String;
        if value != nil {
            appInfo.background_color = value!;
        }
        
        let theme = json["theme"] as? [String: Any];
        if (theme != nil) {
            value = theme!["display"] as? String;
            if value != nil {
                appInfo.theme_display = value!;
            }
            value = theme!["color"] as? String;
            if value != nil {
                appInfo.theme_color = value!;
            }

            value = theme!["font_name"] as? String;
            if value != nil {
                appInfo.theme_font_name = value!;
            }

            value = theme!["font_color"] as? String;
            if value != nil {
                appInfo.theme_font_color = value!;
            }
        }
        
        appInfo.install_time = Int64(Date().timeIntervalSince1970);
        appInfo.launcher = launcher;
        
        let fileManager = FileManager.default
        if (!fileManager.fileExists(atPath: dataPath + appInfo.app_id)) {
            do {
                try fileManager.createDirectory(atPath: dataPath + appInfo.app_id, withIntermediateDirectories: true, attributes: nil)
            }
            catch let error {
                print("Make dataPath error: \(error)");
            }
        }

        return appInfo;
    }
 }
 
