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

/**
 * Database JSON format:
 *
 * {
 *     "applications": {
 *          "APPIID1": {
 *              "passwordentries": [
 *                  {
 *                      RAW_USER_OBJECT
 *                  }
 *              ]
 *          }
 *     }
 * }
 *
 * We work directly with raw JSONObjects to make it easier later to maintain the structure, add new fields,
 * handle specific or missing items.
 */
class PasswordDatabaseInfo {
    private static let APPLICATIONS_KEY = "applications"
    private static let PASSWORD_ENTRIES_KEY = "passwordentries"
    var rawJson: Dictionary<String, Any>?
    var activeMasterPassword: String? = nil
    var openingTime: Date

    private init() {
        openingTime = Date()
    }

    static func createEmpty() -> PasswordDatabaseInfo {
        let info = PasswordDatabaseInfo()
        let applications = Dictionary<String, Any>()
        info.rawJson = Dictionary<String, Any>()
        info.rawJson![APPLICATIONS_KEY] = applications
        return info
    }

    public static func fromJson(_ json: String) throws -> PasswordDatabaseInfo {
        let info = PasswordDatabaseInfo()
        if let jsonObj = json.toDict() {
            info.rawJson = jsonObj
        }
        else {
             throw "Invalid JSON format for password database info"
        }
        return info
    }

    public func getPasswordInfo(appID: String, key: String) throws -> PasswordInfo? {
        if let appIDContent = try getAppIDContent(appID) {
            if let passwordEntries = appIDContent[PasswordDatabaseInfo.PASSWORD_ENTRIES_KEY] as? [Dictionary<String, Any>] {
                if let entry = try passwordEntry(entries: passwordEntries, key: key) {
                    let info = try PasswordInfoBuilder.buildFromType(jsonObject: entry)
                    info.appID = appID
                    return info
                }
                else {
                    // No such entry exists
                    return nil
                }
            }
            else {
                return nil
            }
        }
        else {
            // No entry for this app ID yet, so we can't find the requested key
            return nil
        }
    }

    public func setPasswordInfo(appID: String, info: PasswordInfo) throws {
        var appIDContent = try getAppIDContent(appID)
        if (appIDContent == nil) {
            // No entry for this app ID yet, create one and add it
            appIDContent = try createdEmptyAppIDContent()
            var applications = rawJson![PasswordDatabaseInfo.APPLICATIONS_KEY] as! Dictionary<String, Any>
            applications[appID] = appIDContent
        }

        var passwordEntries = appIDContent![PasswordDatabaseInfo.PASSWORD_ENTRIES_KEY] as! [Dictionary<String, Any>]
        if (try keyInPasswordEntries(entries: passwordEntries, key: info.key)) {
            // This entry already exists. Delete it first before re-adding its updated version.
            try deletePasswordEntryFromKey(entries: &passwordEntries, key: info.key)
        }
        try addPasswordEntry(entries: &passwordEntries, info: info)
    }

    public func getAllPasswordInfo() throws -> [PasswordInfo] {
        let applications = rawJson![PasswordDatabaseInfo.APPLICATIONS_KEY] as! Dictionary<String, Any>

        var infos = [PasswordInfo]()
        var it = applications.keys.makeIterator()
        while let appID = it.next() {
            if let appIDContent = try getAppIDContent(appID) {
                let passwordEntries = appIDContent[PasswordDatabaseInfo.PASSWORD_ENTRIES_KEY] as! [Dictionary<String, Any>]
                for i in 0..<passwordEntries.count {
                    let entry = passwordEntries[i]
                    
                    let info = try PasswordInfoBuilder.buildFromType(jsonObject: entry)
                    info.appID = appID
                    infos.append(info)
                }
            }
        }
        return infos
    }

    public func deletePasswordInfo(appID: String, key: String) throws {
        if let appIDContent = try getAppIDContent(appID) {
            var passwordEntries = appIDContent[PasswordDatabaseInfo.PASSWORD_ENTRIES_KEY] as! [Dictionary<String, Any>]
            try deletePasswordEntryFromKey(entries: &passwordEntries, key: key)
        }
        else {
            // No entry for this app ID yet, so we can't find the requested key
        }
    }

    private func getAppIDContent(_ appID: String) throws -> Dictionary<String, Any>? {
        let applications = rawJson![PasswordDatabaseInfo.APPLICATIONS_KEY] as! Dictionary<String, Any>
        if (applications.keys.contains(appID)) {
            return (applications[appID] as! Dictionary<String, Any>)
        }
        else {
            return nil
        }
    }

    private func createdEmptyAppIDContent() throws -> Dictionary<String, Any> {
        var appIDContent = Dictionary<String, Any>()
        appIDContent[PasswordDatabaseInfo.PASSWORD_ENTRIES_KEY] = Dictionary<String, Any>()
        return appIDContent
    }

    private func passwordEntry(entries: [Dictionary<String,Any>], key: String) throws -> Dictionary<String, Any>? {
        for i in 0..<entries.count {
            let info = entries[i]
            if let k = info["key"] as? String, k == key {
                return info
            }
        }
        return nil
    }

    private func passwordEntryIndex(entries: [Dictionary<String,Any>], key: String) throws -> Int {
        for i in 0..<entries.count {
            let info = entries[i]
            if let k = info["key"] as? String, k == key {
                return i
            }
        }
        return -1
    }

    private func keyInPasswordEntries(entries: [Dictionary<String,Any>], key: String) throws -> Bool {
        return try passwordEntryIndex(entries: entries, key: key) >= 0
    }

    private func deletePasswordEntryFromKey(entries: inout [Dictionary<String,Any>], key: String) throws {
        let deletionIndex = try passwordEntryIndex(entries: entries, key: key)
        if deletionIndex >= 0 {
            entries.remove(at: deletionIndex)
        }
    }

    private func addPasswordEntry(entries: inout [Dictionary<String, Any>], info: PasswordInfo) throws {
        guard let json = info.asDictionary() else {
            throw "Unable to create JSON object from password info"
        }
        
        entries.append(json)
    }

    /**
     * Closes the password database and makes things secure.
     */
    func lock() {
        rawJson = nil
        activeMasterPassword = nil
        // NOTE: nothing else to do for now.
    }
}
