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

@objc(ContactNotifierPlugin)
class ContactNotifierPlugin : TrinityPlugin {
    func success(_ command: CDVInvokedUrlCommand) {
        let result = CDVPluginResult(status: CDVCommandStatus_OK)
        
        self.commandDelegate.send(result, callbackId: command.callbackId)
    }
    
    func success(_ command: CDVInvokedUrlCommand, _ retAsDict: Dictionary<String, Any>) {
        let result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: retAsDict)
        self.commandDelegate.send(result, callbackId: command.callbackId)
    }
    
    func error(_ command: CDVInvokedUrlCommand, _ retAsString: String) {
        let result = CDVPluginResult(status: CDVCommandStatus_ERROR,
                                     messageAs: retAsString);
        
        self.commandDelegate.send(result, callbackId: command.callbackId)
    }
    
    func error(_ command: CDVInvokedUrlCommand, _ method: String, _ retAsString: String) {
        let result = CDVPluginResult(status: CDVCommandStatus_ERROR,
                                     messageAs: "\(method): \(retAsString)");
        
        self.commandDelegate.send(result, callbackId: command.callbackId)
    }
   
    private func getNotifier() throws -> ContactNotifier {
        return try ContactNotifier.getSharedInstance(did: did)
    }

    @objc func notifierGetCarrierAddress(_ command: CDVInvokedUrlCommand) {
        do {
            let carrierAddress = try getNotifier().getCarrierAddress()

            var result = Dictionary<String, Any>()
            result["address"] = carrierAddress
            self.success(command, result)
        }
        catch (let error) {
            print(error)
            self.error(command, "notifierGetCarrierAddress", error.localizedDescription)
        }
    }

    @objc func notifierResolveContact(_ command: CDVInvokedUrlCommand) {
        do {
            let contactDID = command.arguments[0] as? String

            try getNotifier().resolveContact(did: contactDID) { contact in
                var result = Dictionary<String, Any>()
                if contact != nil {
                    result["contact"] = contact!.toJSONObject()
                }
                else {
                    result["contact"] = nil
                }
                self.success(command, result)
            }
        }
        catch (let error) {
            print(error)
            self.error(command, "notifierResolveContact", error.localizedDescription)
        }
    }

    @objc func notifierRemoveContact(_ command: CDVInvokedUrlCommand) {
        do {
            if let contactDID = command.arguments[0] as? String {
                try getNotifier().removeContact(did: contactDID)
                self.success(command)
            }
            else {
                self.error(command, "notifierRemoveContact", "Invalid contact DID, make sure to use a DID string")
            }
        }
        catch (let error) {
            print(error)
            self.error(command, "notifierRemoveContact", error.localizedDescription)
        }
    }

    @objc func notifierSetOnlineStatusListener(_ command: CDVInvokedUrlCommand) {
        do {
            try getNotifier().addOnlineStatusListener() { contact, status in
                var listenerResult = Dictionary<String, Any>()
                listenerResult["contact"] = contact.toJSONObject()
                listenerResult["status"] = status.rawValue

                let result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: listenerResult)
                result?.setKeepCallbackAs(true)
                self.commandDelegate.send(result, callbackId: command.callbackId)
            }

            let result = CDVPluginResult(status: CDVCommandStatus_NO_RESULT)
            result?.setKeepCallbackAs(true)
            self.commandDelegate.send(result, callbackId: command.callbackId)
        }
        catch (let error) {
            print(error)
            self.error(command, "notifierSetOnlineStatusListener", error.localizedDescription)
        }
    }

    @objc func notifierSetOnlineStatusMode(_ command: CDVInvokedUrlCommand) {
        do {
            let onlineStatusModeAsInt = command.arguments[0] as! Int

            if let mode = OnlineStatusMode(rawValue: onlineStatusModeAsInt) {
                try getNotifier().setOnlineStatusMode(mode)
                self.success(command)
            }
            else {
                self.error(command, "notifierSetOnlineStatusMode", "Invalid status mode \(onlineStatusModeAsInt)")
            }
        }
        catch (let error) {
            print(error)
            self.error(command, "notifierSetOnlineStatusMode", error.localizedDescription)
        }
    }

    @objc func notifierGetOnlineStatusMode(_ command: CDVInvokedUrlCommand) {
        do {
            let mode = try getNotifier().getOnlineStatusMode()

            var result = Dictionary<String, Any>()
            result["onlineStatusMode"] = mode.rawValue
            self.success(command, result)
        }
        catch (let error) {
            print(error)
            self.error(command, "notifierGetOnlineStatusMode", error.localizedDescription)
        }
    }

    @objc func notifierSendInvitation(_ command: CDVInvokedUrlCommand) {
        do {
            let did = command.arguments[0] as! String
            let carrierAddress = command.arguments[1] as! String

            try getNotifier().sendInvitation(targetDID: did, carrierAddress: carrierAddress)

            self.success(command)
        }
        catch (let error) {
            print(error)
            self.error(command, "notifierSendInvitation", error.localizedDescription)
        }
    }

    @objc func notifierAcceptInvitation(_ command: CDVInvokedUrlCommand) {
        do {
            let invitationId = command.arguments[0] as! String
            
            class OnInvitationAcceptedByUsHandler: OnInvitationAcceptedByUsListener {
                let plugin: ContactNotifierPlugin, command: CDVInvokedUrlCommand
                
                init(plugin: ContactNotifierPlugin, command: CDVInvokedUrlCommand) {
                    self.plugin = plugin
                    self.command = command
                }
                
                func onInvitationAccepted(contact: Contact) {
                    var result = Dictionary<String, Any>()
                    result["contact"] = contact.toJSONObject()
                    plugin.success(command, result)
                }
                
                func onNotExistingInvitation() {
                    plugin.error(command, "notifierAcceptInvitation", "No pending invitation found for the given invitation ID");
                }
                
                func onError(reason: String?) {
                    plugin.error(command, "notifierAcceptInvitation", reason ?? "")
                }
            }
        }
        catch (let error) {
            print(error)
            self.error(command, "notifierAcceptInvitation", error.localizedDescription)
        }
    }

    @objc func notifierRejectInvitation(_ command: CDVInvokedUrlCommand) {
        do {
            let invitationId = command.arguments[0] as! String

            try getNotifier().rejectInvitation(invitationId: invitationId)

            self.success(command)
        }
        catch (let error) {
            print(error)
            self.error(command, "notifierRejectInvitation", error.localizedDescription)
        }
    }

    @objc func notifierSetOnInvitationAcceptedListener(_ command: CDVInvokedUrlCommand) {
        do {
            // TODO IMPORTANT: when an app is closed, need to remove the listener heer otherwise this will retain a memory
            // reference on that app and things can't be deallocated! Ask Dongxiao how to get notified when an app closes

            try getNotifier().addOnInvitationAcceptedListener() { contact in
                    var listenerResult = Dictionary<String, Any>()
                    listenerResult["contact"] = contact.toJSONObject()

                    let result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: listenerResult)
                    result?.setKeepCallbackAs(true)
                    self.commandDelegate.send(result, callbackId: command.callbackId)
            }

            let result = CDVPluginResult(status: CDVCommandStatus_NO_RESULT)
            result?.setKeepCallbackAs(true)
            self.commandDelegate.send(result, callbackId: command.callbackId)
        }
        catch (let error) {
            print(error)
            self.error(command, "notifierSetOnInvitationAcceptedListener", error.localizedDescription)
        }
    }

    @objc func notifierSetInvitationRequestsMode(_ command: CDVInvokedUrlCommand) {
        do {
            let invitationRequestModeAsInt = command.arguments[0] as! Int

            if let mode = InvitationRequestsMode(rawValue: invitationRequestModeAsInt) {
                try getNotifier().setInvitationRequestsMode(mode)
                self.success(command)
            }
            else {
                self.error(command, "notifierSetInvitationRequestsMode", "Invalid mode")
            }
        }
        catch (let error) {
            print(error)
            self.error(command, "notifierSetInvitationRequestsMode", error.localizedDescription)
        }
    }

    @objc func notifierGetInvitationRequestsMode(_ command: CDVInvokedUrlCommand) {
        do {
            let mode = try getNotifier().getInvitationRequestsMode()

            var result = Dictionary<String, Any>()
            result["invitationRequestsMode"] = mode.rawValue
            self.success(command, result)
        }
        catch (let error) {
            print(error)
            self.error(command, "notifierGetInvitationRequestsMode", error.localizedDescription)
        }
    }

    @objc func contactSendRemoteNotification(_ command: CDVInvokedUrlCommand) {
        do {
            let contactAsJson = command.arguments[0] as! Dictionary<String, Any>
            let notificationAsJson = command.arguments[1] as! Dictionary<String, Any>

            try getNotifier().resolveContact(did: contactDIDFromJSON(contactAsJson)) { contact in
                guard contact != nil else {
                    self.error(command, "contactSendRemoteNotification", "Invalid contact object")
                    return
                }
                
                if let remoteNotificationRequest = RemoteNotificationRequest.fromJSONObject(notificationAsJson) {
                    
                    contact!.sendRemoteNotification(notificationRequest: remoteNotificationRequest)
                    self.success(command)
                }
                else {
                    self.error(command, "contactSendRemoteNotification", "Invalid notification object")
                }
            }
        }
        catch (let error) {
            print(error)
            self.error(command, "contactSendRemoteNotification", error.localizedDescription)
        }
    }

    @objc func contactSetAllowNotifications(_ command: CDVInvokedUrlCommand) {
        do {
            let contactAsJson = command.arguments[0] as! Dictionary<String, Any>
            let allowNotifications = command.arguments[1] as! Bool

            try getNotifier().resolveContact(did: contactDIDFromJSON(contactAsJson)) { contact in
                guard contact != nil else {
                    error(command, "contactSetAllowNotifications", "Invalid contact object")
                    return
                }
                
                contact!.setAllowNotifications(allowNotifications)

                self.success(command)
            }
        }
        catch (let error) {
            print(error)
            self.error(command, "contactSetAllowNotifications", error.localizedDescription)
        }
    }

    @objc func contactGetOnlineStatus(_ command: CDVInvokedUrlCommand) {
        do {
            let contactAsJson = command.arguments[0] as! Dictionary<String, Any>

            try getNotifier().resolveContact(did: contactDIDFromJSON(contactAsJson)) { contact in
                guard contact != nil else {
                    self.error(command, "contactSetAllowNotifications", "Invalid contact object")
                    return
                }

                let status = contact!.getOnlineStatus()

                var result = Dictionary<String, Any>()
                result["onlineStatus"] = status.rawValue
                self.success(command, result)
            }
        }
        catch (let error) {
            print(error)
            self.error(command, "contactGetOnlineStatus", error.localizedDescription)
        }
    }

    private func contactDIDFromJSON(_ contactAsJSON: Dictionary<String, Any>) throws -> String? {
        if !contactAsJSON.keys.contains("did") {
            return nil
        }
        else {
            return contactAsJSON["did"] as? String
        }
    }
}
