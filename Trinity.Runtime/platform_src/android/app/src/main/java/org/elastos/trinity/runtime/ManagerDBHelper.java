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
import android.database.SQLException;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

public class ManagerDBHelper extends SQLiteOpenHelper {
    private static final int DATABASE_VERSION = 5;

    private static final String DATABASE_NAME = "manager.db";
    public static final String AUTH_PLUGIN_TABLE = "auth_plugin";
    public static final String AUTH_URL_TABLE = "auth_url";
    public static final String AUTH_INTENT_TABLE = "auth_intent";
    public static final String ICONS_TABLE = "icons";
    public static final String LACALE_TABLE = "locale";
    public static final String FRAMEWORK_TABLE = "framework";
    public static final String PLATFORM_TABLE = "platform";
    public static final String SETTING_TABLE = "setting";
    public static final String PREFERENCE_TABLE = "preference";
    public static final String INTENT_FILTER_TABLE = "intent";
    public static final String APP_TABLE = "app";
    public static final String DIDSESSIONS_TABLE = "didsessions";

    public static final String KEY = "key";
    public static final String VALUE = "value";

    public static final String DIDSESSION_DIDSTOREID = "didstoreid";
    public static final String DIDSESSION_DIDSTRING = "didstring";
    public static final String DIDSESSION_NAME = "name";
    public static final String DIDSESSION_SIGNEDIN = "signedin";

    public ManagerDBHelper(Context context) {
        super(context, DATABASE_NAME, null, DATABASE_VERSION);
    }

    public ManagerDBHelper(Context context, String name, SQLiteDatabase.CursorFactory factory, int version) {
        super(context, name, factory, version);
    }

     @Override
    public void onCreate(SQLiteDatabase db) {

//        String strSQL = "create table " + SETTING_TABLE + "(tid integer primary key autoincrement, " +
//                "current_locale varchar(16))";
//        db.execSQL(strSQL);

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

        strSQL =  "create table " + AUTH_INTENT_TABLE + "(tid integer primary key autoincrement, " +
                AppInfo.APP_TID + " integer, " +
                AppInfo.URL + " varchar(256), " +
                AppInfo.AUTHORITY + " integer)";
        db.execSQL(strSQL);

        strSQL =  "create table " + ICONS_TABLE + "(tid integer primary key autoincrement, " +
                AppInfo.APP_TID + " integer, " +
                AppInfo.SRC + " varchar(256), " +
                AppInfo.SIZES + " varchar(32), " +
                AppInfo.TYPE + " varchar(32))";
        db.execSQL(strSQL);

        strSQL = "create table " + LACALE_TABLE + "(tid integer primary key autoincrement, " +
                AppInfo.APP_TID + " integer, " +
                AppInfo.LANGUAGE + " varchar(32) NOT NULL, " +
                AppInfo.NAME + " varchar(128), " +
                AppInfo.SHORT_NAME + " varchar(64), " +
                AppInfo.DESCRIPTION + " varchar(256), " +
                AppInfo.AUTHOR_NAME + " varchar(128))";
        db.execSQL(strSQL);

        strSQL =  "create table " + FRAMEWORK_TABLE + "(tid integer primary key autoincrement, " +
                AppInfo.APP_TID + " integer, " +
                AppInfo.NAME + " varchar(64) NOT NULL, " +
                AppInfo.VERSION + " varchar(32))";
        db.execSQL(strSQL);

        strSQL =  "create table " + PLATFORM_TABLE + "(tid integer primary key autoincrement, " +
                AppInfo.APP_TID + " integer, " +
                AppInfo.NAME + " varchar(64) NOT NULL, " +
                AppInfo.VERSION + " varchar(32))";
        db.execSQL(strSQL);

        strSQL =  "create table " + INTENT_FILTER_TABLE + "(tid integer primary key autoincrement, " +
                AppInfo.APP_ID + " varchar(128) NOT NULL, " +
                AppInfo.ACTION + " varchar(64) NOT NULL)";
        db.execSQL(strSQL);

        strSQL =  "create table " + SETTING_TABLE + "(tid integer primary key autoincrement, " +
             AppInfo.APP_ID + " varchar(128) NOT NULL, " +
             KEY + " varchar(128) NOT NULL, " +
             VALUE + " varchar(2048) NOT NULL)";
        db.execSQL(strSQL);

        strSQL =  "create table " + PREFERENCE_TABLE + "(tid integer primary key autoincrement, " +
             KEY + " varchar(128) NOT NULL, " +
             VALUE + " varchar(2048) NOT NULL)";
        db.execSQL(strSQL);

        strSQL =  "create table " + DIDSESSIONS_TABLE + "(tid integer primary key autoincrement, " +
                DIDSESSION_DIDSTOREID + " varchar(32) NOT NULL, " +
                DIDSESSION_DIDSTRING + " varchar(128) NOT NULL, " +
                DIDSESSION_NAME + " varchar(128), " +
                DIDSESSION_SIGNEDIN + " integer)";
        db.execSQL(strSQL);

        strSQL = "create table " + APP_TABLE + "(tid integer primary key autoincrement, " +
                AppInfo.APP_ID + " varchar(128) UNIQUE NOT NULL, " +
                AppInfo.VERSION + " varchar(32) NOT NULL, " +
                AppInfo.VERSION_CODE + " integer, " +
                AppInfo.NAME + " varchar(128) NOT NULL, " +
                AppInfo.SHORT_NAME + " varchar(64), " +
                AppInfo.DESCRIPTION + " varchar(256), " +
                AppInfo.START_URL + " varchar(256) NOT NULL, " +
                AppInfo.START_VISIBLE + " varchar(32), " +
                AppInfo.TYPE + " varchar(16) NOT NULL, " +
                AppInfo.AUTHOR_NAME + " varchar(128), " +
                AppInfo.AUTHOR_EMAIL + " varchar(128), " +
                AppInfo.DEFAULT_LOCAL + " varchar(16), " +
                AppInfo.BACKGROUND_COLOR + " varchar(32), " +
                AppInfo.THEME_DISPLAY + " varchar(32), " +
                AppInfo.THEME_COLOR + " varchar(32), " +
                AppInfo.THEME_FONT_NAME + " varchar(64), " +
                AppInfo.THEME_FONT_COLOR + " varchar(32), " +
                AppInfo.INSTALL_TIME + " integer, " +
                AppInfo.BUILT_IN + " integer, " +
                AppInfo.REMOTE + " integer, " +
                AppInfo.LAUNCHER + " integer," +
                AppInfo.CATEGORY + " varchar(64), " +
                AppInfo.KEY_WORDS + " varchar(512))";
        db.execSQL(strSQL);
    }

    public void dropAllTable(SQLiteDatabase db) {
        db.execSQL("DROP TABLE IF EXISTS " + AUTH_PLUGIN_TABLE);
        db.execSQL("DROP TABLE IF EXISTS " + AUTH_URL_TABLE);
        db.execSQL("DROP TABLE IF EXISTS " + AUTH_INTENT_TABLE);
        db.execSQL("DROP TABLE IF EXISTS " + ICONS_TABLE);
        db.execSQL("DROP TABLE IF EXISTS " + LACALE_TABLE);
        db.execSQL("DROP TABLE IF EXISTS " + FRAMEWORK_TABLE);
        db.execSQL("DROP TABLE IF EXISTS " + PLATFORM_TABLE);
        db.execSQL("DROP TABLE IF EXISTS " + INTENT_FILTER_TABLE);
        db.execSQL("DROP TABLE IF EXISTS " + SETTING_TABLE);
        db.execSQL("DROP TABLE IF EXISTS " + PREFERENCE_TABLE);
        db.execSQL("DROP TABLE IF EXISTS " + APP_TABLE);
        db.execSQL("DROP TABLE IF EXISTS " + DIDSESSIONS_TABLE);
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        // Use the if (old < N) format to make sure users get all upgrades even if they directly upgrade from vN to v(N+5)
        if (oldVersion < 3) {
           Log.d("ManagerDBHelper", "Upgrading database to v3");
           upgradeToV3(db);
        }
        if (oldVersion < 4) {
            Log.d("ManagerDBHelper", "Upgrading database to v4");
            upgradeToV4(db);
        }
        if (oldVersion < 5) {
            Log.d("ManagerDBHelper", "Upgrading database to v5");
            upgradeToV5(db);
        }
    }

    @Override
    public void onDowngrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        // We need to override on downgrade otherwise if somehow the android phone tries to downgrade the database
        // (happened to KP many times - unknown reason - 2020.03), then we get a crash
    }

    // 20191230 - Added "start_visible" field
    private void upgradeToV3(SQLiteDatabase db) {
        try {
            String strSQL = "ALTER TABLE " + APP_TABLE + " ADD COLUMN " + AppInfo.START_VISIBLE + " varchar(32) default 'show'";
            db.execSQL(strSQL);
        } catch (SQLException e) {
            e.printStackTrace();
            // Do nothing, intercept SQL errors - in case we try to apply an upgrade again after a strange downgrade from android
            // (happened to KP many times - unknown reason - 2020.03)
        }
    }

    // 20200311 - Added "setting and preference table"
    private void upgradeToV4(SQLiteDatabase db) {
        try {
            String strSQL = "create table " + SETTING_TABLE + "(tid integer primary key autoincrement, " +
                    AppInfo.APP_ID + " varchar(128) NOT NULL, " +
                    KEY + " varchar(128) NOT NULL, " +
                    VALUE + " varchar(2048) NOT NULL)";
            db.execSQL(strSQL);

            strSQL = "create table " + PREFERENCE_TABLE + "(tid integer primary key autoincrement, " +
                    KEY + " varchar(128) NOT NULL, " +
                    VALUE + " varchar(2048) NOT NULL)";
            db.execSQL(strSQL);
        } catch (SQLException e) {
            e.printStackTrace();
            // Do nothing, intercept SQL errors - in case we try to apply an upgrade again after a strange downgrade from android
            // (happened to KP many times - unknown reason - 2020.03)
        }
    }

    // 20200407 - Added DID sessions
    private void upgradeToV5(SQLiteDatabase db) {
        try {
            String strSQL =  "create table " + DIDSESSIONS_TABLE + "(tid integer primary key autoincrement, " +
                    DIDSESSION_DIDSTOREID + " varchar(32) NOT NULL, " +
                    DIDSESSION_DIDSTRING + " varchar(128) NOT NULL, " +
                    DIDSESSION_NAME + " varchar(128), " +
                    DIDSESSION_SIGNEDIN + " integer)";
            db.execSQL(strSQL);
        } catch (SQLException e) {
            e.printStackTrace();
            // Do nothing, intercept SQL errors - in case we try to apply an upgrade again after a strange downgrade from android
            // (happened to KP many times - unknown reason - 2020.03)
        }
    }

}
