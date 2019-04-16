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
    @objc static let AUTH_ICONS_TABLE = "icons";
    @objc static let APP_TABLE = "app";
    
    let db: Connection;
    let tid = Expression<Int64>(AppInfo.TID)
    let app_tid = Expression<Int64>(AppInfo.APP_TID);
    
    let app_id = Expression<String>(AppInfo.APP_ID)
    let version = Expression<String>(AppInfo.VERSION)
    let name = Expression<String>(AppInfo.NAME)
    let short_name = Expression<String?>(AppInfo.SHORT_NAME)
    let description = Expression<String?>(AppInfo.DESCRIPTION)
    let start_url = Expression<String>(AppInfo.START_URL)
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
    
    let plugin = Expression<String>(AppInfo.PLUGIN)
    let url = Expression<String>(AppInfo.URL)
    let authority = Expression<Int>(AppInfo.AUTHORITY)
    
    let src = Expression<String>(AppInfo.SRC)
    let sizes = Expression<String>(AppInfo.SIZES)
    let type = Expression<String>(AppInfo.TYPE)
    
    let plugins = Table(ManagerDBAdapter.AUTH_PLUGIN_TABLE)
    let urls = Table(ManagerDBAdapter.AUTH_URL_TABLE)
    let icons = Table(ManagerDBAdapter.AUTH_ICONS_TABLE)
    let apps = Table(ManagerDBAdapter.APP_TABLE)
    
    init(_ dataPath: String) {
        let path = dataPath + ManagerDBAdapter.DATABASE_NAME;
        db = try! Connection(path)
    
        try! db.run(plugins.create(ifNotExists: true) { t in
            t.column(tid, primaryKey: .autoincrement)
            t.column(app_tid)
            t.column(plugin)
            t.column(authority)
        })
        
        try! db.run(urls.create(ifNotExists: true) { t in
            t.column(tid, primaryKey: .autoincrement)
            t.column(app_tid)
            t.column(url)
            t.column(authority)
        })
        
        try! db.run(icons.create(ifNotExists: true) { t in
            t.column(tid, primaryKey: .autoincrement)
            t.column(app_tid)
            t.column(src)
            t.column(sizes)
            t.column(type)
        })
        
        try! db.run(apps.create(ifNotExists: true) { t in
            t.column(tid, primaryKey: .autoincrement)
            t.column(app_id, unique: true)
            t.column(version)
            t.column(name)
            t.column(short_name)
            t.column(description)
            t.column(start_url)
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
        })
    }
    
    func addAppInfo(_ info: AppInfo) throws {
        try db.transaction {
            info.tid = try db.run(apps.insert(app_id <- info.app_id,
                        app_id <- info.app_id,
                        version <- info.version,
                        name <- info.name,
                        short_name <- info.short_name,
                        description <- info.desc,
                        start_url <- info.start_url,
                        author_name <- info.author_name,
                        author_email <- info.author_email,
                        default_locale <- info.app_id,
                        background_color <- info.background_color,
                        theme_display <- info.theme_display,
                        theme_color <- info.theme_color,
                        theme_font_name <- info.theme_font_name,
                        theme_font_color <- info.theme_font_color,
                        install_time <- info.install_time,
                        built_in <- info.built_in,
                        remote <- info.remote,
                        launcher <- info.launcher));
            
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
        }
    }
    
    func getInfos(_ rows: AnySequence<Row>) throws -> [AppInfo] {
        var infos = [AppInfo]();
        for app in rows {
            let info = AppInfo();
            info.tid = app[tid];
            info.app_id = app[app_id];
            info.version = app[version];
            info.name = app[name];
            info.short_name = app[short_name] ?? "";
            info.desc = app[description] ?? "";
            info.start_url = app[start_url];
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
        try db.transaction {
            var items = plugins.filter(app_tid == info.tid);
            try db.run(items.delete());
            items = urls.filter(app_tid == info.tid);
            try db.run(items.delete());
            items = icons.filter(app_tid == info.tid);
            try db.run(items.delete());
            items = apps.filter(app_tid == info.tid);
            try db.run(items.delete());
        }
    }

 }
