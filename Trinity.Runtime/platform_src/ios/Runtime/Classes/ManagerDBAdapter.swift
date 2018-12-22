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
import RealmSwift
 
 class ManagerDBAdapter {
    let realm: Realm;
    
    init() {
//        var config = Realm.Configuration()
//
////        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(username).realm")
//
//        Realm.Configuration.defaultConfiguration = config
    
        realm = try! Realm()
        print(realm.configuration.fileURL ?? "");

    }
    
    func addAppInfo(_ appInfo: AppInfo) {
        do {
            try realm.write {
                realm.add(appInfo.plugins);
                realm.add(appInfo.urls);
                realm.add(appInfo);
            }
        }
        catch let error {
            print("Database addAppInfo error: \(error)");
        }
    }
    
    func getAppInfo(_ id: String) -> AppInfo? {
        let results = realm.objects(AppInfo.self).filter("id = %@", id);
        guard results.count > 0 else {
            return nil;
        }
        return results[0];
    }
        
    func getAppInfos() -> [AppInfo] {
        let results = realm.objects(AppInfo.self);
        var infos = [AppInfo]();
        for info in results {
            infos.append(info);
        }
        return infos;
    }
    
    func updatePluginAuth(_ item: PluginAuth, _ authority: Int) {
        try! realm.write {
            item.authority = authority;
        }
    }
    
    func updateUrlAuth(_ item: UrlAuth, _ authority: Int) {
        try! realm.write {
            item.authority = authority;
        }
    }
    
    func removeAppInfo(_ info: AppInfo) {
        let plugins = realm.objects(PluginAuth.self).filter("id = %@", info.id);
        let urls = realm.objects(UrlAuth.self).filter("id = %@", info.id);
        
        do {
            try realm.write {
                realm.delete(plugins);
                realm.delete(urls);
                realm.delete(info);
            }
        }
        catch let error {
            print("Database removeAppInfo error: \(error)");
        }
    }

 }
