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
    let sentInvitations = Table(CNDatabaseHelper.SENT_INVITATIONS_TABLE)
    let receivedInvitations = Table(CNDatabaseHelper.RECEIVED_INVITATIONS_TABLE)

    // Fields
    let tidField = Expression<Int64>(AppInfo.TID)
    public let didSessionDIDField = Expression<String>(CNDatabaseHelper.DID_SESSION_DID)
    public let didField = Expression<String>(CNDatabaseHelper.DID)
    public let carrierAddressField = Expression<String>(CNDatabaseHelper.CARRIER_ADDRESS)
    public let carrierUserIdField = Expression<String>(CNDatabaseHelper.CARRIER_USER_ID)
    public let notificationsBlockedField = Expression<Bool>(CNDatabaseHelper.NOTIFICATIONS_BLOCKED)
    public let addedDateField = Expression<Int64>(CNDatabaseHelper.ADDED_DATE)
    public let sentDateField = Expression<Int64>(CNDatabaseHelper.SENT_DATE)
    public let receivedDateField = Expression<Int64>(CNDatabaseHelper.RECEIVED_DATE)
    public let invitationIdField = Expression<Int64>(CNDatabaseHelper.INVITATION_ID)
    
    public init(notifier: ContactNotifier)
    {
        self.notifier = notifier
        helper = CNDatabaseHelper()
    }

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
     }
}
