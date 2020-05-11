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

import Foundation
import SQLite

/** Extension to the sqlite Connection to handle a user_version in order to manage database format upgrades. */
extension Connection {
    public var userVersion: Int32 {
        get { return Int32(try? scalar("PRAGMA user_version") as? Int64) ?? 0 }
        set { try! run("PRAGMA user_version = \(newValue)") }
    }
}

/**
 * Helper to initialize sqlite databases instead of directly dealing with the Connection class. SUpport database format upgrade.
 * Very basic version its Android cousin.
 */
class SQLiteOpenHelper {
    private var db: Connection? = nil
    private let dbFullPath: String
    private let dbNewVersion: Int
    
    init(dbFullPath: String, dbNewVersion: Int) {
        self.dbFullPath = dbFullPath
        self.dbNewVersion = dbNewVersion
    }
    
    public func getDatabase() -> Connection {
        if db != nil {
            return db
        }
        
        db = try! Connection(dbFullPath)
        guard let _db = db else {
            return nil
        }
        
        let version = _db.userVersion
        
        // Compare current disk DB version with code "new" version, to upgrade if necessary
        if version != dbNewVersion {
            if version == 0 {
                onCreate(_db)
            } else {
                if (version > dbNewVersion) {
                    onDowngrade(_db, version, dbNewVersion)
                } else {
                    onUpgrade(_db, version, dbNewVersion)
                }
            }
            _db.userVersion = dbNewVersion
        }
        
        onOpen(_db)
        
        return _db
    }
    
    public func onCreate(connection: Connection) {}
    public func onOpen(connection: Connection) {}
    public func onUpgrade(connection: Connection, oldVersion: Int, newVersion: Int) {}
    public func onDowngrade(connection: Connection, oldVersion: Int, newVersion: Int) {}
}
