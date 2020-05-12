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

import SQLite
 
public class CNDatabaseAdapter {
    let helper: CNDatabaseHelper
    let notifier: ContactNotifier
    
    // Tables
    let contacts = Table(CNDatabaseHelper.CONTACTS_TABLE)

    // Fields
    let tidField = Expression<Int64>(AppInfo.TID)
    public let didSessionDIDField = Expression<String>(CNDatabaseHelper.DID_SESSION_DID)
    public let didField = Expression<String>(CNDatabaseHelper.DID)
    public let carrierAddressField = Expression<String>(CNDatabaseHelper.CARRIER_ADDRESS)
    public let carrierUserIdField = Expression<String>(CNDatabaseHelper.CARRIER_USER_ID)
    public let notificationsBlockedField = Expression<Bool>(CNDatabaseHelper.NOTIFICATIONS_BLOCKED)
    public let addedDateField = Expression<Int64>(CNDatabaseHelper.ADDED_DATE)
    public let invitationIdField = Expression<Int64>(CNDatabaseHelper.INVITATION_ID)
    
    public init(notifier: ContactNotifier)
    {
        self.notifier = notifier
        helper = CNDatabaseHelper()
    }

    public func addContact(didSessionDID: String, did: String, carrierUserID: String, completion: (_ contact: Contact?)->Void) throws {
        let db = try helper.getDatabase()
        
        try! db.transaction {
            try db.run(contacts.insert(
                didSessionDIDField <- didSessionDID,
                didField <- did,
                carrierUserIdField <- carrierUserID,
                notificationsBlockedField <- false,
                addedDateField <- Int64(Date().timeIntervalSince1970)
            ))
            
            try! getContactByDID(didSessionDID: didSessionDID, contactDID: did) { contact in
                completion(contact)
            }
        }
     }

    public func updateContactNotificationsBlocked(didSessionDID: String, did: String, shouldBlockNotifications: Bool) {
         /* TODO SQLiteDatabase db = helper.getWritableDatabase();

         String where = DatabaseHelper.DID_SESSION_DID + "=? AND " + DatabaseHelper.DID + "=?";
         String[] whereArgs = {didSessionDID, did};

         ContentValues contentValues = new ContentValues();
         contentValues.put(DatabaseHelper.NOTIFICATIONS_BLOCKED, shouldBlockNotifications);

         db.update(DatabaseHelper.CONTACTS_TABLE, contentValues, where, whereArgs );*/
     }

    public func getContactByDID(didSessionDID: String, contactDID: String, completion: (_ contact: Contact?)->Void) throws {
         /* TODO SQLiteDatabase db = helper.getWritableDatabase();

         String where = DatabaseHelper.DID_SESSION_DID + "=? AND " + DatabaseHelper.DID + "=?";
         String[] whereArgs = {didSessionDID, contactDID};
         String[] columns = {DatabaseHelper.DID, DatabaseHelper.CARRIER_USER_ID, DatabaseHelper.NOTIFICATIONS_BLOCKED, DatabaseHelper.ADDED_DATE};

         Cursor cursor = db.query(DatabaseHelper.CONTACTS_TABLE, columns, where, whereArgs,null,null,null);
         if (cursor.moveToNext()) {
             return Contact.fromDatabaseCursor(notifier, cursor);
         }

         return null;*/
        
        let db = try helper.getDatabase()
        try! db.transaction {
            let query = contacts.select(*)
                .filter(didSessionDIDField == didSessionDID && didField == contactDID)
            let contactRows = try! db.prepare(query)
            for row in contactRows {
                completion(Contact.fromDatabaseRow(notifier: notifier, row: row))
            }
        }
     }

    public func getContactByCarrierUserID(didSessionDID: String, carrierUserID: String, completion: (Contact?)->Void){
         /* TODOSQLiteDatabase db = helper.getWritableDatabase();

         String where = DatabaseHelper.DID_SESSION_DID + "=? AND " + DatabaseHelper.CARRIER_USER_ID + "=?";
         String[] whereArgs = {didSessionDID, carrierUserID};
         String[] columns = {DatabaseHelper.DID, DatabaseHelper.CARRIER_USER_ID, DatabaseHelper.NOTIFICATIONS_BLOCKED, DatabaseHelper.ADDED_DATE};

         Cursor cursor = db.query(DatabaseHelper.CONTACTS_TABLE, columns, where, whereArgs,null,null,null);
         if (cursor.moveToNext()) {
             Contact contact = Contact.fromDatabaseCursor(notifier, cursor);
             return contact;
         }

         return null;*/
     }

    public func removeContact(didSessionDID: String, contactDID: String) {
         /* TODOSQLiteDatabase db = helper.getWritableDatabase();

         String where = DatabaseHelper.DID_SESSION_DID + "=? AND "+DatabaseHelper.DID + "=?";
         String[] whereArgs = {didSessionDID, contactDID};
         db.delete(DatabaseHelper.CONTACTS_TABLE, where, whereArgs);*/
     }

    public func addSentInvitation(didSessionDID: String, targetDID: String, targetCarrierAddress: String) {
         /* TODOSQLiteDatabase db = helper.getWritableDatabase();

         ContentValues contentValues = new ContentValues();
         contentValues.put(DatabaseHelper.DID_SESSION_DID, didSessionDID);
         contentValues.put(DatabaseHelper.DID, targetDID);
         contentValues.put(DatabaseHelper.CARRIER_ADDRESS, targetCarrierAddress);
         contentValues.put(DatabaseHelper.SENT_DATE, new Date().getTime()); // Unix timestamp

         db.insertOrThrow(DatabaseHelper.SENT_INVITATIONS_TABLE, null, contentValues);*/
     }

    public func removeSentInvitationByAddress(didSessionDID: String, carrierAddress: String) {
         /* TODOSQLiteDatabase db = helper.getWritableDatabase();

         String where = DatabaseHelper.DID_SESSION_DID + "=? AND "+DatabaseHelper.CARRIER_ADDRESS + "=?";
         String[] whereArgs = {didSessionDID, carrierAddress};
         db.delete(DatabaseHelper.SENT_INVITATIONS_TABLE, where, whereArgs);*/
     }

    public func getAllSentInvitations(didSessionDID: String, completion: (([SentInvitation]?)->Void)){
         /* TODOSQLiteDatabase db = helper.getWritableDatabase();

         String[] columns = {DatabaseHelper.DID, DatabaseHelper.CARRIER_ADDRESS, DatabaseHelper.SENT_DATE};

         ArrayList<SentInvitation> invitations = new ArrayList<>();
         Cursor cursor = db.query(DatabaseHelper.SENT_INVITATIONS_TABLE, columns, null, null,null,null,null);
         if (cursor.moveToNext()) {
             SentInvitation invitation = SentInvitation.fromDatabaseCursor(cursor);
             invitations.add(invitation);
         }

         return invitations;*/
     }

    public func addReceivedInvitation(didSessionDID: String, contactDID: String, contactCarrierUserId: String, completion: (_ insertedId: Int)->Void) {
         /* TODOSQLiteDatabase db = helper.getWritableDatabase();

         ContentValues contentValues = new ContentValues();
         contentValues.put(DatabaseHelper.DID_SESSION_DID, didSessionDID);
         contentValues.put(DatabaseHelper.DID, contactDID);
         contentValues.put(DatabaseHelper.CARRIER_USER_ID, contactCarrierUserId);
         contentValues.put(DatabaseHelper.RECEIVED_DATE, new Date().getTime()); // Unix timestamp

         return db.insertOrThrow(DatabaseHelper.RECEIVED_INVITATIONS_TABLE, null, contentValues);*/
     }

    public func getReceivedInvitationById(didSessionDID: String, invitationID: String, completion:(ReceivedInvitation?)->Void) {
         /* TODOSQLiteDatabase db = helper.getWritableDatabase();

         String where = DatabaseHelper.DID_SESSION_DID + "=? AND " + DatabaseHelper.INVITATION_ID + "=?";
         String[] whereArgs = {didSessionDID, invitationID};
         String[] columns = {DatabaseHelper.DID, DatabaseHelper.CARRIER_USER_ID};

         Cursor cursor = db.query(DatabaseHelper.RECEIVED_INVITATIONS_TABLE, columns, where, whereArgs,null,null,null);
         if (cursor.moveToNext()) {
             ReceivedInvitation invitation = ReceivedInvitation.fromDatabaseCursor(cursor);
             return invitation;
         }

         return null;*/
     }

    public func removeReceivedInvitation(didSessionDID: String, invitationId: String) {
         /* TODOSQLiteDatabase db = helper.getWritableDatabase();

         String where = DatabaseHelper.DID_SESSION_DID + "=? AND "+DatabaseHelper.INVITATION_ID + "=?";
         String[] whereArgs = {didSessionDID, invitationId};
         db.delete(DatabaseHelper.RECEIVED_INVITATIONS_TABLE, where, whereArgs);*/
     }
}
