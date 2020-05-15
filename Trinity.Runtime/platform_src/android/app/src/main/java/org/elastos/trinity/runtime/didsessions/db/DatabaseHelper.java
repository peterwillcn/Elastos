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

 package org.elastos.trinity.runtime.didsessions.db;

 import android.content.Context;
 import android.database.sqlite.SQLiteDatabase;
 import android.database.sqlite.SQLiteOpenHelper;

 public class DatabaseHelper extends SQLiteOpenHelper {
     private static final int DATABASE_VERSION = 1;

     // Tables
     private static final String DATABASE_NAME = "didsessions.db";
     public static final String DIDSESSIONS_TABLE = "didsessions";

     // Tables fields
     public static final String DIDSESSION_DIDSTOREID = "didstoreid";
     public static final String DIDSESSION_DIDSTRING = "didstring";
     public static final String DIDSESSION_NAME = "name";
     public static final String DIDSESSION_SIGNEDIN = "signedin";
     public static final String DIDSESSION_AVATAR_CONTENTTYPE = "avatar_contenttype";
     public static final String DIDSESSION_AVATAR_DATA = "avatar_data";

     public DatabaseHelper(Context context) {
         super(context, DATABASE_NAME, null, DATABASE_VERSION);
     }

     public DatabaseHelper(Context context, String name, SQLiteDatabase.CursorFactory factory, int version) {
         super(context, name, factory, version);
     }

     @Override
     public void onCreate(SQLiteDatabase db) {
         String strSQL =  "create table " + DIDSESSIONS_TABLE + "(tid integer primary key autoincrement, " +
                 DIDSESSION_DIDSTOREID + " varchar(32) NOT NULL, " +
                 DIDSESSION_DIDSTRING + " varchar(128) NOT NULL, " +
                 DIDSESSION_NAME + " varchar(128), " +
                 DIDSESSION_SIGNEDIN + " integer, "+
                 DIDSESSION_AVATAR_CONTENTTYPE + " varchar(32), " +
                 DIDSESSION_AVATAR_DATA + " blob)";
         db.execSQL(strSQL);
     }

     @Override
     public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
     }

     @Override
     public void onDowngrade(SQLiteDatabase db, int oldVersion, int newVersion) {
     }
 }
