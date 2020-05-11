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
import SQLite

class ManagerDBAdapter {

    @objc static let DATABASE_NAME = "manager.db";
    @objc static let VERSION = 1;
    @objc static let AUTH_PLUGIN_TABLE = "auth_plugin";
    @objc static let AUTH_URL_TABLE = "auth_url";
    @objc static let AUTH_INTENT_TABLE = "auth_intent";
    @objc static let AUTH_API_TABLE = "auth_api";
    @objc static let ICONS_TABLE = "icons";
    @objc static let LOCALE_TABLE = "locale";
    @objc static let FRAMEWORK_TABLE = "framework";
    @objc static let PLATFORM_TABLE = "platform";
    @objc static let INTENT_FILTER_TABLE = "intent_filter";
    //For dapp setting
    @objc static let SETTING_TABLE = "setting";
    //For system preference
    @objc static let PREFERENCE_TABLE = "preference";
    @objc static let APP_TABLE = "app";

    let db: Connection;
    let tid = Expression<Int64>(AppInfo.TID)
    let app_tid = Expression<Int64>(AppInfo.APP_TID);

    let app_id = Expression<String>(AppInfo.APP_ID)
    let version = Expression<String>(AppInfo.VERSION)
    let version_code = Expression<Int>(AppInfo.VERSION_CODE)
    let name = Expression<String>(AppInfo.NAME)
    let short_name = Expression<String?>(AppInfo.SHORT_NAME)
    let description = Expression<String?>(AppInfo.DESCRIPTION)
    let start_url = Expression<String>(AppInfo.START_URL)
    let start_visible = Expression<String>(AppInfo.START_VISIBLE)
    let author_name = Expression<String?>(AppInfo.AUTHOR_NAME)
    let author_email = Expression<String?>(AppInfo.AUTHOR_EMAIL)
    let default_locale = Expression<String?>(AppInfo.DEFAULT_LOCAL)
    let background_color = Expression<String?>(AppInfo.BACKGROUND_COLOR)
    let theme_display = Expression<String?>(AppInfo.THEME_DISPLAY)
    let theme_color = Expression<String?>(AppInfo.THEME_COLOR)
    let theme_font_name = Expression<String?>(AppInfo.THEME_FONT_NAME)
    let theme_font_color = Expression<String?>(AppInfo.THEME_FONT_COLOR)
    let install_time = Expression<Int64>(AppInfo.INSTALL_TIME)
    let built_in = Expression<Bool>(AppInfo.BUILT_IN)
    let remote = Expression<Bool>(AppInfo.REMOTE)
    let launcher = Expression<Bool>(AppInfo.LAUNCHER)
    let category = Expression<String?>(AppInfo.CATEGORY)
    let key_words = Expression<String?>(AppInfo.KEY_WORDS)

    let plugin = Expression<String>(AppInfo.PLUGIN)
    let url = Expression<String>(AppInfo.URL)
    let api = Expression<String>(AppInfo.API)
    let authority = Expression<Int>(AppInfo.AUTHORITY)

    let src = Expression<String>(AppInfo.SRC)
    let sizes = Expression<String>(AppInfo.SIZES)
    let type = Expression<String>(AppInfo.TYPE)

    let language = Expression<String>(AppInfo.LANGUAGE)

    let action = Expression<String>(AppInfo.ACTION)

    let key = Expression<String>("key")
    let value = Expression<String>("value")

    let plugins = Table(ManagerDBAdapter.AUTH_PLUGIN_TABLE)
    let urls = Table(ManagerDBAdapter.AUTH_URL_TABLE)
    let intents = Table(ManagerDBAdapter.AUTH_INTENT_TABLE)
    let apis = Table(ManagerDBAdapter.AUTH_API_TABLE)
    let icons = Table(ManagerDBAdapter.ICONS_TABLE)
    let locales = Table(ManagerDBAdapter.LOCALE_TABLE)
    let frameworks = Table(ManagerDBAdapter.FRAMEWORK_TABLE)
    let platforms = Table(ManagerDBAdapter.PLATFORM_TABLE)
    let intent_filters = Table(ManagerDBAdapter.INTENT_FILTER_TABLE)
    let setting = Table(ManagerDBAdapter.SETTING_TABLE)
    let preference = Table(ManagerDBAdapter.PREFERENCE_TABLE)
    let apps = Table(ManagerDBAdapter.APP_TABLE)

    init(_ dataPath: String) {
        let path = dataPath + ManagerDBAdapter.DATABASE_NAME;
        db = try! Connection(path)
        try! creatTables();
    }

    func creatTables() throws {
        try db.run(plugins.create(ifNotExists: true) { t in
            t.column(tid, primaryKey: .autoincrement)
            t.column(app_tid)
            t.column(plugin)
            t.column(authority)
        })

        try db.run(urls.create(ifNotExists: true) { t in
            t.column(tid, primaryKey: .autoincrement)
            t.column(app_tid)
            t.column(url)
            t.column(authority)
        })

        try db.run(intents.create(ifNotExists: true) { t in
            t.column(tid, primaryKey: .autoincrement)
            t.column(app_tid)
            t.column(url)
            t.column(authority)
        })

        try db.run(apis.create(ifNotExists: true) { t in
            t.column(tid, primaryKey: .autoincrement)
            t.column(app_id)
            t.column(plugin)
            t.column(api)
            t.column(authority)
        })
        
        try db.run(icons.create(ifNotExists: true) { t in
            t.column(tid, primaryKey: .autoincrement)
            t.column(app_tid)
            t.column(src)
            t.column(sizes)
            t.column(type)
        })

        try db.run(locales.create(ifNotExists: true) { t in
            t.column(tid, primaryKey: .autoincrement)
            t.column(app_tid)
            t.column(language)
            t.column(name)
            t.column(short_name)
            t.column(description)
            t.column(author_name)
        })

        try db.run(frameworks.create(ifNotExists: true) { t in
            t.column(tid, primaryKey: .autoincrement)
            t.column(app_tid)
            t.column(name)
            t.column(version)
        })

        try db.run(platforms.create(ifNotExists: true) { t in
            t.column(tid, primaryKey: .autoincrement)
            t.column(app_tid)
            t.column(name)
            t.column(version)
        })

        try db.run(intent_filters.create(ifNotExists: true) { t in
            t.column(tid, primaryKey: .autoincrement)
            t.column(app_id)
            t.column(action)
        })

        try db.run(setting.create(ifNotExists: true) { t in
            t.column(tid, primaryKey: .autoincrement)
            t.column(app_id)
            t.column(key)
            t.column(value)
        })

        try db.run(preference.create(ifNotExists: true) { t in
            t.column(tid, primaryKey: .autoincrement)
            t.column(key)
            t.column(value)
        })

        try db.run(apps.create(ifNotExists: true) { t in
            t.column(tid, primaryKey: .autoincrement)
            t.column(app_id, unique: true)
            t.column(version)
            t.column(version_code)
            t.column(name)
            t.column(short_name)
            t.column(description)
            t.column(start_url)
            t.column(start_visible)
            t.column(type)
            t.column(author_name)
            t.column(author_email)
            t.column(default_locale)
            t.column(background_color)
            t.column(theme_display)
            t.column(theme_color)
            t.column(theme_font_name)
            t.column(theme_font_color)
            t.column(install_time)
            t.column(built_in)
            t.column(remote)
            t.column(launcher)
            t.column(category)
            t.column(key_words)
        })
    }

    func dropTables() throws {
        try db.run(plugins.drop());
        try db.run(urls.drop());
        try db.run(icons.drop());
        try db.run(locales.drop());
        try db.run(frameworks.drop());
        try db.run(platforms.drop());
        try db.run(intent_filters.drop());
        try db.run(setting.drop());
        try db.run(preference.drop());
        try db.run(apps.drop());
    }

    func addAppInfo(_ info: AppInfo) throws {
        try db.transaction {
            info.tid = try db.run(apps.insert(
                app_id <- info.app_id,
                version <- info.version,
                version_code <- info.version_code,
                name <- info.name,
                short_name <- info.short_name,
                description <- info.desc,
                start_url <- info.start_url,
                start_visible <- info.start_visible,
                type <- info.type,
                author_name <- info.author_name,
                author_email <- info.author_email,
                default_locale <- info.default_locale,
                background_color <- info.background_color,
                theme_display <- info.theme_display,
                theme_color <- info.theme_color,
                theme_font_name <- info.theme_font_name,
                theme_font_color <- info.theme_font_color,
                install_time <- info.install_time,
                built_in <- info.built_in,
                remote <- info.remote,
                launcher <- info.launcher,
                category <- info.category,
                key_words <- info.key_words
            ));

            print("inserted id: \(info.tid)")

            for icon in info.icons {
                try db.run(icons.insert(app_tid <- info.tid,
                        src <- icon.src,
                        sizes <- icon.sizes,
                        type <- icon.type));
            }

            for pluginAuth in info.plugins {
                try db.run(plugins.insert(app_tid <- info.tid,
                        plugin <- pluginAuth.plugin,
                        authority <- pluginAuth.authority));
            }

            for urlAuth in info.urls {
                try db.run(urls.insert(app_tid <- info.tid,
                        url <- urlAuth.url,
                        authority <- urlAuth.authority));
            }

            for urlAuth in info.intents {
                try db.run(intents.insert(app_tid <- info.tid,
                        url <- urlAuth.url,
                        authority <- urlAuth.authority));
            }

            for locale in info.locales {
                try db.run(locales.insert(app_tid <- info.tid,
                                       language <- locale.language,
                                       name <- locale.name,
                                       short_name <- locale.short_name,
                                       description <- locale.desc,
                                       author_name <- locale.author_name));
            }

            for framework in info.frameworks {
                try db.run(frameworks.insert(app_tid <- info.tid,
                                        name <- framework.name,
                                        version <- framework.version));
            }

            for platform in info.platforms {
                try db.run(platforms.insert(app_tid <- info.tid,
                                        name <- platform.name,
                                        version <- platform.version));
            }

            for intentFilter in info.intentFilters {
                try db.run(intent_filters.insert(
                                        app_id <- info.app_id,
                                        action <- intentFilter.action));
            }
        }
    }

    func getInfos(_ rows: AnySequence<Row>) throws -> [AppInfo] {
        var infos = [AppInfo]();
        for app in rows {
            let info = AppInfo();
            info.tid = app[tid];
            info.app_id = app[app_id];
            info.version = app[version];
            info.version_code = app[version_code];
            info.name = app[name];
            info.short_name = app[short_name] ?? "";
            info.desc = app[description] ?? "";
            info.start_url = app[start_url];
            info.start_visible = app[start_visible];
            info.type = app[type];
            info.author_name = app[author_name] ?? "";
            info.author_email = app[author_email] ?? "";
            info.default_locale = app[default_locale] ?? "";
            info.background_color = app[background_color] ?? "";
            info.theme_display = app[theme_display] ?? "";
            info.theme_font_name = app[theme_font_name] ?? "";
            info.theme_font_color = app[theme_font_color] ?? "";
            info.install_time = app[install_time];
            info.built_in = app[built_in];
            info.remote = app[remote];
            info.launcher = app[launcher];
            info.category = app[category] ?? "other";
            info.key_words = app[key_words] ?? "";

            for icon in try db.prepare(icons.select(*).filter(app_tid == info.tid)) {
                info.addIcon(icon[src], icon[sizes], icon[type]);
            }

            for pluginAuth in try db.prepare(plugins.select(*).filter(app_tid == info.tid)) {
                let name = pluginAuth[plugin];
                let auth = pluginAuth[authority]
                info.addPlugin(name, auth);
            }

            for urlAuth in try db.prepare(urls.select(*).filter(app_tid == info.tid)) {
                info.addUrl(urlAuth[url], urlAuth[authority]);
            }

            for urlAuth in try db.prepare(intents.select(*).filter(app_tid == info.tid)) {
                info.addIntent(urlAuth[url], urlAuth[authority]);
            }

            for locale in try db.prepare(locales.select(*).filter(app_tid == info.tid)) {
                info.addLocale(locale[language], locale[name], app[short_name] ?? "", locale[description] ?? "", locale[author_name] ?? "");
            }

            for framework in try db.prepare(frameworks.select(*).filter(app_tid == info.tid)) {
                info.addFramework(framework[name], framework[version]);
            }

            for platform in try db.prepare(platforms.select(*).filter(app_tid == info.tid)) {
                info.addPlatform(platform[name], platform[version]);
            }

            infos.append(info);
        }
        return infos;
    }

    func getAppInfo(_ id: String) throws -> AppInfo? {
        let query = apps.select(*)
            .filter(app_id == id && !launcher)
        let rows = try db.prepare(query);
        let infos = try getInfos(rows);
        guard infos.count > 0 else {
            return nil;
        }
        return infos[0];
    }

    func getAppInfos() throws -> [AppInfo] {
        let query = apps.select(*)
            .filter(!launcher)
        let rows = try db.prepare(query);
        return try getInfos(rows);
    }

    func getLauncherInfo() throws -> AppInfo? {
        let query = apps.select(*)
            .filter(launcher)
        let rows = try db.prepare(query);
        let infos = try getInfos(rows);
        guard infos.count > 0 else {
            return nil;
        }
        return infos[0];
    }

    func changeBuiltInToNormal(_ appId: String) throws {
        try db.transaction {
            let builtIn = apps.filter(app_id == appId);
            try db.run(builtIn.update(built_in <- false));
        }
    }

    func updatePluginAuth(_ item: PluginAuth, _ auth: Int) throws {
        try db.transaction {
            let pluginAuth = plugins.filter(plugin == item.plugin);
            try db.run(pluginAuth.update(authority <- auth));
        }
    }

    func updateUrlAuth(_ item: UrlAuth, _ auth: Int) throws {
        try db.transaction {
            let urlAuth = urls.filter(url == item.url);
            try db.run(urlAuth.update(authority <- auth));
        }
    }

    func removeAppInfo(_ info: AppInfo) throws {
        var items = plugins.filter(app_tid == info.tid);
        try db.run(items.delete());
        items = urls.filter(app_tid == info.tid);
        try db.run(items.delete());
        items = icons.filter(app_tid == info.tid);
        try db.run(items.delete());
        items = locales.filter(app_tid == info.tid);
        try db.run(items.delete());
        items = frameworks.filter(app_tid == info.tid);
        try db.run(items.delete());
        items = platforms.filter(app_tid == info.tid);
        try db.run(items.delete());
        items = intent_filters.filter(app_id == info.app_id);
        try db.run(items.delete());
        items = setting.filter(app_id == info.app_id);
        try db.run(items.delete());
        items = apis.filter(app_id == info.app_id);
        try db.run(items.delete());
        items = apps.filter(tid == info.tid);
        try db.run(items.delete());
    }

    func getIntentFilter(_ act: String) throws -> [String] {
        let query = intent_filters.select(app_id)
            .filter(action == act)
        let rows = try db.prepare(query);
        var ids = [String]();
        for intent in rows {
            ids.append(intent[app_id]);
        }
        return ids;
    }

    func setSetting(_ id: String, _ k: String, _ v: Any?) throws {
        var data: String? = nil;
        if !(v is NSNull) {
            let dict = ["data": v!] as [String : Any];
            data = dict.toString();
            guard data != nil else {
                throw AppError.error("setSetting error: value is invalid!");
            }
        }

        let isExist = try getSetting(id, k) != nil;
        if (!isExist) {
            if !(v is NSNull) {
                try db.run(setting.insert(app_id <- id,
                                          key <- k,
                                          value<-data!));
            }
        }
        else {
            let row = setting.filter(app_id == id && key == k);
            try db.transaction {
                if !(v is NSNull) {
                    try db.run(row.update(value <- data!));
                }
                else {
                    try db.run(row.delete());
                }
            }
        }
    }

    func getSetting(_ id: String, _ k: String) throws -> [String: Any]? {
        let query = setting.select(*)
            .filter(app_id == id && key == k)
        let rows = try db.prepare(query);
        for row in rows {
            let dict = row[value].toDict();
            guard dict != nil else {
                throw AppError.error("getSetting error: value is invalid!");
            }
            let ret = ["key": k, "value": dict!["data"]] as [String : Any];
            return ret;
        }

        return nil;
    }

    func getSettings(_ id: String) throws -> [String: Any] {
        let query = setting.select(*)
            .filter(app_id == id)
        let rows = try db.prepare(query);
        var ret = [String: Any]();
        for row in rows {
            let dict = row[value].toDict();
            if (dict != nil) {
                ret[row[key]] = dict!["data"];
            }
        }

        return ret;
    }

    func setPreference(_ k: String, _ v: Any?) throws {
        var data: String? = nil;

        if !(v is NSNull) {
            let dict = ["data": v!] as [String : Any];
            data = dict.toString();
            guard data != nil else {
                throw AppError.error("setPreference error: value is invalid!");
            }
        }

        let isExist = try getPreference(k) != nil;
        if (!isExist) {
            if !(v is NSNull) {
                try db.run(preference.insert(key <- k,
                                          value<-data!));
            }
        }
        else {
            let row = preference.filter(key == k);
            try db.transaction {
                if !(v is NSNull) {
                    try db.run(row.update(value <- data!));
                }
                else {
                    try db.run(row.delete());
                }
            }
        }
    }

    func resetPreferences() throws {
        try db.run(preference.delete());
    }

    func getPreference(_ k: String) throws -> [String: Any]? {
        let query = preference.select(*)
            .filter(key == k)
        let rows = try db.prepare(query);
        for row in rows {
            let dict = row[value].toDict();
            guard dict != nil else {
                throw AppError.error("getPreference error: value is invalid!");
            }
            let ret = ["key": k, "value": dict!["data"]!] as [String : Any];
            return ret;
        }

        return nil;
    }

    func getPreferences() throws -> [String: Any] {
        let query = preference.select(*)
        let rows = try db.prepare(query);
        var ret = [String: Any]();
        for row in rows {
            let dict = row[value].toDict();
            if (dict != nil) {
                ret[row[key]] = dict!["data"];
            }
        }

        return ret;
    }
    
    func getApiAuth(_ appId: String, _ plugin: String, _ api: String) throws -> Int? {
        let query = apis.select(authority)
            .filter(app_id == appId && self.plugin == plugin && self.api == api)
        let rows = try db.prepare(query);
        for row in rows {
            return row[authority];
        }

        return nil;
    }
    
    func setApiAuth(_ appId: String, _ plugin: String, _ api: String, _ auth: Int?) throws {
        let isExist = try getApiAuth(appId, plugin, api) != nil;
        if (!isExist) {
            if (auth != nil) {
                try db.run(apis.insert(app_id <- appId, self.plugin <- plugin,
                                       self.api <- api, authority <- auth!));
            }
        }
        else {
            let row = apis.filter(app_id == appId && self.plugin == plugin && self.api == api);
            try db.transaction {
                if (auth != nil) {
                    try db.run(row.update(authority <- auth!));
                }
                else {
                    try db.run(row.delete());
                }
            }
        }
    }
    
    func resetApiDenyAuth(_ appId: String)  {
        let row = apis.filter(app_id == appId && authority == AppInfo.AUTHORITY_DENY);
        try? db.transaction {
            try? db.run(row.update(authority <- AppInfo.AUTHORITY_NOINIT));
        }
    }

    func clean() throws {
        try dropTables();
        try creatTables();
    }

 }
