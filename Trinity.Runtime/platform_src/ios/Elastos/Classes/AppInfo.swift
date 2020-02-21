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

@objc(AppInfo)
class AppInfo: NSObject {
    
    @objc static let TID = "tid";
    @objc static let APP_TID = "app_tid";
    @objc static let APP_ID = "app_id";
    @objc static let VERSION = "version";
    @objc static let VERSION_CODE = "version_code";
    @objc static let NAME = "name";
    @objc static let SHORT_NAME = "short_name";
    @objc static let DESCRIPTION = "description";
    @objc static let START_URL = "start_url";
    @objc static let AUTHOR_NAME = "author_name";
    @objc static let AUTHOR_EMAIL = "author_email";
    @objc static let DEFAULT_LOCAL = "default_locale";
    @objc static let BACKGROUND_COLOR = "background_color";
    @objc static let THEME_DISPLAY = "theme_display";
    @objc static let THEME_COLOR = "theme_color";
    @objc static let THEME_FONT_NAME = "theme_font_name";
    @objc static let THEME_FONT_COLOR = "theme_font_color";
    @objc static let INSTALL_TIME = "install_time";
    @objc static let BUILT_IN = "built_in";
    @objc static let REMOTE = "remote";
    @objc static let CATEGORY = "category";
    @objc static let KEY_WORDS = "key_words";
    @objc static let LAUNCHER = "launcher";
    @objc static let LANGUAGE = "language";
    @objc static let ACTION = "action";
    @objc static let START_VISIBLE = "start_visible";
    
    @objc static let SRC = "src";
    @objc static let SIZES = "sizes";
    @objc static let TYPE = "type";
    
    @objc static let PLUGIN = "plugin";
    @objc static let URL = "url";
    @objc static let AUTHORITY = "authority";
    
    @objc dynamic var tid: Int64 = 0;
    @objc dynamic var app_id = "";
    @objc dynamic var version = "";
    @objc dynamic var version_code = 0;
    @objc dynamic var name = "";
    @objc dynamic var short_name = "";
    @objc dynamic var desc = "";
    @objc dynamic var start_url = "";
    @objc dynamic var type = "";
    @objc dynamic var author_name = "";
    @objc dynamic var author_email = "";
    @objc dynamic var default_locale = "";
    @objc dynamic var background_color = "";
    @objc dynamic var theme_display = "";
    @objc dynamic var theme_color = "";
    @objc dynamic var theme_font_name = "";
    @objc dynamic var theme_font_color = "";
    @objc dynamic var install_time: Int64 = 0;
    @objc dynamic var built_in = false;
    @objc dynamic var remote = false;
    @objc dynamic var launcher = false;
    @objc dynamic var category = "";
    @objc dynamic var key_words = "";
    @objc dynamic var start_visible = "";

    @objc static let AUTHORITY_NOEXIST = -1;
    @objc static let AUTHORITY_NOINIT = 0;
    @objc static let AUTHORITY_ASK = 1;
    @objc static let AUTHORITY_ALLOW = 2;
    @objc static let AUTHORITY_DENY = 3;

    @objc var locales = [Locale]();
    @objc var icons = [Icon]();
    @objc var plugins = [PluginAuth]();
    @objc var urls = [UrlAuth]();
    @objc var intents = [UrlAuth]();
    @objc var intentFilters = [IntentFilter]();
    @objc var frameworks = [Framework]();
    @objc var platforms = [Platform]();

    @objc func addLocale(_ language: String, _ name: String, _ short_name: String, _ desc: String, _ author_name: String) {
        locales.append(Locale(language, name, short_name, desc, author_name));
    }
    
    @objc func addIcon(_ src: String, _ sizes: String, _ type: String) {
        icons.append(Icon(src, sizes, type));
    }

    @objc func addPlugin(_ plugin: String, _ authority: Int) {
        plugins.append(PluginAuth(plugin, authority));
    }

    @objc func addUrl(_ url: String, _ authority: Int) {
        urls.append(UrlAuth(url, authority));
    }
    
    @objc func addIntent(_ url: String, _ authority: Int) {
        intents.append(UrlAuth(url, authority));
    }
    
    @objc func addIntentFilter(_ action: String) {
        intentFilters.append(IntentFilter(action));
    }
    
    @objc func addFramework(_ name: String, _ version: String) {
        frameworks.append(Framework(name, version));
    }
    
    @objc func addPlatform(_ name: String, _ version: String) {
        platforms.append(Platform(name, version));
    }
    
    @objc func getFramework(_ name: String) -> Framework? {
        for item in frameworks {
            if (item.name == name) {
                return item;
            }
        }
        return nil;
    }
 }
 
 @objc(Locale)
 class Locale: NSObject {
    @objc dynamic var language = "";
    @objc dynamic var name = "";
    @objc dynamic var short_name = "";
    @objc dynamic var desc = "";
    @objc dynamic var author_name = "";
    
    init(_ language: String, _ name: String, _ short_name: String, _ desc: String, _ author_name: String) {
        self.language = language;
        self.name = name;
        self.short_name = short_name;
        self.desc = desc;
        self.author_name = author_name;
    }
 }

 @objc(Icon)
 class Icon: NSObject {
    @objc dynamic var src = "";
    @objc dynamic var sizes = "";
    @objc dynamic var type = "";
    
    init(_ src: String, _ sizes: String, _ type: String) {
        self.src = src;
        self.sizes = sizes;
        self.type = type;
    }
 }

 @objc(PluginAuth)
 class PluginAuth: NSObject {
    @objc dynamic var plugin = "";
    @objc dynamic var authority = AppInfo.AUTHORITY_NOINIT;
    
    init(_ plugin: String, _ authority: Int) {
        self.plugin = plugin;
        self.authority = authority;
    }
 }

 @objc(UrlAuth)
 class UrlAuth: NSObject {
    @objc dynamic var url = "";
    @objc dynamic var authority = AppInfo.AUTHORITY_NOINIT;
    
    init(_ url: String, _ authority: Int) {
        self.url = url;
        self.authority = authority;
    }
 }
 
 @objc(Framework)
 class Framework: NSObject {
    @objc dynamic var name = "";
    @objc dynamic var version = "";
    
    init(_ name: String, _ version: String) {
        self.name = name;
        self.version = version;
    }
 }
 
 @objc(Platform)
 class Platform: NSObject {
    @objc dynamic var name = "";
    @objc dynamic var version = "";
    
    init(_ name: String, _ version: String) {
        self.name = name;
        self.version = version;
    }
 }
 
 @objc(IntentFilter)
 class IntentFilter: NSObject {
    @objc dynamic var action = "";
    
    init(_ action: String) {
        self.action = action;
    }
 }
