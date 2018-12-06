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

package org.elastos.trinity.dapprt;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

public class ManagerDBAdapter {
    ManagerDBHelper helper;
    Context context;
    public ManagerDBAdapter(Context context)
    {
        helper = new ManagerDBHelper(context);
        SQLiteDatabase db = helper.getWritableDatabase();
        this.context = context;
    }

    public void clean() {
        SQLiteDatabase db = helper.getWritableDatabase();
        helper.onUpgrade(db, 0, 1);
    }

    public boolean addAppInfo(AppInfo info)
    {
        if (info != null) {
            SQLiteDatabase db = helper.getWritableDatabase();
            ContentValues contentValues = new ContentValues();
            contentValues.put(AppInfo.APP_ID, info.app_id);
            contentValues.put(AppInfo.VERSION, info.version);
            contentValues.put(AppInfo.NAME, info.name);
            contentValues.put(AppInfo.DESCRIPTION, info.description);
            contentValues.put(AppInfo.LAUNCHER_PATH, info.launch_path);
            contentValues.put(AppInfo.BIG_ICON, info.big_icon);
            contentValues.put(AppInfo.SMALL_ICON, info.small_icon);
            contentValues.put(AppInfo.AUTHOR_NAME, info.author_name);
            contentValues.put(AppInfo.AUTHOR_EMAIL, info.author_email);
            contentValues.put(AppInfo.DEFAULT_LOCAL, info.default_locale);
            contentValues.put(AppInfo.BUILT_IN, info.built_in);
            long tid = db.insert(ManagerDBHelper.APP_TABLE, null, contentValues);

            if (tid == -1) {
                return false;
            }
            info.tid = tid;

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
            return true;
        }
        else {
            return false;
        }
    }

    private AppInfo[] getInfos(String selection, String[] selectionArgs) {
        SQLiteDatabase db = helper.getWritableDatabase();
        String[] columns = {AppInfo.TID, AppInfo.APP_ID, AppInfo.VERSION, AppInfo.NAME, AppInfo.DESCRIPTION, AppInfo.LAUNCHER_PATH,
                AppInfo.BIG_ICON, AppInfo.SMALL_ICON, AppInfo.AUTHOR_NAME, AppInfo.AUTHOR_EMAIL,
                AppInfo.DEFAULT_LOCAL, AppInfo.BUILT_IN};
        Cursor cursor = db.query(ManagerDBHelper.APP_TABLE, columns,selection, selectionArgs,null,null,null);
        AppInfo infos[] = new AppInfo[cursor.getCount()];
        int count = 0;
        while (cursor.moveToNext()) {
            AppInfo info = new AppInfo();
            info.tid = cursor.getInt(cursor.getColumnIndex(AppInfo.TID));
            info.app_id = cursor.getString(cursor.getColumnIndex(AppInfo.APP_ID));
            info.version = cursor.getString(cursor.getColumnIndex(AppInfo.VERSION));
            info.name = cursor.getString(cursor.getColumnIndex(AppInfo.NAME));
            info.description = cursor.getString(cursor.getColumnIndex(AppInfo.DESCRIPTION));
            info.launch_path = cursor.getString(cursor.getColumnIndex(AppInfo.LAUNCHER_PATH));
            info.big_icon = cursor.getString(cursor.getColumnIndex(AppInfo.BIG_ICON));
            info.small_icon = cursor.getString(cursor.getColumnIndex(AppInfo.SMALL_ICON));
            info.author_name = cursor.getString(cursor.getColumnIndex(AppInfo.AUTHOR_NAME));
            info.author_email = cursor.getString(cursor.getColumnIndex(AppInfo.AUTHOR_EMAIL));
            info.default_locale = cursor.getString(cursor.getColumnIndex(AppInfo.DEFAULT_LOCAL));
            info.built_in = cursor.getInt(cursor.getColumnIndex(AppInfo.BUILT_IN));
            infos[count++] = info;

            String[] columns1 = {AppInfo.PLUGIN, AppInfo.AUTHORITY};
            String[] args1 = {String.valueOf(info.tid)};

            Cursor cursor1 = db.query(ManagerDBHelper.AUTH_PLUGIN_TABLE, columns1,AppInfo.APP_TID + "=?", args1,null,null,null);
            while (cursor1.moveToNext()) {
                info.addPlugin(cursor1.getString(cursor1.getColumnIndex(AppInfo.PLUGIN)), cursor1.getInt(cursor1.getColumnIndex(AppInfo.AUTHORITY)));
            }

            String[] columns2 = {AppInfo.URL, AppInfo.AUTHORITY};
            cursor1 = db.query(ManagerDBHelper.AUTH_URL_TABLE, columns2,AppInfo.APP_TID + "=?", args1,null,null,null);
            while (cursor1.moveToNext()) {
                info.addUrl(cursor1.getString(cursor1.getColumnIndex(AppInfo.URL)), cursor1.getInt(cursor1.getColumnIndex(AppInfo.AUTHORITY)));
            }
        }
        return infos;
    }

    public AppInfo getAppInfo(String id)
    {
        String selection = AppInfo.APP_ID + "=?";
        String[] args = {String.valueOf(id)};
        AppInfo infos[] = getInfos(selection, args);
        if (infos.length > 0) {
            return infos[0];
        }
        else {
            return null;
        }
    }

    public AppInfo[] getAppInfos()
    {
        return getInfos(null, null);
    }

    public int deleteApp(int tid)
    {
        SQLiteDatabase db = helper.getWritableDatabase();
        String[] whereArgs ={String.valueOf(tid)};

        db.delete(ManagerDBHelper.AUTH_PLUGIN_TABLE ,AppInfo.APP_TID + " = ?", whereArgs);
        db.delete(ManagerDBHelper.AUTH_URL_TABLE ,AppInfo.APP_TID + " = ?", whereArgs);
        db.delete(ManagerDBHelper.APP_TABLE ,AppInfo.TID + " = ?", whereArgs);

        return  0;
    }

    public int updatePluginAuth(long tid, String plugin, int authority)
    {
        SQLiteDatabase db = helper.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put(AppInfo.AUTHORITY, authority);
        String where = AppInfo.APP_TID + "=? AND " + AppInfo.PLUGIN + "=?";
        String[] whereArgs= {String.valueOf(tid), plugin};
        int count = db.update(ManagerDBHelper.AUTH_PLUGIN_TABLE, contentValues, where, whereArgs );
        return count;
    }

    public int updateURLAuth(long tid, String url, int authority)
    {
        SQLiteDatabase db = helper.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put(AppInfo.AUTHORITY, authority);
        String where = AppInfo.APP_TID + "=? AND " + AppInfo.URL + "=?";
        String[] whereArgs= {String.valueOf(tid), url};
        int count =db.update(ManagerDBHelper.AUTH_URL_TABLE, contentValues, where, whereArgs );
        return count;
    }

    public int removeAppInfo(AppInfo info)
    {
        SQLiteDatabase db = helper.getWritableDatabase();
        String where = AppInfo.APP_TID + "=?";
        String[] whereArgs= {String.valueOf(info.tid)};
        int count = db.delete(ManagerDBHelper.AUTH_URL_TABLE, where, whereArgs);
        count = db.delete(ManagerDBHelper.AUTH_PLUGIN_TABLE, where, whereArgs);
        where = AppInfo.TID + "=?";
        count = db.delete(ManagerDBHelper.APP_TABLE, where, whereArgs);
        return count;
    }
}
