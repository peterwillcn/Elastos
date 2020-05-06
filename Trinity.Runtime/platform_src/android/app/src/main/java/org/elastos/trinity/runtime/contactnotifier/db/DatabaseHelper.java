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
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

 public class DatabaseHelper extends SQLiteOpenHelper {
     private static final int DATABASE_VERSION = 1;

     // Tables
     private static final String DATABASE_NAME = "contactnotifier.db";
     public static final String CONTACTS_TABLE = "contacts";
     public static final String SENT_INVITATIONS_TABLE = "sentinvitations";
     public static final String RECEIVED_INVITATIONS_TABLE = "receivedinvitations";

     // Tables fields
     public static final String DID_SESSION_DID = "didsessiondid";
     public static final String DID = "did";
     public static final String CARRIER_ADDRESS = "carrieraddress";
     public static final String CARRIER_USER_ID = "carrieruserid";
     public static final String NOTIFICATIONS_BLOCKED = "notificationsblocked";
     public static final String ADDED_DATE = "added";
     public static final String SENT_DATE = "sent";
     public static final String RECEIVED_DATE = "received";

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
         // CONTACTS
         String contactsSQL = "create table " + CONTACTS_TABLE + "(cid integer primary key autoincrement, " +
                 DID_SESSION_DID + " varchar(128), " +
                 DID + " varchar(128), " +
                 CARRIER_USER_ID + " varchar(128), " + // Permanent friend user id to talk (notifications) to him
                 NOTIFICATIONS_BLOCKED + " integer(1)), " + // Whether this contact can send notifications to current user or not
                 ADDED_DATE + " date)";
         db.execSQL(contactsSQL);

         // SENT INVITATIONS
         String sentInvitationsSQL = "create table " + SENT_INVITATIONS_TABLE + "(iid integer primary key autoincrement, " +
                 DID_SESSION_DID + " varchar(128), " +
                 DID + " varchar(128), " +
                 CARRIER_ADDRESS + " varchar(128), " +
                 SENT_DATE + " date)";
         db.execSQL(sentInvitationsSQL);

         // RECEIVED INVITATIONS
         String receivedInvitationsSQL = "create table " + RECEIVED_INVITATIONS_TABLE + "(iid integer primary key autoincrement, " +
                 DID_SESSION_DID + " varchar(128), " +
                 DID + " varchar(128), " +
                 CARRIER_USER_ID + " varchar(128), " +
                 RECEIVED_DATE + " date)";
         db.execSQL(receivedInvitationsSQL);
     }

     @Override
     public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
     }

     @Override
     public void onDowngrade(SQLiteDatabase db, int oldVersion, int newVersion) {
     }
 }
