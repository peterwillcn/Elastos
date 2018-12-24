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
            let index = url.index(url.startIndex, offsetBy: 9)
            let substr = url[index ..< url.endIndex];
            zipPath = appManager.getAbsolutePath(String(substr));
        }

        let temp = "tmp_" + UUID().uuidString
        let temPath = appPath + temp;
    
        if (unpackZip(zipPath, temPath)) {
            let parser = AppXmlParser();
            

            let fileManager = FileManager.default;
            let ret = fileManager.fileExists(atPath: temPath + "/manifest.xml")
            guard ret else {
                deleteAllFiles(temPath);
                return nil;
            }
            
            let info = parser.parseSettings(temPath + "/manifest.xml");
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
 }
 
