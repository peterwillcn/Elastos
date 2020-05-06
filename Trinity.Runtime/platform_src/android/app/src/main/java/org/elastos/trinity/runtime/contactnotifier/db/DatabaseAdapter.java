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

import org.elastos.trinity.runtime.contactnotifier.Contact;
import org.elastos.trinity.runtime.contactnotifier.ContactNotifier;

import java.util.ArrayList;
import java.util.Date;

 public class DatabaseAdapter {
    DatabaseHelper helper;
    Context context;
    ContactNotifier notifier;

    public DatabaseAdapter(ContactNotifier notifier, Context context)
    {
        this.notifier = notifier;
        helper = new DatabaseHelper(context);
        this.context = context;
    }

     public Contact addContact(String didSessionDID, String did, String carrierUserID) {
         SQLiteDatabase db = helper.getWritableDatabase();

         ContentValues contentValues = new ContentValues();
         contentValues.put(DatabaseHelper.DID_SESSION_DID, didSessionDID);
         contentValues.put(DatabaseHelper.DID, did);
         contentValues.put(DatabaseHelper.CARRIER_USER_ID, carrierUserID);
         contentValues.put(DatabaseHelper.NOTIFICATIONS_BLOCKED, false);
         contentValues.put(DatabaseHelper.ADDED_DATE, new Date().getTime()); // Unix timestamp

         db.insertOrThrow(DatabaseHelper.CONTACTS_TABLE, null, contentValues);

         // Return a Contact object for convenience
         return getContactByDID(didSessionDID, did);
     }

     public void updateContactNotificationsBlocked(String didSessionDID, String did, boolean shouldBlockNotifications) {
         SQLiteDatabase db = helper.getWritableDatabase();

         String where = DatabaseHelper.DID_SESSION_DID + "=? AND " + DatabaseHelper.DID + "=?";
         String[] whereArgs = {didSessionDID, did};

         ContentValues contentValues = new ContentValues();
         contentValues.put(DatabaseHelper.NOTIFICATIONS_BLOCKED, shouldBlockNotifications);

         db.update(DatabaseHelper.CONTACTS_TABLE, contentValues, where, whereArgs );
     }

     public Contact getContactByDID(String didSessionDID, String contactDID) {
         SQLiteDatabase db = helper.getWritableDatabase();

         String where = DatabaseHelper.DID_SESSION_DID + "=? AND " + DatabaseHelper.DID + "=?";
         String[] whereArgs = {didSessionDID, contactDID};
         String[] columns = {DatabaseHelper.DID, DatabaseHelper.CARRIER_USER_ID, DatabaseHelper.NOTIFICATIONS_BLOCKED, DatabaseHelper.ADDED_DATE};

         Cursor cursor = db.query(DatabaseHelper.CONTACTS_TABLE, columns, where, whereArgs,null,null,null);
         if (cursor.moveToNext()) {
             return Contact.fromDatabaseCursor(notifier, cursor);
         }

         return null;
     }

     public Contact getContactByCarrierUserID(String didSessionDID, String carrierUserID) {
         SQLiteDatabase db = helper.getWritableDatabase();

         String where = DatabaseHelper.DID_SESSION_DID + "=? AND " + DatabaseHelper.CARRIER_USER_ID + "=?";
         String[] whereArgs = {didSessionDID, carrierUserID};
         String[] columns = {DatabaseHelper.DID, DatabaseHelper.CARRIER_USER_ID, DatabaseHelper.NOTIFICATIONS_BLOCKED, DatabaseHelper.ADDED_DATE};

         Cursor cursor = db.query(DatabaseHelper.CONTACTS_TABLE, columns, where, whereArgs,null,null,null);
         if (cursor.moveToNext()) {
             Contact contact = Contact.fromDatabaseCursor(notifier, cursor);
             return contact;
         }

         return null;
     }

     public void removeContact(String didSessionDID, String contactDID) {
         SQLiteDatabase db = helper.getWritableDatabase();

         String where = DatabaseHelper.DID_SESSION_DID + "=? AND "+DatabaseHelper.DID + "=?";
         String[] whereArgs = {didSessionDID, contactDID};
         db.delete(DatabaseHelper.CONTACTS_TABLE, where, whereArgs);
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

     public void removeSentInvitationByAddress(String didSessionDID, String carrierAddress) {
         SQLiteDatabase db = helper.getWritableDatabase();

         String where = DatabaseHelper.DID_SESSION_DID + "=? AND "+DatabaseHelper.CARRIER_ADDRESS + "=?";
         String[] whereArgs = {didSessionDID, carrierAddress};
         db.delete(DatabaseHelper.SENT_INVITATIONS_TABLE, where, whereArgs);
     }

     public ArrayList<SentInvitation> getAllSentInvitations(String didSessionDID) {
         SQLiteDatabase db = helper.getWritableDatabase();

         String[] columns = {DatabaseHelper.DID, DatabaseHelper.CARRIER_ADDRESS, DatabaseHelper.SENT_DATE};

         ArrayList<SentInvitation> invitations = new ArrayList<>();
         Cursor cursor = db.query(DatabaseHelper.SENT_INVITATIONS_TABLE, columns, null, null,null,null,null);
         if (cursor.moveToNext()) {
             SentInvitation invitation = SentInvitation.fromDatabaseCursor(cursor);
             invitations.add(invitation);
         }

         return invitations;
     }

     public void addReceivedInvitation(String didSessionDID, String contactDID, String contactCarrierUserId) {
         SQLiteDatabase db = helper.getWritableDatabase();

         ContentValues contentValues = new ContentValues();
         contentValues.put(DatabaseHelper.DID_SESSION_DID, didSessionDID);
         contentValues.put(DatabaseHelper.DID, contactDID);
         contentValues.put(DatabaseHelper.CARRIER_USER_ID, contactCarrierUserId);
         contentValues.put(DatabaseHelper.RECEIVED_DATE, new Date().getTime()); // Unix timestamp

         db.insertOrThrow(DatabaseHelper.RECEIVED_INVITATIONS_TABLE, null, contentValues);
     }

     public ReceivedInvitation getReceivedInvitationById(String didSessionDID, String invitationID) {
         SQLiteDatabase db = helper.getWritableDatabase();

         String where = DatabaseHelper.DID_SESSION_DID + "=? AND " + DatabaseHelper.INVITATION_ID + "=?";
         String[] whereArgs = {didSessionDID, invitationID};
         String[] columns = {DatabaseHelper.DID, DatabaseHelper.CARRIER_USER_ID};

         Cursor cursor = db.query(DatabaseHelper.RECEIVED_INVITATIONS_TABLE, columns, where, whereArgs,null,null,null);
         if (cursor.moveToNext()) {
             ReceivedInvitation invitation = ReceivedInvitation.fromDatabaseCursor(cursor);
             return invitation;
         }

         return null;
     }
}
