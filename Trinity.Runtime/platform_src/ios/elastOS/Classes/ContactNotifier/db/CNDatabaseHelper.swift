/*
* Copyright (c) 2020 Elastos Foundation
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
 
public class CNDatabaseHelper : SQLiteOpenHelper {
    private static let DATABASE_VERSION = 1
    
    // Tables
    private static let DATABASE_NAME = "contactnotifier.db"
    public static let CONTACTS_TABLE = "contacts"
    public static let SENT_INVITATIONS_TABLE = "sentinvitations"
    public static let RECEIVED_INVITATIONS_TABLE = "receivedinvitations"
    
    // Tables fields
    public static let DID_SESSION_DID = "didsessiondid"
    public static let INVITATION_ID = "iid"
    public static let DID = "did"
    public static let CARRIER_ADDRESS = "carrieraddress"
    public static let CARRIER_USER_ID = "carrieruserid"
    public static let NOTIFICATIONS_BLOCKED = "notificationsblocked"
    public static let ADDED_DATE = "added"
    public static let SENT_DATE = "sent"
    public static let RECEIVED_DATE = "received"
    
    public static let KEY = "key"
    public static let VALUE = "value"
    
    public init() {
        let dataPath = NSHomeDirectory() + "/Documents/data/"
        super.init(dbFullPath: "\(dataPath)/\(DATABASE_NAME)", dbNewVersion: DATABASE_VERSION)
    }
    
    public override func onCreate(db: Connection) {
        // CONTACTS
        let contactsSQL = "create table " + CONTACTS_TABLE + "(cid integer primary key autoincrement, " +
            DID_SESSION_DID + " varchar(128), " +
            DID + " varchar(128), " +
            CARRIER_USER_ID + " varchar(128), " + // Permanent friend user id to talk (notifications) to him
            NOTIFICATIONS_BLOCKED + " integer(1), " + // Whether this contact can send notifications to current user or not
            ADDED_DATE + " date)"
        db.execute(contactsSQL)
        
        // SENT INVITATIONS
        let sentInvitationsSQL = "create table " + SENT_INVITATIONS_TABLE + "(" +
            INVITATION_ID + " integer primary key autoincrement, " +
            DID_SESSION_DID + " varchar(128), " +
            DID + " varchar(128), " +
            CARRIER_ADDRESS + " varchar(128), " +
            SENT_DATE + " date)"
        db.execute(sentInvitationsSQL)
        
        // RECEIVED INVITATIONS
        let receivedInvitationsSQL = "create table " + RECEIVED_INVITATIONS_TABLE + "(" +
            INVITATION_ID + " integer primary key autoincrement, " +
            DID_SESSION_DID + " varchar(128), " +
            DID + " varchar(128), " +
            CARRIER_USER_ID + " varchar(128), " +
            RECEIVED_DATE + " date)";
        db.execute(receivedInvitationsSQL)
    }
    
    public override func onUpgrade(connection: Connection, oldVersion: Int, newVersion: Int) {
    }
    
    public override func onDowngrade(connection: Connection, oldVersion: Int, newVersion: Int) {
    }
}
