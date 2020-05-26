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

package org.elastos.trinity.runtime;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

import org.elastos.trinity.runtime.didsessions.DIDSessionManager;
import org.json.JSONObject;

import java.util.ArrayList;

public class ManagerDBAdapter {
    ManagerDBHelper helper;
    Context context;

     public ManagerDBAdapter(Context context, String dbPath)
     {
         helper = new ManagerDBHelper(context, dbPath);
         SQLiteDatabase db = helper.getWritableDatabase();
         this.context = context;
     }

    public ManagerDBAdapter(Context context)
    {
        this(context, "");
    }

    public void clean() {
        SQLiteDatabase db = helper.getWritableDatabase();
        helper.onUpgrade(db, 0, 1);
    }

    public boolean addAppInfo(AppInfo info) {
        if (info != null) {
            SQLiteDatabase db = helper.getWritableDatabase();
            ContentValues contentValues = new ContentValues();
            contentValues.put(AppInfo.APP_ID, info.app_id);
            contentValues.put(AppInfo.VERSION, info.version);
            contentValues.put(AppInfo.VERSION_CODE, info.version_code);
            contentValues.put(AppInfo.NAME, info.name);
            contentValues.put(AppInfo.SHORT_NAME, info.short_name);
            contentValues.put(AppInfo.DESCRIPTION, info.description);
            contentValues.put(AppInfo.START_URL, info.start_url);
            contentValues.put(AppInfo.START_VISIBLE, info.start_visible);
            contentValues.put(AppInfo.TYPE, info.type);
            contentValues.put(AppInfo.AUTHOR_NAME, info.author_name);
            contentValues.put(AppInfo.AUTHOR_EMAIL, info.author_email);
            contentValues.put(AppInfo.DEFAULT_LOCAL, info.default_locale);
            contentValues.put(AppInfo.BACKGROUND_COLOR, info.background_color);
            contentValues.put(AppInfo.THEME_DISPLAY, info.theme_display);
            contentValues.put(AppInfo.THEME_COLOR, info.theme_color);
            contentValues.put(AppInfo.THEME_FONT_NAME, info.theme_font_name);
            contentValues.put(AppInfo.THEME_FONT_COLOR, info.theme_font_color);
            contentValues.put(AppInfo.INSTALL_TIME, info.install_time);
            contentValues.put(AppInfo.BUILT_IN, info.built_in);
            contentValues.put(AppInfo.REMOTE, info.remote);
            contentValues.put(AppInfo.LAUNCHER, info.launcher);
            contentValues.put(AppInfo.CATEGORY, info.category);
            contentValues.put(AppInfo.KEY_WORDS, info.key_words);
            long tid = db.insert(ManagerDBHelper.APP_TABLE, null, contentValues);

            if (tid == -1) {
                return false;
            }
            info.tid = tid;

            for (AppInfo.Icon icon : info.icons) {
                contentValues = new ContentValues();
                contentValues.put(AppInfo.APP_TID, tid);
                contentValues.put(AppInfo.SRC, icon.src);
                contentValues.put(AppInfo.SIZES, icon.sizes);
                contentValues.put(AppInfo.TYPE, icon.type);
                db.insert(ManagerDBHelper.ICONS_TABLE, null, contentValues);
            }

            for (AppInfo.PluginAuth pluginAuth : info.plugins) {
                contentValues = new ContentValues();
                contentValues.put(AppInfo.APP_TID, tid);
                contentValues.put(AppInfo.PLUGIN, pluginAuth.plugin);
                contentValues.put(AppInfo.AUTHORITY, pluginAuth.authority);
                db.insert(ManagerDBHelper.AUTH_PLUGIN_TABLE, null, contentValues);
            }

            for (AppInfo.UrlAuth urlAuth : info.urls) {
                contentValues = new ContentValues();
                contentValues.put(AppInfo.APP_TID, tid);
                contentValues.put(AppInfo.URL, urlAuth.url);
                contentValues.put(AppInfo.AUTHORITY, urlAuth.authority);
                db.insert(ManagerDBHelper.AUTH_URL_TABLE, null, contentValues);
            }

            for (AppInfo.UrlAuth intent : info.intents) {
                contentValues = new ContentValues();
                contentValues.put(AppInfo.APP_TID, tid);
                contentValues.put(AppInfo.URL, intent.url);
                contentValues.put(AppInfo.AUTHORITY, intent.authority);
                db.insert(ManagerDBHelper.AUTH_INTENT_TABLE, null, contentValues);
            }

            for (AppInfo.Locale locale : info.locales) {
                contentValues = new ContentValues();
                contentValues.put(AppInfo.APP_TID, tid);
                contentValues.put(AppInfo.LANGUAGE, locale.language);
                contentValues.put(AppInfo.NAME, locale.name);
                contentValues.put(AppInfo.SHORT_NAME, locale.short_name);
                contentValues.put(AppInfo.DESCRIPTION, locale.description);
                contentValues.put(AppInfo.AUTHOR_NAME, locale.author_name);
                db.insert(ManagerDBHelper.LACALE_TABLE, null, contentValues);
            }

            for (AppInfo.Framework framework : info.frameworks) {
                contentValues = new ContentValues();
                contentValues.put(AppInfo.APP_TID, tid);
                contentValues.put(AppInfo.NAME, framework.name);
                contentValues.put(AppInfo.VERSION, framework.version);
                db.insert(ManagerDBHelper.FRAMEWORK_TABLE, null, contentValues);
            }

            for (AppInfo.Platform platform : info.platforms) {
                contentValues = new ContentValues();
                contentValues.put(AppInfo.APP_TID, tid);
                contentValues.put(AppInfo.NAME, platform.name);
                contentValues.put(AppInfo.VERSION, platform.version);
                db.insert(ManagerDBHelper.PLATFORM_TABLE, null, contentValues);
            }

            for (AppInfo.IntentFilter intent_filter : info.intentFilters) {
                contentValues = new ContentValues();
                contentValues.put(AppInfo.APP_ID, info.app_id);
                contentValues.put(AppInfo.ACTION, intent_filter.action);
                db.insert(ManagerDBHelper.INTENT_FILTER_TABLE, null, contentValues);
            }

            return true;
        }
        else {
            return false;
        }
    }

    private AppInfo[] getInfos(String selection, String[] selectionArgs) {
        SQLiteDatabase db = helper.getWritableDatabase();
        String[] columns = {AppInfo.TID, AppInfo.APP_ID, AppInfo.VERSION, AppInfo.VERSION_CODE, AppInfo.NAME, AppInfo.SHORT_NAME,
                AppInfo.DESCRIPTION, AppInfo.START_URL, AppInfo.START_VISIBLE, AppInfo.TYPE,
                AppInfo.AUTHOR_NAME, AppInfo.AUTHOR_EMAIL, AppInfo.DEFAULT_LOCAL, AppInfo.BACKGROUND_COLOR,
                AppInfo.THEME_DISPLAY, AppInfo.THEME_COLOR, AppInfo.THEME_FONT_NAME, AppInfo.THEME_FONT_COLOR,
                AppInfo.INSTALL_TIME, AppInfo.BUILT_IN, AppInfo.REMOTE, AppInfo.LAUNCHER,
                AppInfo.CATEGORY, AppInfo.KEY_WORDS};
        Cursor cursor = db.query(ManagerDBHelper.APP_TABLE, columns,selection, selectionArgs,null,null,null);
        AppInfo infos[] = new AppInfo[cursor.getCount()];
        int count = 0;
        while (cursor.moveToNext()) {
            AppInfo info = new AppInfo();
            info.tid = cursor.getInt(cursor.getColumnIndex(AppInfo.TID));
            info.app_id = cursor.getString(cursor.getColumnIndex(AppInfo.APP_ID));
            info.version = cursor.getString(cursor.getColumnIndex(AppInfo.VERSION));
            info.version_code = cursor.getInt(cursor.getColumnIndex(AppInfo.VERSION_CODE));
            info.name = cursor.getString(cursor.getColumnIndex(AppInfo.NAME));
            info.short_name = cursor.getString(cursor.getColumnIndex(AppInfo.SHORT_NAME));
            info.description = cursor.getString(cursor.getColumnIndex(AppInfo.DESCRIPTION));
            info.start_url = cursor.getString(cursor.getColumnIndex(AppInfo.START_URL));
            info.start_visible = cursor.getString(cursor.getColumnIndex(AppInfo.START_VISIBLE));
            info.type = cursor.getString(cursor.getColumnIndex(AppInfo.TYPE));
            info.author_name = cursor.getString(cursor.getColumnIndex(AppInfo.AUTHOR_NAME));
            info.author_email = cursor.getString(cursor.getColumnIndex(AppInfo.AUTHOR_EMAIL));
            info.default_locale = cursor.getString(cursor.getColumnIndex(AppInfo.DEFAULT_LOCAL));
            info.background_color = cursor.getString(cursor.getColumnIndex(AppInfo.BACKGROUND_COLOR));
            info.theme_display = cursor.getString(cursor.getColumnIndex(AppInfo.THEME_DISPLAY));
            info.theme_font_name = cursor.getString(cursor.getColumnIndex(AppInfo.THEME_FONT_NAME));
            info.theme_font_color = cursor.getString(cursor.getColumnIndex(AppInfo.THEME_FONT_COLOR));
            info.theme_color = cursor.getString(cursor.getColumnIndex(AppInfo.THEME_COLOR));

            info.install_time = cursor.getLong(cursor.getColumnIndex(AppInfo.INSTALL_TIME));
            info.built_in = cursor.getInt(cursor.getColumnIndex(AppInfo.BUILT_IN));
            info.remote = cursor.getInt(cursor.getColumnIndex(AppInfo.REMOTE));
            info.launcher = cursor.getInt(cursor.getColumnIndex(AppInfo.LAUNCHER));

            info.category = cursor.getString(cursor.getColumnIndex(AppInfo.CATEGORY));
            info.key_words = cursor.getString(cursor.getColumnIndex(AppInfo.KEY_WORDS));

            infos[count++] = info;


            String[] args1 = {String.valueOf(info.tid)};

            String[] columns1 = {AppInfo.SRC, AppInfo.SIZES, AppInfo.TYPE};
            Cursor cursor1 = db.query(ManagerDBHelper.ICONS_TABLE, columns1,AppInfo.APP_TID + "=?", args1,null,null,null);
            while (cursor1.moveToNext()) {
                info.addIcon(cursor1.getString(cursor1.getColumnIndex(AppInfo.SRC)),
                        cursor1.getString(cursor1.getColumnIndex(AppInfo.SIZES)),
                        cursor1.getString(cursor1.getColumnIndex(AppInfo.TYPE)));
            }

            String[] columns2 = {AppInfo.PLUGIN, AppInfo.AUTHORITY};
            cursor1 = db.query(ManagerDBHelper.AUTH_PLUGIN_TABLE, columns2,AppInfo.APP_TID + "=?", args1,null,null,null);
            while (cursor1.moveToNext()) {
                info.addPlugin(cursor1.getString(cursor1.getColumnIndex(AppInfo.PLUGIN)), cursor1.getInt(cursor1.getColumnIndex(AppInfo.AUTHORITY)));
            }

            String[] columns3 = {AppInfo.URL, AppInfo.AUTHORITY};
            cursor1 = db.query(ManagerDBHelper.AUTH_URL_TABLE, columns3,AppInfo.APP_TID + "=?", args1,null,null,null);
            while (cursor1.moveToNext()) {
                info.addUrl(cursor1.getString(cursor1.getColumnIndex(AppInfo.URL)), cursor1.getInt(cursor1.getColumnIndex(AppInfo.AUTHORITY)));
            }

            String[] intent_columns = {AppInfo.URL, AppInfo.AUTHORITY};
            cursor1 = db.query(ManagerDBHelper.AUTH_INTENT_TABLE, intent_columns,AppInfo.APP_TID + "=?", args1,null,null,null);
            while (cursor1.moveToNext()) {
                info.addIntent(cursor1.getString(cursor1.getColumnIndex(AppInfo.URL)), cursor1.getInt(cursor1.getColumnIndex(AppInfo.AUTHORITY)));
            }

            String[] columns4 = {AppInfo.LANGUAGE, AppInfo.NAME, AppInfo.SHORT_NAME, AppInfo.DESCRIPTION, AppInfo.AUTHOR_NAME};
            cursor1 = db.query(ManagerDBHelper.LACALE_TABLE, columns4,AppInfo.APP_TID + "=?", args1,null,null,null);
            while (cursor1.moveToNext()) {
                info.addLocale(cursor1.getString(cursor1.getColumnIndex(AppInfo.LANGUAGE)),
                        cursor1.getString(cursor1.getColumnIndex(AppInfo.NAME)),
                        cursor1.getString(cursor1.getColumnIndex(AppInfo.SHORT_NAME)),
                        cursor1.getString(cursor1.getColumnIndex(AppInfo.DESCRIPTION)),
                        cursor1.getString(cursor1.getColumnIndex(AppInfo.AUTHOR_NAME)));
            }

            String[] columns5 = {AppInfo.NAME, AppInfo.VERSION};
            cursor1 = db.query(ManagerDBHelper.FRAMEWORK_TABLE, columns5,AppInfo.APP_TID + "=?", args1,null,null,null);
            while (cursor1.moveToNext()) {
                info.addFramework(cursor1.getString(cursor1.getColumnIndex(AppInfo.NAME)),
                        cursor1.getString(cursor1.getColumnIndex(AppInfo.VERSION)));
            }

            cursor1 = db.query(ManagerDBHelper.PLATFORM_TABLE, columns5,AppInfo.APP_TID + "=?", args1,null,null,null);
            while (cursor1.moveToNext()) {
                info.addFramework(cursor1.getString(cursor1.getColumnIndex(AppInfo.NAME)),
                        cursor1.getString(cursor1.getColumnIndex(AppInfo.VERSION)));
            }
        }
        return infos;
    }

    public AppInfo getAppInfo(String id) {
        String selection = AppInfo.APP_ID + "=? AND " + AppInfo.LAUNCHER + "=0";
        String[] args = {String.valueOf(id)};
        AppInfo infos[] = getInfos(selection, args);
        if (infos.length > 0) {
            return infos[0];
        }
        else {
            return null;
        }
    }

    public AppInfo[] getAppInfos() {
        String selection = AppInfo.LAUNCHER + "=0 AND " + AppInfo.APP_ID + "!=\"org.elastos.trinity.dapp.didsession\"";
        return getInfos(selection, null);
    }

    public AppInfo getLauncherInfo() {
        String selection = AppInfo.LAUNCHER + "=1";
        AppInfo infos[] = getInfos(selection, null);
        if (infos.length > 0) {
            return infos[0];
        }
        else {
            return null;
        }
    }

    public int changeBuiltInToNormal(String appId) {
        SQLiteDatabase db = helper.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put(AppInfo.BUILT_IN, 0);
        String where = AppInfo.APP_ID + "=?";
        String[] whereArgs= {appId};
        int count = db.update(ManagerDBHelper.APP_TABLE, contentValues, where, whereArgs );
        return count;
    }

    public int updatePluginAuth(long tid, String plugin, int authority) {
        SQLiteDatabase db = helper.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put(AppInfo.AUTHORITY, authority);
        String where = AppInfo.APP_TID + "=? AND " + AppInfo.PLUGIN + "=?";
        String[] whereArgs= {String.valueOf(tid), plugin};
        int count = db.update(ManagerDBHelper.AUTH_PLUGIN_TABLE, contentValues, where, whereArgs );
        return count;
    }

    public int updateURLAuth(long tid, String url, int authority) {
        SQLiteDatabase db = helper.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put(AppInfo.AUTHORITY, authority);
        String where = AppInfo.APP_TID + "=? AND " + AppInfo.URL + "=?";
        String[] whereArgs= {String.valueOf(tid), url};
        int count =db.update(ManagerDBHelper.AUTH_URL_TABLE, contentValues, where, whereArgs );
        return count;
    }

    public int updateIntentAuth(long tid, String url, int authority) {
        SQLiteDatabase db = helper.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put(AppInfo.AUTHORITY, authority);
        String where = AppInfo.APP_TID + "=? AND " + AppInfo.URL + "=?";
        String[] whereArgs= {String.valueOf(tid), url};
        int count =db.update(ManagerDBHelper.AUTH_INTENT_TABLE, contentValues, where, whereArgs );
        return count;
    }

    public int removeAppInfo(AppInfo info) {
        SQLiteDatabase db = helper.getWritableDatabase();
        String where = AppInfo.APP_TID + "=?";
        String[] whereArgs = {String.valueOf(info.tid)};
        int count = db.delete(ManagerDBHelper.AUTH_URL_TABLE, where, whereArgs);
        db.delete(ManagerDBHelper.AUTH_INTENT_TABLE, where, whereArgs);
        count = db.delete(ManagerDBHelper.AUTH_PLUGIN_TABLE, where, whereArgs);
        db.delete(ManagerDBHelper.ICONS_TABLE, where, whereArgs);
        db.delete(ManagerDBHelper.LACALE_TABLE, where, whereArgs);
        db.delete(ManagerDBHelper.FRAMEWORK_TABLE, where, whereArgs);
        db.delete(ManagerDBHelper.PLATFORM_TABLE, where, whereArgs);
        where = AppInfo.APP_ID + "=?";
        String[] args = {info.app_id};
        db.delete(ManagerDBHelper.INTENT_FILTER_TABLE, where, args);
        db.delete(ManagerDBHelper.SETTING_TABLE, where, args);
        where = AppInfo.TID + "=?";
        count = db.delete(ManagerDBHelper.APP_TABLE, where, whereArgs);
        return count;
    }

    public String[] getIntentFilter(String action) {
        SQLiteDatabase db = helper.getWritableDatabase();
        String[] args = {action};
        String[] columns = {AppInfo.APP_ID};
        Cursor cursor = db.query(ManagerDBHelper.INTENT_FILTER_TABLE, columns,AppInfo.ACTION + "=?", args,null,null,null);
        String ids[] = new String[cursor.getCount()];
        int count = 0;
        while (cursor.moveToNext()) {
            ids[count++] = cursor.getString(cursor.getColumnIndex(AppInfo.APP_ID));;
        }

        return ids;
    }

    public long setSetting(String id, String key, Object value) throws Exception {
        SQLiteDatabase db = helper.getWritableDatabase();
        long ret = 0;

        String data = null;
        if (value != null) {
            JSONObject json = new JSONObject();
            json.put("data", value);
            data = json.toString();
        }

        Boolean isExist = getSetting(id, key) != null;
        if (!isExist) {
            if (value != null) {
                ContentValues contentValues = new ContentValues();
                contentValues.put(AppInfo.APP_ID, id);
                contentValues.put(ManagerDBHelper.KEY, key);
                contentValues.put(ManagerDBHelper.VALUE, data);
                ret = db.insert(ManagerDBHelper.SETTING_TABLE, null, contentValues);
            }
        }
        else {
            String where = AppInfo.APP_ID + "=? AND " + ManagerDBHelper.KEY + "=?";
            String[] whereArgs = {id, key};
            if (value != null) {
                ContentValues contentValues = new ContentValues();
                contentValues.put(ManagerDBHelper.VALUE, data);
                ret = db.update(ManagerDBHelper.SETTING_TABLE, contentValues, where, whereArgs );
            }
            else {
                ret = db.delete(ManagerDBHelper.SETTING_TABLE, where, whereArgs);
            }
        }
        return ret;
    }

    public JSONObject getSetting(String id, String key) throws Exception {
        SQLiteDatabase db = helper.getWritableDatabase();
        String where = AppInfo.APP_ID + "=? AND " + ManagerDBHelper.KEY + "=?";
        String[] whereArgs = {id, key};
        String[] columns = {ManagerDBHelper.VALUE};
        Cursor cursor = db.query(ManagerDBHelper.SETTING_TABLE, columns, where, whereArgs,null,null,null);
        if (cursor.moveToNext()) {
            String value = cursor.getString(cursor.getColumnIndex(ManagerDBHelper.VALUE));
            JSONObject dict = new JSONObject(value);
            if (dict != null) {
                JSONObject ret = new JSONObject();
                ret.put("key", key);
                ret.put("value", dict.get("data"));
                return ret;
            }
        }

        return null;
    }

    public JSONObject getSettings(String id) throws Exception {
        SQLiteDatabase db = helper.getWritableDatabase();
        String where = AppInfo.APP_ID + "=?";
        String[] whereArgs = {id};
        String[] columns = {ManagerDBHelper.KEY, ManagerDBHelper.VALUE};
        Cursor cursor = db.query(ManagerDBHelper.SETTING_TABLE, columns, where, whereArgs,null,null,null);
        JSONObject ret = new JSONObject();
        while (cursor.moveToNext()) {
            String key = cursor.getString(cursor.getColumnIndex(ManagerDBHelper.KEY));
            String value = cursor.getString(cursor.getColumnIndex(ManagerDBHelper.VALUE));

            JSONObject dict = new JSONObject(value);
            if (dict != null) {
                ret.put(key, dict.get("data"));
            }
        }
        return ret;
    }

     public long setPreference(String key, Object value) throws Exception {
         SQLiteDatabase db = helper.getWritableDatabase();
         long ret = 0;

         String data = null;
         if (value != null) {
             JSONObject json = new JSONObject();
             json.put("data", value);
             data = json.toString();
         }

         Boolean isExist = getPreference(key) != null;
         if (!isExist) {
             if (value != null) {
                 ContentValues contentValues = new ContentValues();
                 contentValues.put(ManagerDBHelper.KEY, key);
                 contentValues.put(ManagerDBHelper.VALUE, data);
                 ret = db.insert(ManagerDBHelper.PREFERENCE_TABLE, null, contentValues);
             }
         }
         else {
             String where = ManagerDBHelper.KEY + "=?";
             String[] whereArgs = {key};
             if (value != null) {
                 ContentValues contentValues = new ContentValues();
                 contentValues.put(ManagerDBHelper.VALUE, data);
                 ret = db.update(ManagerDBHelper.PREFERENCE_TABLE, contentValues, where, whereArgs );
             }
             else {
                 ret = db.delete(ManagerDBHelper.PREFERENCE_TABLE, where, whereArgs);
             }
         }
         return ret;
     }

     public void resetPreferences() {
         helper.getWritableDatabase().delete(ManagerDBHelper.PREFERENCE_TABLE, null, null);
     }

     public JSONObject getPreference(String key) throws Exception {
         SQLiteDatabase db = helper.getWritableDatabase();
         String where = ManagerDBHelper.KEY + "=?";
         String[] whereArgs = {key};
         String[] columns = {ManagerDBHelper.VALUE};
         Cursor cursor = db.query(ManagerDBHelper.PREFERENCE_TABLE, columns, where, whereArgs,null,null,null);
         if (cursor.moveToNext()) {
             String value = cursor.getString(cursor.getColumnIndex(ManagerDBHelper.VALUE));
             JSONObject dict = new JSONObject(value);
             if (dict != null) {
                 JSONObject ret = new JSONObject();
                 ret.put("key", key);
                 ret.put("value", dict.get("data"));
                 return ret;
             }
         }

         return null;
     }

     public JSONObject getPreferences() throws Exception {
         SQLiteDatabase db = helper.getWritableDatabase();
         String[] columns = {ManagerDBHelper.KEY, ManagerDBHelper.VALUE};
         Cursor cursor = db.query(ManagerDBHelper.PREFERENCE_TABLE, columns, null, null,null,null,null);
         JSONObject ret = new JSONObject();
         while (cursor.moveToNext()) {
             String key = cursor.getString(cursor.getColumnIndex(ManagerDBHelper.KEY));
             String value = cursor.getString(cursor.getColumnIndex(ManagerDBHelper.VALUE));
             JSONObject dict = new JSONObject(value);
             if (dict != null) {
                 ret.put(key, dict.get("data"));
             }
         }
         return ret;
     }

     public int getApiAuth(String appId, String plugin, String api) {

         SQLiteDatabase db = helper.getWritableDatabase();
         String where = AppInfo.APP_ID + "=? AND " + AppInfo.PLUGIN + "=? AND " + AppInfo.API + "=?";
         String[] whereArgs = {appId, plugin, api};
         String[] columns = {AppInfo.AUTHORITY};
         Cursor cursor = db.query(ManagerDBHelper.AUTH_API_TABLE, columns, where, whereArgs,null,null,null);
         if (cursor.moveToNext()) {
             return cursor.getInt(cursor.getColumnIndex(AppInfo.AUTHORITY));
         }

         return AppInfo.AUTHORITY_NOEXIST;
     }

     public long setApiAuth(String appId, String plugin, String api, int auth) {

         SQLiteDatabase db = helper.getWritableDatabase();
         long ret = 0;

         Boolean isExist = getApiAuth(appId, plugin, api) != AppInfo.AUTHORITY_NOEXIST;
         if (!isExist) {
             ContentValues contentValues = new ContentValues();
             contentValues.put(AppInfo.APP_ID, appId);
             contentValues.put(AppInfo.PLUGIN, plugin);
             contentValues.put(AppInfo.API, api);
             contentValues.put(AppInfo.AUTHORITY, auth);
             ret = db.insert(ManagerDBHelper.AUTH_API_TABLE, null, contentValues);
         }
         else {
             String where = AppInfo.APP_ID + "=? AND " + AppInfo.PLUGIN + "=? AND " + AppInfo.API + "=?";
             String[] whereArgs = {appId, plugin, api};
             if (auth != AppInfo.AUTHORITY_NOINIT) {
                 ContentValues contentValues = new ContentValues();
                 contentValues.put(AppInfo.AUTHORITY, auth);
                 ret = db.update(ManagerDBHelper.AUTH_API_TABLE, contentValues, where, whereArgs );
             }
             else {
                 ret = db.delete(ManagerDBHelper.AUTH_API_TABLE, where, whereArgs);
             }
         }

         return ret;
     }

     public void resetApiDenyAuth(String appId)  {
         SQLiteDatabase db = helper.getWritableDatabase();
         String where = AppInfo.APP_ID + "=? AND " + AppInfo.AUTHORITY + "=?";
         String[] whereArgs = {appId, String.valueOf(AppInfo.AUTHORITY_DENY)};
         db.delete(ManagerDBHelper.AUTH_API_TABLE, where, whereArgs);
     }
}
