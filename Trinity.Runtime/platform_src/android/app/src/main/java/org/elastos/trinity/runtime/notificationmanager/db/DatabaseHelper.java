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

package org.elastos.trinity.runtime.notificationmanager.db;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

 public class DatabaseHelper extends SQLiteOpenHelper {
     private static final int DATABASE_VERSION = 1;

     // Tables
     private static final String DATABASE_NAME = "notificationmanager.db";
     public static final String NOTIFICATION_TABLE = "notification";

     // Tables fields
     public static final String NOTIFICATION_ID = "notificationid";
     public static final String KEY = "notificationkey";
     public static final String TITLE = "title";
     public static final String URL = "url";
     public static final String EMITTER = "emitter";
     public static final String APP_ID = "appid";
     public static final String SENT_DATE = "sent";

     public DatabaseHelper(Context context) {
         super(context, DATABASE_NAME, null, DATABASE_VERSION);
     }

     public DatabaseHelper(Context context, String name, SQLiteDatabase.CursorFactory factory, int version) {
         super(context, name, factory, version);
     }

     @Override
     public void onCreate(SQLiteDatabase db) {
         // notification
         String notificationSQL = "create table " + NOTIFICATION_TABLE + "(" + NOTIFICATION_ID + " integer primary key autoincrement, " +
                 KEY + " varchar(128), " +
                 TITLE + " varchar(128), " +
                 URL + " varchar(128), " +
                 EMITTER + " varchar(128), " +
                 APP_ID + " varchar(128), " +
                 SENT_DATE + " date)";
         db.execSQL(notificationSQL);
     }

     @Override
     public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
     }

     @Override
     public void onDowngrade(SQLiteDatabase db, int oldVersion, int newVersion) {
     }
 }
