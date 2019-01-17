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
    
    func deleteAllFiles(_ path: String) {
        let fileManager = FileManager.default;
        do {
            try fileManager.removeItem(atPath: path)
        } catch {
            print("delete false")
        }
    }
    
    func  install(_ appManager: AppManager, _ url: String) -> AppInfo? {
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
    
        if (unpackZip(zipPath, temPath)) {
            let fileManager = FileManager.default;
            let ret = fileManager.fileExists(atPath: temPath + "/manifest.json")
            guard ret else {
                deleteAllFiles(temPath);
                return nil;
            }
            
            let info = parseManifest(temPath + "/manifest.json");
            guard (info != nil && info!.id != "" && info!.id != "launcher"
                    && appManager.getAppInfo(info!.id) == nil) else {
                deleteAllFiles(temPath);
                return nil;
            }
            
            let path = appPath + info!.id;
            if (fileManager.fileExists(atPath: path)) {
                deleteAllFiles(path);
            }
            
            do {
                try fileManager.moveItem(atPath: temPath, toPath: path);
            }
            catch let error {
                print("Install rename dir error: \(error)");
            }
//            let dirs = try! fileManager.contentsOfDirectory(atPath: path);

            info!.built_in = false;
            appManager.dbAdapter.addAppInfo(info!);
            return info;
        }
        return nil;
    }
    
    func unInstall(_ info: AppInfo?) -> Bool {
        guard info != nil && !info!.built_in else {
            return false;
        }
        let path = self.dataPath + info!.id
        dbAdapter.removeAppInfo(info!);
        deleteAllFiles(path);
        return true;
    }
    
    private func isAllowPlugin(_ pluginName: String) -> Bool {
        let name = pluginName.lowercased();
        for item in pluginWhitelist {
            if (item == name) {
                return true;
            }
        }
        return false;
    }
    
    private func isAllowUrl(_ urlString: String) -> Bool {
        let url = urlString.lowercased();
        for item in urlWhitelist {
            if (item == url) {
                return true;
            }
        }
        return false;
    }
    
    func parseManifest(_ path: String) -> AppInfo? {
        let appInfo = AppInfo();
        let url = URL.init(fileURLWithPath: path)

        do {
            let data = try Data(contentsOf: url);
            let json = try JSONSerialization.jsonObject(with: data,
                                                        options: []) as! [String: Any];
            appInfo.id = json["id"] as! String;
            appInfo.version = json["version"] as! String;
            appInfo.name = json["name"] as! String;
            appInfo.short_name = json["short_name"] as! String;
            appInfo.desc = json["description"] as! String;
            appInfo.start_url = json["start_url"] as! String;

            let icons = json["icons"] as! [Dictionary<String, String>];
            for icon in icons {
                let src = icon["src"];
                let sizes = icon["sizes"];
                let type = icon["type"];
                appInfo.addIcon(src!, sizes!, type!);
            }
            
            appInfo.default_locale = json["default_locale"] as! String;
            let author = json["author"] as! [String: Any];
            appInfo.author_name = author["name"] as! String;
            appInfo.author_email = author["email"] as! String;
            
            let plugins = json["plugins"] as! [String];
            var authority = AppInfo.AUTHORITY_NOINIT;
            for plugin in plugins {
                authority = AppInfo.AUTHORITY_NOINIT;
                if (isAllowPlugin(plugin)) {
                    authority = AppInfo.AUTHORITY_ALLOW;
                }
                appInfo.addPlugin(plugin, authority);
            }
            
            let urls = json["urls"] as! [String];
            for url in urls {
                authority = AppInfo.AUTHORITY_NOINIT;
                if (isAllowUrl(url)) {
                    authority = AppInfo.AUTHORITY_ALLOW;
                }
                appInfo.addUrl(url, authority);
            }
            
            appInfo.background_color =  json["background_color"] as! String;
            appInfo.theme_display =  json["theme_display"] as! String;
            appInfo.theme_color =  json["theme_color"] as! String;
        }
        catch let error {
            print("Parse Manifest.json error: \(error)");
        }

        return appInfo;
    }
 }
 
