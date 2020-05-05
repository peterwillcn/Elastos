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

package org.elastos.trinity.runtime.contactnotifier.db;

import android.content.Context;
import android.database.SQLException;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

import org.elastos.trinity.runtime.AppInfo;

 public class DatabaseHelper extends SQLiteOpenHelper {
     private static final int DATABASE_VERSION = 1;

     // Tables
     private static final String DATABASE_NAME = "contactnotifier.db";
     public static final String CONTACTS_TABLE = "contacts";

     // Tables fields
     public static final String DID_SESSION_DID = "didsessiondid";
     public static final String CONTACT_DID = "did";
     public static final String CONTACT_CARRIER_ADDRESS = "carrieraddress";

     public static final String KEY = "key";
     public static final String VALUE = "value";

     public DatabaseHelper(Context context) {
         super(context, DATABASE_NAME, null, DATABASE_VERSION);
     }

     public DatabaseHelper(Context context, String name, SQLiteDatabase.CursorFactory factory, int version) {
         super(context, name, factory, version);
     }

      @Override
     public void onCreate(SQLiteDatabase db) {
         String strSQL = "create table " + CONTACTS_TABLE + "(tid integer primary key autoincrement, " +
                 "TODO"+
                 AppInfo.APP_TID + " integer, " +
                 AppInfo.PLUGIN + " varchar(128), " +
                 AppInfo.AUTHORITY + " integer)";
         db.execSQL(strSQL);
     }

     public void debugDropAllTables(SQLiteDatabase db) {
         db.execSQL("DROP TABLE IF EXISTS " + CONTACTS_TABLE);
     }

     @Override
     public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {

     }

     @Override
     public void onDowngrade(SQLiteDatabase db, int oldVersion, int newVersion) {
         // We need to override on downgrade otherwise if somehow the android phone tries to downgrade the database
         // (happened to KP many times - unknown reason - 2020.03), then we get a crash
     }
 }
