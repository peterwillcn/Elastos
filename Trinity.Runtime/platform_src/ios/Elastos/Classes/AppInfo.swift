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
 
@objc(AppInfo)
class AppInfo: Object {
    @objc dynamic var id = "";
    @objc dynamic var version = "";
    @objc dynamic var name = "";
    @objc dynamic var short_name = "";
    @objc dynamic var desc = "";
    @objc dynamic var start_url = "";
    @objc dynamic var author_name = "";
    @objc dynamic var author_email = "";
    @objc dynamic var default_locale = "";
    @objc dynamic var background_color = "";
    @objc dynamic var theme_display = "";
    @objc dynamic var theme_color = "";
    @objc dynamic var built_in = false;
 
    override class func primaryKey() -> String? {
        return "id"
    }
    
    static let AUTHORITY_NOEXIST = -1;
    static let AUTHORITY_NOINIT = 0;
    static let AUTHORITY_ASK = 1;
    static let AUTHORITY_ALLOW = 2;
    static let AUTHORITY_DENY = 3;
    
    let icons = List<Icon>();
    let plugins = List<PluginAuth>();
    let urls = List<UrlAuth>();
    
    func addIcon(_ src: String, _ sizes: String, _ type: String) {
        let icon = Icon();
        icon.id = self.id;
        icon.src = src.lowercased();
        icon.sizes = sizes.lowercased();
        icon.type = type.lowercased();
        icon.owner = self;
        self.icons.append(icon);
    }
    
    func addPlugin(_ plugin: String, _ authority: Int) {
        let pluginAuth = PluginAuth();
        pluginAuth.id = self.id;
        pluginAuth.plugin = plugin.lowercased();
        pluginAuth.authority = authority;
        pluginAuth.owner = self;
        self.plugins.append(pluginAuth);
    }
    
    func addUrl(_ url: String, _ authority: Int) {
        let urlAuth = UrlAuth();
        urlAuth.id = self.id;
        urlAuth.url = url.lowercased();
        urlAuth.authority = authority;
        urlAuth.owner = self;
        self.urls.append(urlAuth);
    }
 }
 
 @objc(Icon)
 class Icon: Object {
    @objc dynamic var id = "";
    @objc dynamic var src = "";
    @objc dynamic var sizes = "";
    @objc dynamic var type = "";
    
    @objc dynamic var owner: AppInfo?
 }
 
 @objc(PluginAuth)
 class PluginAuth: Object {
    @objc dynamic var id = "";
    @objc dynamic var plugin = "";
    @objc dynamic var authority = AppInfo.AUTHORITY_NOINIT;
    
    @objc dynamic var owner: AppInfo?
 }
 
 @objc(UrlAuth)
 class UrlAuth: Object {
    @objc dynamic var id = "";
    @objc dynamic var url = "";
    @objc dynamic var authority = AppInfo.AUTHORITY_NOINIT;
    
    @objc dynamic var owner: AppInfo?
 }
