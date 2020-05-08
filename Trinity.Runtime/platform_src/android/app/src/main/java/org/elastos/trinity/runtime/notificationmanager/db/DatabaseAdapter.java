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

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

import org.elastos.trinity.runtime.notificationmanager.Notification;
import org.elastos.trinity.runtime.notificationmanager.NotificationManager;

import java.util.ArrayList;
import java.util.Date;

 public class DatabaseAdapter {
    DatabaseHelper helper;
    Context context;
    NotificationManager notifier;

    public DatabaseAdapter(NotificationManager notifier, Context context)
    {
        this.notifier = notifier;
        helper = new DatabaseHelper(context);
        this.context = context;
    }

     public Notification addNotification(String key, String title, String url, String emitter, String appId) {
         // Overwrite previous notification if it has the same key and appId
         boolean needUpdate = this.isNotificationExist(key, appId);
         if (needUpdate) {
             this.updateNotification(key, title, url, emitter, appId);
         } else {
             this.insertNotification(key, title, url, emitter, appId);
         }

         return getNotificationByKeyAndAppId(key, appId);
     }

     public void insertNotification(String key, String title, String url, String emitter, String appId) {
         SQLiteDatabase db = helper.getWritableDatabase();

         ContentValues contentValues = new ContentValues();
         contentValues.put(DatabaseHelper.KEY, key);
         contentValues.put(DatabaseHelper.TITLE, title);
         contentValues.put(DatabaseHelper.URL, url);
         contentValues.put(DatabaseHelper.EMITTER, emitter);
         contentValues.put(DatabaseHelper.APP_ID, appId);
         contentValues.put(DatabaseHelper.SENT_DATE, new Date().getTime()); // Unix timestamp

         db.insertOrThrow(DatabaseHelper.NOTIFICATION_TABLE, null, contentValues);
     }

     public void updateNotification(String key, String title, String url, String emitter, String appId) {
         SQLiteDatabase db = helper.getWritableDatabase();

         String where = DatabaseHelper.KEY + "=? AND " + DatabaseHelper.APP_ID + "=?";
         String[] whereArgs = {key, appId};
         ContentValues contentValues = new ContentValues();
         contentValues.put(DatabaseHelper.TITLE, title);
         contentValues.put(DatabaseHelper.URL, url);
         contentValues.put(DatabaseHelper.EMITTER, emitter);
         contentValues.put(DatabaseHelper.APP_ID, appId);

         db.update(DatabaseHelper.NOTIFICATION_TABLE, contentValues, where, whereArgs );
     }

     public Notification getNotificationByKeyAndAppId(String key, String appId) {
         SQLiteDatabase db = helper.getWritableDatabase();

         String where = DatabaseHelper.KEY + "=? AND " + DatabaseHelper.APP_ID + "=?";
         String[] whereArgs = {key, appId};
         String[] columns = {DatabaseHelper.NOTIFICATION_ID, DatabaseHelper.KEY,
                 DatabaseHelper.TITLE, DatabaseHelper.APP_ID, DatabaseHelper.URL,
                 DatabaseHelper.SENT_DATE};

         Cursor cursor = db.query(DatabaseHelper.NOTIFICATION_TABLE, columns, where, whereArgs,null,null,null);
         if (cursor.moveToNext()) {
             return Notification.fromDatabaseCursor(notifier, cursor);
         }

         return null;
     }

     private boolean isNotificationExist(String key, String appId) {
         SQLiteDatabase db = helper.getWritableDatabase();

         String where = DatabaseHelper.KEY + "=? AND " + DatabaseHelper.APP_ID + "=?";
         String[] whereArgs = {key, appId};
         String[] columns = {DatabaseHelper.NOTIFICATION_ID};

         Cursor cursor = db.query(DatabaseHelper.NOTIFICATION_TABLE, columns, where, whereArgs,null,null,null);
         if (cursor.moveToNext()) {
             return true;
         }

         return false;
     }

     public void clearNotification(String notificationId) {
         SQLiteDatabase db = helper.getWritableDatabase();

         String where = DatabaseHelper.NOTIFICATION_ID + " =?";
         String[] whereArgs = {notificationId};
         db.delete(DatabaseHelper.NOTIFICATION_TABLE, where, whereArgs);
     }

     public ArrayList<Notification> getNotifications() {
         SQLiteDatabase db = helper.getWritableDatabase();

         String[] columns = {DatabaseHelper.NOTIFICATION_ID, DatabaseHelper.KEY,
                            DatabaseHelper.TITLE, DatabaseHelper.APP_ID, DatabaseHelper.URL,
                            DatabaseHelper.SENT_DATE};

         ArrayList<Notification> notifications = new ArrayList<>();
         Cursor cursor = db.query(DatabaseHelper.NOTIFICATION_TABLE, columns, null, null,null,null,null);
         while (cursor.moveToNext()) {
             Notification notification = Notification.fromDatabaseCursor(notifier, cursor);
             notifications.add(notification);
         }

         return notifications;
     }
}
