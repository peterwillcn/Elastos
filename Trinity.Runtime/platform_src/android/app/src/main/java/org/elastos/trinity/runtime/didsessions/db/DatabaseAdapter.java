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

 import android.content.ContentValues;
 import android.content.Context;
 import android.database.Cursor;
 import android.database.sqlite.SQLiteDatabase;

 import org.elastos.trinity.runtime.didsessions.IdentityAvatar;
 import org.elastos.trinity.runtime.didsessions.IdentityEntry;

 import java.util.ArrayList;

 public class DatabaseAdapter {
     DatabaseHelper helper;
     Context context;

     public DatabaseAdapter(Context context)
     {
         helper = new DatabaseHelper(context);
         this.context = context;
     }

     public long addDIDSessionIdentityEntry(IdentityEntry entry) throws Exception {
         // No upsert in sqlite-android. Check if we have this identity entry already or not (a bit slow but ok, not many DID entries)
         ArrayList<IdentityEntry> existingEntries = getDIDSessionIdentityEntries();

         // Check if the given entry exists in the list or not. If it exists, update it. Otherwise, insert it
         boolean entryExists = false;
         for (IdentityEntry e : existingEntries) {
             if (e.didStoreId.equals(entry.didStoreId) && e.didString.equals(entry.didString)) {
                 // Already exists - so we update it
                 entryExists = true;
                 break;
             }
         }

         SQLiteDatabase db = helper.getWritableDatabase();
         if (entryExists) {
             // Update
             String where = DatabaseHelper.DIDSESSION_DIDSTOREID + "=? AND "+DatabaseHelper.DIDSESSION_DIDSTRING + "=?";
             String[] whereArgs = {entry.didStoreId, entry.didString};

             ContentValues contentValues = new ContentValues();
             // For now only NAME can change, as STORE ID and DID STRING are use as unique IDs
             contentValues.put(DatabaseHelper.DIDSESSION_NAME, entry.name);
             return db.update(DatabaseHelper.DIDSESSIONS_TABLE, contentValues, where, whereArgs );
         }
         else {
             // Insert
             ContentValues contentValues = new ContentValues();
             contentValues.put(DatabaseHelper.DIDSESSION_DIDSTOREID, entry.didStoreId);
             contentValues.put(DatabaseHelper.DIDSESSION_DIDSTRING, entry.didString);
             contentValues.put(DatabaseHelper.DIDSESSION_NAME, entry.name);
             contentValues.put(DatabaseHelper.DIDSESSION_SIGNEDIN, 0);
             return db.insert(DatabaseHelper.DIDSESSIONS_TABLE, null, contentValues);
         }
     }

     public void deleteDIDSessionIdentityEntry(String didString) throws Exception {
         SQLiteDatabase db = helper.getWritableDatabase();
         String where = DatabaseHelper.DIDSESSION_DIDSTRING + "=?";
         String[] whereArgs = {didString};
         db.delete(DatabaseHelper.DIDSESSIONS_TABLE, where, whereArgs);
     }

     public ArrayList<IdentityEntry> getDIDSessionIdentityEntries() throws Exception {
         SQLiteDatabase db = helper.getWritableDatabase();
         String[] columns = {DatabaseHelper.DIDSESSION_DIDSTOREID, DatabaseHelper.DIDSESSION_DIDSTRING, DatabaseHelper.DIDSESSION_NAME, DatabaseHelper.DIDSESSION_SIGNEDIN, DatabaseHelper.DIDSESSION_AVATAR_CONTENTTYPE, DatabaseHelper.DIDSESSION_AVATAR_DATA};
         Cursor cursor = db.query(DatabaseHelper.DIDSESSIONS_TABLE, columns, null, null,null,null,null);

         ArrayList<IdentityEntry> entries = new ArrayList();
         while (cursor.moveToNext()) {
             entries.add(didSessionIdentityFromCursor(cursor));
         }
         return entries;
     }

     public IdentityEntry getDIDSessionSignedInIdentity() throws Exception {
         SQLiteDatabase db = helper.getWritableDatabase();
         String[] columns = {
                 DatabaseHelper.DIDSESSION_DIDSTOREID,
                 DatabaseHelper.DIDSESSION_DIDSTRING,
                 DatabaseHelper.DIDSESSION_NAME,
                 DatabaseHelper.DIDSESSION_AVATAR_CONTENTTYPE,
                 DatabaseHelper.DIDSESSION_AVATAR_DATA
         };
         String where = DatabaseHelper.DIDSESSION_SIGNEDIN + "=?";
         String[] whereArgs = {"1"};
         Cursor cursor = db.query(DatabaseHelper.DIDSESSIONS_TABLE, columns, where, whereArgs,null,null,null);

         if (cursor.moveToNext()) {
             return didSessionIdentityFromCursor(cursor);
         }
         return null;
     }

     /**
      * Marks all signed in identities to signed out (if any) and marks the given identity as signed in (if any).
      */
     public void setDIDSessionSignedInIdentity(IdentityEntry entry) throws Exception {
         SQLiteDatabase db = helper.getWritableDatabase();

         // Clear signed in flag from all entries
         ContentValues contentValues = new ContentValues();
         contentValues.put(DatabaseHelper.DIDSESSION_SIGNEDIN, 0);
         db.update(DatabaseHelper.DIDSESSIONS_TABLE, contentValues, null, null );

         // Mark the given entry as signed in
         if (entry != null) {
             contentValues = new ContentValues();
             contentValues.put(DatabaseHelper.DIDSESSION_SIGNEDIN, 1);
             String where = DatabaseHelper.DIDSESSION_DIDSTOREID + "=? AND " + DatabaseHelper.DIDSESSION_DIDSTRING + "=?";
             String[] whereArgs = {entry.didStoreId, entry.didString};
             db.update(DatabaseHelper.DIDSESSIONS_TABLE, contentValues, where, whereArgs);
         }
     }

     /**
      * Creates a new IdentityEntry object from a database cursor data.
      */
     private IdentityEntry didSessionIdentityFromCursor(Cursor cursor) {
         String didStoreId = cursor.getString(cursor.getColumnIndex(DatabaseHelper.DIDSESSION_DIDSTOREID));
         String didString = cursor.getString(cursor.getColumnIndex(DatabaseHelper.DIDSESSION_DIDSTRING));
         String name = cursor.getString(cursor.getColumnIndex(DatabaseHelper.DIDSESSION_NAME));
         String avatarContentType = cursor.getString(cursor.getColumnIndex(DatabaseHelper.DIDSESSION_AVATAR_CONTENTTYPE));
         byte[] avatarImageData = cursor.getBlob(cursor.getColumnIndex(DatabaseHelper.DIDSESSION_AVATAR_DATA));

         IdentityAvatar avatar = null;
         if (avatarContentType != null && avatarImageData != null) {
             avatar = new IdentityAvatar(avatarContentType, avatarImageData);
         }

         return new IdentityEntry(didStoreId, didString, name, avatar);
     }
 }
