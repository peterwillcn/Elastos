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

@objc(PasswordManagerPlugin)
class PasswordManagerPlugin : TrinityPlugin {
    private static let NATIVE_ERROR_CODE_INVALID_PASSWORD = -1
    private static let NATIVE_ERROR_CODE_INVALID_PARAMETER = -2
    private static let NATIVE_ERROR_CODE_CANCELLED = -3
    private static let NATIVE_ERROR_CODE_UNSPECIFIED = -4

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
                                     messageAs: retAsString)
        
        self.commandDelegate.send(result, callbackId: command.callbackId)
    }
    
    func error(_ command: CDVInvokedUrlCommand, _ retAsDict: Dictionary<String, Any>) {
        let result = CDVPluginResult(status: CDVCommandStatus_ERROR,
                                     messageAs: retAsDict)
        
        self.commandDelegate.send(result, callbackId: command.callbackId)
    }
    
    private func buildCancellationError() -> Dictionary<String, Any> {
        var result = Dictionary<String, Any>()
        result["code"] = PasswordManagerPlugin.NATIVE_ERROR_CODE_CANCELLED
        result["reason"] = "MasterPasswordCancellation"
        return result
    }

    private func buildGenericError(message: String) -> Dictionary<String, Any>{
        var result = Dictionary<String, Any>()
        if message.contains("BAD_DECRYPT") { // TODO: not like android!
            result["code"] = PasswordManagerPlugin.NATIVE_ERROR_CODE_INVALID_PASSWORD
        }
        else {
            result["code"] = PasswordManagerPlugin.NATIVE_ERROR_CODE_UNSPECIFIED
        }
        result["reason"] = message
        return result;
    }

    @objc public func setPasswordInfo(_ command: CDVInvokedUrlCommand) {
        do {
            if let info = command.arguments[0] as? Dictionary<String, Any> {
                let passwordInfo = try PasswordInfoBuilder.buildFromType(jsonObject: info)
                    
                var result = Dictionary<String, Any>()
                PasswordManager.getSharedInstance().setPasswordInfo(info: passwordInfo, did: did, appID: appId, onPasswordInfoSet: {
                    
                    result["couldSet"] = true
                    self.success(command, result)
                    
                }, onCancel: {
                    self.error(command, self.buildCancellationError())
                }, onError: { error in
                    self.error(command, self.buildGenericError(message: error))
                })
            }
            else {
                self.error(command, buildGenericError(message: "Password info must be provided"))
            }
        }
        catch (let error) {
            self.error(command, buildGenericError(message: error.localizedDescription))
        }
    }
    
    @objc public func getPasswordInfo(_ command: CDVInvokedUrlCommand) {
        do {
            if let key = command.arguments[0] as? String {
                var result = Dictionary<String, Any>()
                try PasswordManager.getSharedInstance().getPasswordInfo(key: key, did: did, appID: appId, onPasswordInfoRetrieved: { info in
                    
                    if info != nil {
                        result["passwordInfo"] = info!.asDictionary()
                    }
                    else {
                        result["passwordInfo"] = nil
                    }
                    self.success(command, result)
                    
                }, onCancel: {
                    self.error(command, self.buildCancellationError())
                }, onError: { error in
                    self.error(command, self.buildGenericError(message: error))
                })
            }
            else {
                self.error(command, buildGenericError(message: "Password info key must be provided"))
            }
        }
        catch (let error) {
            self.error(command, buildGenericError(message: error.localizedDescription))
        }
    }
    
    @objc public func getAllPasswordInfo(_ command: CDVInvokedUrlCommand) {
        var result = Dictionary<String, Any>()
        PasswordManager.getSharedInstance().getAllPasswordInfo(did: did, appID: appId, onAllPasswordInfoRetrieved: { infos in
            
            var allPasswordInfo = Array<Dictionary<String, Any>>()
            for info in infos {
                if let jsonInfo = info.asDictionary() {
                    allPasswordInfo.append(jsonInfo)
                }
            }
            
            result["allPasswordInfo"] = allPasswordInfo
            
            self.success(command, result)
            
        }, onCancel: {
            self.error(command, self.buildCancellationError())
        }, onError: { error in
            self.error(command, self.buildGenericError(message: error))
        })
    }
    
    @objc public func deletePasswordInfo(_ command: CDVInvokedUrlCommand) {
        do {
            if let key = command.arguments[0] as? String {
                var result = Dictionary<String, Any>()
                try PasswordManager.getSharedInstance().deletePasswordInfo(key: key, did: did, appID: appId, targetAppID: appId, onPasswordInfoDeleted: {
                    
                    result["couldDelete"] = true
                    self.success(command, result)
                    
                }, onCancel: {
                    self.error(command, self.buildCancellationError())
                }, onError: { error in
                    self.error(command, self.buildGenericError(message: error))
                })
            }
            else {
                self.error(command, buildGenericError(message: "Password info key must be provided"))
            }
        }
        catch (let error) {
            self.error(command, buildGenericError(message: error.localizedDescription))
        }
    }
    
    @objc public func deleteAppPasswordInfo(_ command: CDVInvokedUrlCommand) {
        do {
            guard let targetAppId = command.arguments[0] as? String else {
                self.error(command, buildGenericError(message: "Target app id must be provided"))
                return
            }
            
            guard let key = command.arguments[1] as? String else {
                self.error(command, buildGenericError(message: "Password info key must be provided"))
                return
            }
            
            var result = Dictionary<String, Any>()
            try PasswordManager.getSharedInstance().deletePasswordInfo(key: key, did: did, appID: appId, targetAppID: targetAppId, onPasswordInfoDeleted: {
                
                result["couldDelete"] = true
                self.success(command, result)
                
            }, onCancel: {
                self.error(command, self.buildCancellationError())
            }, onError: { error in
                self.error(command, self.buildGenericError(message: error))
            })
        }
        catch (let error) {
            self.error(command, buildGenericError(message: error.localizedDescription))
        }
    }

    @objc public func generateRandomPassword(_ command: CDVInvokedUrlCommand) {
        let _ = command.arguments[0] as? Dictionary<String, Any> // Options - currently unused

        let password = PasswordManager.getSharedInstance().generateRandomPassword(options: nil)

        var result = Dictionary<String, Any>()
        result["generatedPassword"] = password

        self.success(command, result)
    }

    @objc public func changeMasterPassword(_ command: CDVInvokedUrlCommand) {
        do {
            var result = Dictionary<String, Any>()
            try PasswordManager.getSharedInstance().changeMasterPassword(did: did, appID: appId, onMasterPasswordChanged: {
                
                result["couldChange"] = true
                self.success(command, result)
                
            }, onCancel: {
                self.error(command, self.buildCancellationError())
            }, onError: { error in
                self.error(command, self.buildGenericError(message: error))
            })
        }
        catch (let error) {
            self.error(command, buildGenericError(message: error.localizedDescription))
        }
    }
    
    @objc public func lockMasterPassword(_ command: CDVInvokedUrlCommand) {
        PasswordManager.getSharedInstance().lockMasterPassword(did: did, appID: appId)

        let result = Dictionary<String, Any>()
        self.success(command, result)
    }

    @objc public func setUnlockMode(_ command: CDVInvokedUrlCommand) {
        guard let unlockModeAsInt = command.arguments[0] as? Int else {
            self.error(command, buildGenericError(message: "Unlock mode must be provided"))
            return
        }
        
        if let unlockMode = PasswordUnlockMode(rawValue: unlockModeAsInt) {
            PasswordManager.getSharedInstance().setUnlockMode(unlockMode: unlockMode, did: did, appID: appId)
        }
        else {
            self.error(command, buildGenericError(message: "No known unlock mode for value \(unlockModeAsInt)"))
        }

        let result = Dictionary<String, Any>()
        self.success(command, result)
    }
    
    @objc public func setVirtualDIDContext(_ command: CDVInvokedUrlCommand) {
        let virtualDIDStringContext = command.arguments[0] as? String
        
        do {
            try PasswordManager.getSharedInstance().setVirtualDIDContext(didString: virtualDIDStringContext)
        
            let result = Dictionary<String, Any>()
            self.success(command, result)
        }
        catch let error {
            self.error(command, error.localizedDescription)
        }
    }
}
