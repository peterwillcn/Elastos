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
 
public class DIDSessionDatabaseAdapter {
    let helper: DIDSessionDatabaseHelper
    
    // Tables
    let didSessions = Table(DIDSessionDatabaseHelper.DIDSESSIONS_TABLE)

    // Fields
    public let idField = Expression<Int64>(DIDSessionDatabaseHelper.TID)
    public let didStoreIDField = Expression<String>(DIDSessionDatabaseHelper.DIDSTOREID)
    public let didStringField = Expression<String>(DIDSessionDatabaseHelper.DIDSTRING)
    public let nameField = Expression<String>(DIDSessionDatabaseHelper.NAME)
    public let signedInField = Expression<Bool>(DIDSessionDatabaseHelper.SIGNEDIN)
    public let avatarContentTypeField = Expression<String?>(DIDSessionDatabaseHelper.AVATAR_CONTENTTYPE)
    public let avatarDataField = Expression<SQLite.Blob?>(DIDSessionDatabaseHelper.AVATAR_DATA)
    
    public init()
    {
        helper = DIDSessionDatabaseHelper()
    }

    func addDIDSessionIdentityEntry(entry: IdentityEntry) throws -> Int64 {
        // Check if we have this identity entry already or not (a bit slow but ok, not many DID entries)
        let existingEntries = try getDIDSessionIdentityEntries()

        // Check if the given entry exists in the list or not. If it exists, update it. Otherwise, insert it
        var identityEntryId: Int64? = nil
        for e in existingEntries {
            if e.didStoreId == entry.didStoreId && e.didString == entry.didString {
                // Already exists - so we update it
                identityEntryId = e.id!
                break
            }
        }

        let db = try helper.getDatabase()
        if identityEntryId != nil {
            // Update
            try db.transaction {
                try db.run(didSessions
                    .filter(didStoreIDField == entry.didStoreId && didStringField == entry.didString)
                    .update(
                        nameField <- entry.name
                    ))
            }
        }
        else {
            try db.transaction {
                identityEntryId = try db.run(didSessions.insert(
                    didStoreIDField <- entry.didStoreId,
                    didStringField <- entry.didString,
                    nameField <- entry.name,
                    signedInField <- false
                ))
            }
        }
        
        return identityEntryId!
    }

    func deleteDIDSessionIdentityEntry(didString: String) throws {
        let db = try helper.getDatabase()
        try db.transaction {
            try db.run(didSessions
                .filter(didStringField == didString)
                .delete())
        }
    }

    func getDIDSessionIdentityEntries() throws -> Array<IdentityEntry> {
        var entries = Array<IdentityEntry>()
        do {
            let db = try helper.getDatabase()
            
            try db.transaction {
                let query = didSessions.select(*)
                let sessionRows = try! db.prepare(query)
                for row in sessionRows {
                    let entry = didSessionIdentityFromRow(row)
                    entries.append(entry)
                }
            }
        }
        catch (let error) {
            print(error)
        }
        
        return entries
    }

    func getDIDSessionSignedInIdentity() throws -> IdentityEntry? {
        do {
           let db = try helper.getDatabase()
           var signedInEntry: IdentityEntry? = nil
           try db.transaction {
               let query = didSessions.select(*).filter(signedInField == true)
               let sessionRows = try! db.prepare(query)
               for row in sessionRows {
                   signedInEntry = didSessionIdentityFromRow(row)
                   break
               }
           }
           
           return signedInEntry
       }
       catch (let error) {
           print(error)
           return nil
       }
    }

    /**
     * Marks all signed in identities to signed out (if any) and marks the given identity as signed in (if any).
     */
    func setDIDSessionSignedInIdentity(entry: IdentityEntry?) throws  {
        do {
            let db = try helper.getDatabase()
            
            // Clear signed in flag from all entries
            try db.transaction {
                try db.run(didSessions.update(
                    signedInField <- false
                ))
            }
            
            // Mark the given entry as signed in
            if entry != nil {
                try db.transaction {
                    try db.run(didSessions
                        .filter(didStoreIDField == entry!.didStoreId && didStringField == entry!.didString)
                        .update(
                            signedInField <- true
                        ))
                }
            }
        }
        catch (let error) {
            print(error)
        }
    }

    /**
     * Creates a new IdentityEntry object from a database cursor data.
     */
    private func didSessionIdentityFromRow(_ row: Row) -> IdentityEntry {
        let didStoreId = row[didStringField]
        let didString = row[didStringField]
        let name = row[nameField]
        
        var avatar: IdentityAvatar? = nil
        if let avatarContentType = row[avatarContentTypeField], let avatarImageData = row[avatarDataField] {
            avatar = IdentityAvatar(contentType: avatarContentType, base64ImageData: avatarImageData)
        }

        let entry = IdentityEntry(didStoreId: didStoreId, didString: didString, name: name, avatar: avatar)
        entry.id = row[idField]
        
        return entry
    }

    /*
    public func addContact(didSessionDID: String, did: String, carrierUserID: String) throws -> Contact {
        let db = try helper.getDatabase()
        
        try db.transaction {
            try db.run(contacts.insert(
                didSessionDIDField <- didSessionDID,
                didField <- did,
                carrierUserIdField <- carrierUserID,
                notificationsBlockedField <- false,
                addedDateField <- Int64(Date().timeIntervalSince1970)
            ))
        }
        
        return getContactByDID(didSessionDID: didSessionDID, contactDID: did)!
     }

    public func updateContactNotificationsBlocked(didSessionDID: String, did: String, shouldBlockNotifications: Bool) {
        
        do {
            let db = try helper.getDatabase()
            try db.transaction {
                try db.run(contacts
                    .filter(didSessionDIDField == didSessionDID && didField == did)
                    .update(
                        notificationsBlockedField <- shouldBlockNotifications
                    ))
            }
        }
        catch (let error) {
            print(error)
        }
     }

    public func getContactByDID(didSessionDID: String, contactDID: String) -> Contact? {
        do {
            let db = try helper.getDatabase()
            var contact: Contact? = nil
            try db.transaction {
                let query = contacts.select(*)
                    .filter(didSessionDIDField == didSessionDID && didField == contactDID)
                let contactRows = try! db.prepare(query)
                for row in contactRows {
                    contact = Contact.fromDatabaseRow(notifier: notifier, row: row)
                    break
                }
            }
            
            return contact
        }
        catch (let error) {
            print(error)
            return nil
        }
     }

    public func getContactByCarrierUserID(didSessionDID: String, carrierUserID: String) -> Contact? {
        do {
            let db = try helper.getDatabase()
            var contact: Contact? = nil
            try db.transaction {
                let query = contacts.select(*)
                    .filter(didSessionDIDField == didSessionDID && carrierUserIdField == carrierUserID)
                let contactRows = try! db.prepare(query)
                for row in contactRows {
                    contact = Contact.fromDatabaseRow(notifier: notifier, row: row)
                    break
                }
            }
            
            return contact
        }
        catch (let error) {
            print(error)
            return nil
        }
     }

    public func removeContact(didSessionDID: String, contactDID: String) {
        do {
            let db = try helper.getDatabase()
            try db.transaction {
                _ = contacts.filter(didSessionDIDField == didSessionDID && didField == contactDID).delete()
            }
        }
        catch (let error) {
            print(error)
        }
     }

    public func addSentInvitation(didSessionDID: String, targetDID: String, targetCarrierAddress: String) {
        do {
            let db = try helper.getDatabase()
            
            try db.transaction {
                let insertedId = try db.run(sentInvitations.insert(
                    didSessionDIDField <- didSessionDID,
                    didField <- targetDID,
                    carrierAddressField <- targetCarrierAddress,
                    sentDateField <- Int64(Date().timeIntervalSince1970)
                ))
                
                print("Created SENT invitation id: \(insertedId)")
            }
        }
        catch (let error) {
            print(error)
        }
     }

    public func removeSentInvitationByAddress(didSessionDID: String, carrierAddress: String) {
        do {
            let db = try helper.getDatabase()
            try db.transaction {
                _ = sentInvitations.filter(didSessionDIDField == didSessionDID && carrierAddressField == carrierAddress).delete()
            }
        }
        catch (let error) {
            print(error)
        }
     }

    public func getAllSentInvitations(didSessionDID: String) -> Array<SentInvitation> {
        var invitations = Array<SentInvitation>()
        do {
            let db = try helper.getDatabase()
            try db.transaction {
                let query = sentInvitations.select(*).filter(didSessionDIDField == didSessionDID)
                let rows = try! db.prepare(query)
                
                for row in rows {
                    let invitation = SentInvitation.fromDatabaseCursor(row: row)
                    invitations.append(invitation)
                }
            }
            
            return invitations
        }
        catch (let error) {
            print(error)
            return invitations
        }
     }

    public func addReceivedInvitation(didSessionDID: String, contactDID: String, contactCarrierUserId: String) throws -> Int64 {
            
        let db = try helper.getDatabase()
            
        var insertedId: Int64 = 0
        try db.transaction {
            insertedId = try db.run(receivedInvitations.insert(
                didSessionDIDField <- didSessionDID,
                didField <- contactDID,
                carrierUserIdField <- contactCarrierUserId,
                receivedDateField <- Int64(Date().timeIntervalSince1970)
            ))
        }
        
        return insertedId
     }

    public func getReceivedInvitationById(didSessionDID: String, invitationID: Int64?) -> ReceivedInvitation? {
        guard invitationID != nil else {
            return nil
        }
        
        do {
            let db = try helper.getDatabase()
            var invitation: ReceivedInvitation? = nil
            try db.transaction {
                let query = receivedInvitations.select(*)
                    .filter(didSessionDIDField == didSessionDID && invitationIdField == invitationID!)
                let rows = try! db.prepare(query)
                for row in rows {
                    invitation = ReceivedInvitation.fromDatabaseCursor(row: row)
                    break
                }
            }
            return invitation
        }
        catch (let error) {
            print(error)
            return nil
        }
     }

    public func removeReceivedInvitation(didSessionDID: String, invitationId: Int64?) {
        guard invitationId != nil else {
            print("removeReceivedInvitation: Invalid invitation ID \(String(describing: invitationId))")
            return
        }
        
        do {
            let db = try helper.getDatabase()
            try db.transaction {
                _ = receivedInvitations.filter(didSessionDIDField == didSessionDID && invitationIdField == invitationId!).delete()
            }
        }
        catch (let error) {
            print(error)
        }
     }*/
}
