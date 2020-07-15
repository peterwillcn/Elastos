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

public class DIDSessionManagerPlugin : TrinityPlugin {
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

    @objc func addIdentityEntry(_ command: CDVInvokedUrlCommand) {
        if command.arguments.count != 1 {
            error(command, "Wrong number of parameters passed")
            return
        }

        let identityEntryJson = command.arguments[0] as! Dictionary<String, Any>

        do {
            if let identityEntry = IdentityEntry.fromJsonObject(identityEntryJson) {
                try DIDSessionManager.getSharedInstance().addIdentityEntry(entry: identityEntry)
                success(command)
            }
            else {
                self.error(command, "addIdentityEntry", "Invalid identity entry format")
            }
        }
        catch let error {
            self.error(command, "addIdentityEntry", error.localizedDescription)
        }
    }

    @objc func deleteIdentityEntry(_ command: CDVInvokedUrlCommand) {
        if command.arguments.count != 1 {
            error(command, "Wrong number of parameters passed")
            return
        }

        do {
            if let didString = command.arguments[0] as? String {
                try DIDSessionManager.getSharedInstance().deleteIdentityEntry(didString: didString)
                success(command)
            }
            else {
                self.error(command, "deleteIdentityEntry", "Invalid DID string")
            }
        }
        catch let error {
            self.error(command, "deleteIdentityEntry", error.localizedDescription)
        }
    }

    @objc func getIdentityEntries(_ command: CDVInvokedUrlCommand) {
        if command.arguments.count != 0 {
            error(command, "Wrong number of parameters passed")
            return
        }

        do {
            let entries = try DIDSessionManager.getSharedInstance().getIdentityEntries()

            var jsonObj = Dictionary<String, Any>()
            var jsonEntries = Array<Dictionary<String, Any>>()
            for entry in entries {
                jsonEntries.append(entry.asJsonObject())
            }
            jsonObj["entries"] = jsonEntries

            success(command, jsonObj)
        }
        catch let error {
            self.error(command, "getIdentityEntries", error.localizedDescription)
        }
    }

    @objc func getSignedInIdentity(_ command: CDVInvokedUrlCommand) {
        do {
            if let signedInIdentity = try DIDSessionManager.getSharedInstance().getSignedInIdentity() {
                success(command, signedInIdentity.asJsonObject())
            }
            else {
                success(command) // Not signed in, no data to return
            }
        }
        catch let error {
            self.error(command, "getSignedInIdentity", error.localizedDescription)
        }
    }

    @objc func signIn(_ command: CDVInvokedUrlCommand) {
        if command.arguments.count != 1 {
            error(command, "signIn", "Wrong number of parameters passed")
            return
        }

        do {
            if let identityEntryJson = command.arguments[0] as? Dictionary<String, Any>,
                let identityToSignIn = IdentityEntry.fromJsonObject(identityEntryJson) {
                
                try DIDSessionManager.getSharedInstance().signIn(identityToSignIn: identityToSignIn)

                success(command)
            }
            else {
                self.error(command, "signIn", "Invalid identity entry format")
            }
        }
        catch let error {
            self.error(command, "signIn", error.localizedDescription)
        }
    }

    @objc func signOut(_ command: CDVInvokedUrlCommand) {
        do {
            try DIDSessionManager.getSharedInstance().signOut()
            success(command)
        }
        catch let error {
            self.error(command, "signOut", error.localizedDescription)
        }
    }
}
