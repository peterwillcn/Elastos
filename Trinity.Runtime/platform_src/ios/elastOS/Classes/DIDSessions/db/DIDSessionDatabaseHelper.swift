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
 
public class DIDSessionDatabaseHelper : SQLiteOpenHelper {
    private static let DATABASE_VERSION = 1
    
    // Tables
    private static let DATABASE_NAME = "didsession.db"
    public static let DIDSESSIONS_TABLE = "didsessions"
    
    // Tables fields
    public static let TID = "tid"
    public static let DIDSTOREID = "didstoreid"
    public static let DIDSTRING = "didstring"
    public static let NAME = "name"
    public static let SIGNEDIN = "signedin"
    public static let AVATAR_CONTENTTYPE = "avatar_contenttype"
    public static let AVATAR_DATA = "avatar_data"
    
    public init() {
        let dataPath = NSHomeDirectory() + "/Documents/data/"
        super.init(dbFullPath: "\(dataPath)/\(DIDSessionDatabaseHelper.DATABASE_NAME)", dbNewVersion: DIDSessionDatabaseHelper.DATABASE_VERSION)
    }
    
    public override func onCreate(db: Connection) {
        let didSessionsSQL = "create table " +
            DIDSessionDatabaseHelper.DIDSESSIONS_TABLE + "(" +
            DIDSessionDatabaseHelper.TID + " integer primary key autoincrement, " +
            DIDSessionDatabaseHelper.DIDSTOREID + " varchar(32) NOT NULL, " +
            DIDSessionDatabaseHelper.DIDSTRING + " varchar(128) NOT NULL, " +
            DIDSessionDatabaseHelper.NAME + " varchar(128), " +
            DIDSessionDatabaseHelper.SIGNEDIN + " integer, " +
            DIDSessionDatabaseHelper.AVATAR_CONTENTTYPE + " varchar(32), " +
            DIDSessionDatabaseHelper.AVATAR_DATA + " blob)"
        try! db.execute(didSessionsSQL)
    }
    
    public override func onUpgrade(db: Connection, oldVersion: Int, newVersion: Int) {
    }
    
    public override func onDowngrade(db: Connection, oldVersion: Int, newVersion: Int) {
    }
}
