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

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

import org.elastos.trinity.runtime.AppInfo;
import org.elastos.trinity.runtime.contactnotifier.Contact;

import java.util.Date;

 public class DatabaseAdapter {
    DatabaseHelper helper;
    Context context;

    public DatabaseAdapter(Context context)
    {
        helper = new DatabaseHelper(context);
        //SQLiteDatabase db = helper.getWritableDatabase();
        this.context = context;
    }

     public void addContact(String didSessionDID, String did, String carrierUserID) {
         SQLiteDatabase db = helper.getWritableDatabase();

         ContentValues contentValues = new ContentValues();
         contentValues.put(DatabaseHelper.DID_SESSION_DID, didSessionDID);
         contentValues.put(DatabaseHelper.DID, did);
         contentValues.put(DatabaseHelper.CARRIER_USER_ID, carrierUserID);
         contentValues.put(DatabaseHelper.NOTIFICATIONS_BLOCKED, false);
         contentValues.put(DatabaseHelper.ADDED_DATE, new Date().getTime()); // Unix timestamp
         db.insertOrThrow(DatabaseHelper.CONTACTS_TABLE, null, contentValues);
     }

     public void updateContact() {

     }

     public Contact getContact(String didSessionDID, String contactDID) {
         SQLiteDatabase db = helper.getWritableDatabase();
         String where = DatabaseHelper.DID_SESSION_DID + "=? AND " + DatabaseHelper.DID + "=?";
         String[] whereArgs = {didSessionDID, contactDID};
         String[] columns = {AppInfo.AUTHORITY};
         Cursor cursor = db.query(DatabaseHelper.CONTACTS_TABLE, columns, where, whereArgs,null,null,null);
         if (cursor.moveToNext()) {
             Contact contact = Contact.fromDatabaseCursor(cursor);
             return contact;
         }

         return null;
     }

     public void removeContact(String didSessionDID, String contactDID) {
        // TODO
     }

     public void addSentInvitation(String didSessionDID, String targetDID, String targetCarrierAddress) {
         SQLiteDatabase db = helper.getWritableDatabase();

         ContentValues contentValues = new ContentValues();
         contentValues.put(DatabaseHelper.DID_SESSION_DID, didSessionDID);
         contentValues.put(DatabaseHelper.DID, targetDID);
         contentValues.put(DatabaseHelper.CARRIER_ADDRESS, targetCarrierAddress);
         contentValues.put(DatabaseHelper.SENT_DATE, new Date().getTime()); // Unix timestamp
         db.insertOrThrow(DatabaseHelper.SENT_INVITATIONS_TABLE, null, contentValues);
     }
}
