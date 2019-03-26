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

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

public class ManagerDBHelper extends SQLiteOpenHelper {
    private static final String DATABASE_NAME = "manager.db";
    private static final int VERSION = 1;
    public static final String AUTH_PLUGIN_TABLE = "auth_plugin";
    public static final String AUTH_URL_TABLE = "auth_url";
    public static final String AUTH_ICONS_TABLE = "icons";
    public static final String APP_TABLE = "app";

    public ManagerDBHelper(Context context) {
        super(context, DATABASE_NAME, null, VERSION);
    }

    public ManagerDBHelper(Context context, String name, SQLiteDatabase.CursorFactory factory, int version) {
        super(context, name, factory, version);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        String strSQL = "create table " + AUTH_PLUGIN_TABLE + "(tid integer primary key autoincrement, " +
                AppInfo.APP_TID + " integer, " +
                AppInfo.PLUGIN + " varchar(128), " +
                AppInfo.AUTHORITY + " integer)";
        db.execSQL(strSQL);

        strSQL =  "create table " + AUTH_URL_TABLE + "(tid integer primary key autoincrement, " +
                AppInfo.APP_TID + " integer, " +
                AppInfo.URL + " varchar(256), " +
                AppInfo.AUTHORITY + " integer)";
        db.execSQL(strSQL);

        strSQL =  "create table " + AUTH_ICONS_TABLE + "(tid integer primary key autoincrement, " +
                AppInfo.APP_TID + " integer, " +
                AppInfo.SRC + " varchar(256), " +
                AppInfo.SIZES + " varchar(32), " +
                AppInfo.TYPE + " varchar(32))";
        db.execSQL(strSQL);

        strSQL = "create table " + APP_TABLE + "(tid integer primary key autoincrement, " +
                AppInfo.APP_ID + " varchar(128) UNIQUE NOT NULL, " +
                AppInfo.VERSION + " varchar(32) NOT NULL, " +
                AppInfo.NAME + " varchar(128) NOT NULL, " +
                AppInfo.SHORT_NAME + " varchar(64), " +
                AppInfo.DESCRIPTION + " varchar(256), " +
                AppInfo.START_URL + " varchar(256) NOT NULL, " +
                AppInfo.AUTHOR_NAME + " varchar(128), " +
                AppInfo.AUTHOR_EMAIL + " varchar(128), " +
                AppInfo.DEFAULT_LOCAL + " varchar(16), " +
                AppInfo.BACKGROUND_COLOR + " varchar(32), " +
                AppInfo.THEME_DISPLAY + " varchar(32), " +
                AppInfo.THEME_COLOR + " varchar(32), " +
                AppInfo.THEME_FONT_NAME + " varchar(64), " +
                AppInfo.THEME_FONT_COLOR + " varchar(32), " +
                AppInfo.INSTALL_TIME + " integer, " +
                AppInfo.BUILT_IN + " integer)";
        db.execSQL(strSQL);
    }

    public void dropAllTabel(SQLiteDatabase db) {
        db.execSQL("DROP TABLE IF EXISTS " + AUTH_PLUGIN_TABLE);
        db.execSQL("DROP TABLE IF EXISTS " + AUTH_URL_TABLE);
        db.execSQL("DROP TABLE IF EXISTS " + AUTH_ICONS_TABLE);
        db.execSQL("DROP TABLE IF EXISTS " + APP_TABLE);
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        // Drop older table if existed, all data will be gone!!!

        dropAllTabel(db);
        // Create tables again
        onCreate(db);
    }
}
