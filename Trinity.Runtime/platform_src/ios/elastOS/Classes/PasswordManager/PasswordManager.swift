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
import CryptorRSA
import PopupDialog
import RNCryptor

public protocol BasePasswordManagerListener {
    func onCancel()
    func onError(_ error: String)
}

private protocol OnDatabaseLoadedListener : BasePasswordManagerListener {
    func onDatabaseLoaded()
}

private protocol OnDatabaseSavedListener : BasePasswordManagerListener {
    func onDatabaseSaved()
}

public protocol OnMasterPasswordCreationListener : BasePasswordManagerListener {
    func onMasterPasswordCreated()
}

public protocol OnMasterPasswordChangeListener : BasePasswordManagerListener {
    func onMasterPasswordChanged()
}

public protocol OnMasterPasswordRetrievedListener : BasePasswordManagerListener {
    func onMasterPasswordRetrieved(password: String)
}

public protocol OnPasswordInfoRetrievedListener : BasePasswordManagerListener {
    func onPasswordInfoRetrieved(info: PasswordInfo)
}

public protocol OnAllPasswordInfoRetrievedListener : BasePasswordManagerListener {
    func onAllPasswordInfoRetrieved(info: Array<PasswordInfo>)
}

public protocol OnPasswordInfoDeletedListener : BasePasswordManagerListener {
    func onPasswordInfoDeleted()
}

public protocol OnPasswordInfoSetListener : BasePasswordManagerListener {
    func onPasswordInfoSet()
}


/**
 * Database format is a plain JSON file, not mysql, why? Because we want to ensure unicity when changing the
 * master password (and in a simple way). The JSON file is then re-encrypted at once. It also better matches the
 * custom password info data that we store, instead of storing JSON strings in a mysql table.
 */
public class PasswordManager {
    private static let LOG_TAG = "PWDManager"
    private static let SHARED_PREFS_KEY = "PWDMANAGERPREFS"
    private static let PASSWORD_MANAGER_APP_ID = "org.elastos.trinity.dapp.passwordmanager"

    public static let FAKE_PASSWORD_MANAGER_PLUGIN_APP_ID = "fakemasterpasswordpluginappid"
    public static let MASTER_PASSWORD_BIOMETRIC_KEY = "masterpasswordkey"

    private static let PREF_KEY_UNLOCK_MODE = "unlockmode"
    private static let PREF_KEY_APPS_PASSWORD_STRATEGY = "appspasswordstrategy"

    //private WebViewActivity activity;
    private static var instance: PasswordManager? = nil
    private let mainViewController: MainViewController
    private var appManager: AppManager? = nil
    private var databasesInfo = Dictionary<String, PasswordDatabaseInfo>()
    private var virtualDIDContext: String? = nil

    init(mainViewController: MainViewController) {
        self.mainViewController = mainViewController
        PasswordManager.instance = self
    }

    func setAppManager(_ appManager: AppManager) {
        self.appManager = appManager
    }

    public static func getSharedInstance() -> PasswordManager {
        return instance!
    }

    /**
     * Saves or updates a password information into the secure database.
     * The passwordInfo's key field is checked to match existing content. Existing content
     * is overwritten.
     *
     * Password info could fail to be saved in case user cancels the master password creation or enters
     * a wrong master password then cancels.
     */
    public func setPasswordInfo(info: PasswordInfo, did: String, appID: String,
                                onPasswordInfoSet: @escaping ()->Void,
                                onCancel: @escaping ()->Void,
                                onError: @escaping (_ error: String)->Void) {
        
        let actualDID = try! getActualDIDContext(currentDIDContext: did)
        
        // If the calling app is NOT the password manager, we can set password info only if the APPS password
        // strategy is LOCK_WITH_MASTER_PASSWORD.
        if (!appIsPasswordManager(appId: appID) && getAppsPasswordStrategy() == .DONT_USE_MASTER_PASSWORD) {
            onError("Saving password info with a DONT_USE_MASTER_PASSWORD apps strategy is forbidden")
            return
        }

        checkMasterPasswordCreationRequired(did: actualDID, onMasterPasswordCreated: {
            self.loadDatabase(did: actualDID, onDatabaseLoaded: {
                do {
                    try self.setPasswordInfoReal(info: info, did: actualDID, appID: appID)
                    onPasswordInfoSet()
                }
                catch (let error) {
                    onError(error.localizedDescription)
                }
            }, onCancel: {
                onCancel()
            }, onError: { error in
                onError(error)
            }, isPasswordRetry: false)
        }, onCancel: {
            onCancel()
        }, onError: { error in
            onError(error)
        })
    }

    /**
     * Using a key identifier, returns a previously saved password info.
     *
     * A regular application can only access password info that it created itself.
     * The password manager application is able to access information from all applications.
     *
     * @param key Unique key identifying the password info to retrieve.
     *
     * @returns The password info, or null if nothing was found.
     */
    public func getPasswordInfo(key: String, did: String, appID: String,
                                onPasswordInfoRetrieved: @escaping (_ password: PasswordInfo?)->Void,
                                onCancel: @escaping ()->Void,
                                onError: @escaping (_ error: String)->Void) throws {
        
        let actualDID = try! getActualDIDContext(currentDIDContext: did)
        
        // If the calling app is NOT the password manager, we can get password info only if the APPS password
        // strategy is LOCK_WITH_MASTER_PASSWORD.
        if (!appIsPasswordManager(appId: appID) && getAppsPasswordStrategy() == AppsPasswordStrategy.DONT_USE_MASTER_PASSWORD) {
            // Force apps to prompt user password by themselves as we are not using a master password.
            onPasswordInfoRetrieved(nil)
            return
        }

        checkMasterPasswordCreationRequired(did: actualDID, onMasterPasswordCreated: {
            self.loadDatabase(did: actualDID, onDatabaseLoaded: {
                do {
                    let info = try self.getPasswordInfoReal(key: key, did: actualDID, appID: appID)
                    onPasswordInfoRetrieved(info)
                }
                catch (let error) {
                    onError(error.localizedDescription)
                }
            }, onCancel: {
                onCancel()
            }, onError: { error in
                onError(error)
            }, isPasswordRetry: false)
        }, onCancel: {
            onCancel()
        }, onError: { error in
            onError(error)
        })
    }

    /**
     * Returns the whole list of password information contained in the password database.
     *
     * Only the password manager application is allowed to call this API.
     *
     * @returns The list of existing password information.
     */
    public func getAllPasswordInfo(did: String, appID: String,
                                   onAllPasswordInfoRetrieved: @escaping (_ info: [PasswordInfo])->Void,
                                   onCancel: @escaping ()->Void,
                                   onError: @escaping (_ error: String)->Void) {
        
        let actualDID = try! getActualDIDContext(currentDIDContext: did)
        
        if (!appIsPasswordManager(appId: appID)) {
            onError("Only the password manager application can call this API")
            return
        }

        checkMasterPasswordCreationRequired(did: "", onMasterPasswordCreated: {
            self.loadDatabase(did: actualDID, onDatabaseLoaded: {
                do {
                    let infos = try self.getAllPasswordInfoReal(did: actualDID)
                    onAllPasswordInfoRetrieved(infos)
                }
                catch (let error) {
                    onError(error.localizedDescription)
                }
            }, onCancel: {
                onCancel()
            }, onError: { error in
                onError(error)
            }, isPasswordRetry: false)
            
        }, onCancel: onCancel, onError: onError)
    }

    /**
     * Deletes an existing password information from the secure database.
     *
     * A regular application can only delete password info that it created itself.
     * The password manager application is able to delete information from all applications.
     *
     * @param key Unique identifier for the password info to delete.
     */
    public func deletePasswordInfo(key: String, did: String, appID: String, targetAppID: String,
                                   onPasswordInfoDeleted: @escaping ()->Void,
                                   onCancel: @escaping ()->Void,
                                   onError: @escaping (_ error: String)->Void) throws {
        
        let actualDID = try! getActualDIDContext(currentDIDContext: did)
        
        // Only the password manager app can delete content that is not its own content.
        if (!appIsPasswordManager(appId: appID) && appID != targetAppID) {
            onError("Only the application manager application can delete password info that does not belong to it.")
            return
        }

        loadDatabase(did: actualDID, onDatabaseLoaded: {
            do {
                try self.deletePasswordInfoReal(key: key, did: actualDID, targetAppID: targetAppID)
                onPasswordInfoDeleted()
            }
            catch (let error) {
                onError(error.localizedDescription)
            }
        }, onCancel: onCancel, onError: onError, isPasswordRetry: false)
    }
    
    /**
     * Convenience method to generate a random password based on given criteria (options).
     * Used by applications to quickly generate new user passwords.
     *
     * @param options unused for now
     */
    public func generateRandomPassword(options: PasswordCreationOptions?) -> String {
        let sizeOfRandomString = 8

        var allowedCharacters = ""
        allowedCharacters += "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        allowedCharacters += "abcdefghijklmnopqrstuvwxyz"
        allowedCharacters += "0123456789"
        allowedCharacters += "!@#$%^&*()_-+=<>?/{}~|"

        return String((0..<sizeOfRandomString).map{ _ in allowedCharacters.randomElement()! })
    }

    /**
     * Sets the new master password for the current DID session. This master password locks the whole
     * database of password information.
     *
     * In case of a master password change, the password info database is re-encrypted with this new password.
     *
     * Only the password manager application is allowed to call this API.
     */
    public func changeMasterPassword(did: String, appID: String,
                                     onMasterPasswordChanged: @escaping ()->Void,
                                     onCancel: @escaping ()->Void,
                                     onError: @escaping (_ error: String)->Void) throws {
        
        let actualDID = try! getActualDIDContext(currentDIDContext: did)
        
        if !appIsPasswordManager(appId: appID) {
            print("Only the password manager application can call this API")
            return
        }

        loadDatabase(did: actualDID, onDatabaseLoaded: {
            let creatorController = MasterPasswordCreatorAlertController(nibName: "MasterPasswordCreator", bundle: Bundle.main)
            
            creatorController.setCanDisableMasterPasswordUse(false)

            let popup = PopupDialog(viewController: creatorController, buttonAlignment: .horizontal, transitionStyle: .fadeIn, preferredWidth: 340, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false, completion: nil)

            popup.view.backgroundColor = UIColor.clear // For rounded corners
            self.appManager!.mainViewController.present(popup, animated: false, completion: nil)

            creatorController.setOnPasswordCreatedListener { password in
                popup.dismiss()

                // Master password was provided and confirmed. Now we can use it.

                do {
                    if let dbInfo = self.databasesInfo[actualDID] {
                        // Changing the master password means re-encrypting the database with a different password
                        try self.encryptAndSaveDatabase(did: actualDID, masterPassword: password)

                        // Remember the new password locally
                        dbInfo.activeMasterPassword = password

                        onMasterPasswordChanged()
                    }
                    else {
                        throw "No active database for DID \(actualDID)"
                    }
                }
                catch (let error) {
                    onError(error.localizedDescription)
                }
            }
                
            creatorController.setOnCancelListener {
                popup.dismiss()
                onCancel()
            }
        }, onCancel: onCancel, onError: onError, isPasswordRetry: false)
    }

    /**
     * If the master password has ben unlocked earlier, all passwords are accessible for a while.
     * This API re-locks the passwords database and further requests from applications to this password
     * manager will require user to provide his master password again.
     */
    public func lockMasterPassword(did: String, appID: String) {
        
        let actualDID = try! getActualDIDContext(currentDIDContext: did)
        
        if (!appIsPasswordManager(appId: appID)) {
            print("Only the password manager application can call this API")
            return
        }

        lockDatabase(did: actualDID)
    }

    /**
     * Sets the unlock strategy for the password info database. By default, once the master password
     * if provided once by the user, the whole database is unlocked for a while, until elastOS exits,
     * or if one hour has passed, or if it's manually locked again.
     *
     * For increased security, user can choose to get prompted for the master password every time using
     * this API.
     *
     * This API can be called only by the password manager application.
     *
     * @param unlockMode Unlock strategy to use.
     */
    public func setUnlockMode(unlockMode: PasswordUnlockMode, did: String, appID: String) {
        let actualDID = try! getActualDIDContext(currentDIDContext: did)
        
        if (!appIsPasswordManager(appId: appID)) {
            print("Only the password manager application can call this API")
            return
        }

        saveToPrefs(key: PasswordManager.PREF_KEY_UNLOCK_MODE, value: unlockMode.rawValue)

        // if the mode becomes UNLOCK_EVERY_TIME, we lock the database
        if (getUnlockMode() != .UNLOCK_EVERY_TIME && unlockMode == PasswordUnlockMode.UNLOCK_EVERY_TIME) {
            lockDatabase(did: actualDID);
        }
    }

    private func getUnlockMode() -> PasswordUnlockMode {
        let unlockModeAsInt = getPrefsInt(key: PasswordManager.PREF_KEY_UNLOCK_MODE, defaultValue: PasswordUnlockMode.UNLOCK_FOR_A_WHILE.rawValue)
        return PasswordUnlockMode(rawValue: unlockModeAsInt) ?? PasswordUnlockMode.UNLOCK_FOR_A_WHILE
    }

    /**
     * Sets the overall strategy for third party applications password management.
     *
     * Users can choose to lock all apps passwords using a single master password. They can also choose
     * to not use this feature and instead, input their custom app password every time they need to.
     *
     * When strategy is set to DONT_USE_MASTER_PASSWORD, setPasswordInfo() always fails, and getPasswordInfo()
     * always returns an empty content, therefore pushing apps to prompt user passwords every time.
     *
     * If the strategy was LOCK_WITH_MASTER_PASSWORD and becomes DONT_USE_MASTER_PASSWORD, existing password
     * info is not deleted. The password manager application is responsible for clearing the existing content
     * if user wishes to do that.
     *
     * @param strategy Strategy to use in order to save and get passwords in third party apps.
     */
    public func setAppsPasswordStrategy(strategy: AppsPasswordStrategy, did: String, appID: String?, forceSet: Bool) {
        let actualDID = try! getActualDIDContext(currentDIDContext: did)
        
        if (!forceSet && !appIsPasswordManager(appId: appID!)) {
            print("Only the password manager application can call this API")
            return
        }

        saveToPrefs(key: PasswordManager.PREF_KEY_APPS_PASSWORD_STRATEGY, value: strategy.rawValue)

        // if the mode becomes DONT_USE_MASTER_PASSWORD, we lock the database
        if (getAppsPasswordStrategy() != .DONT_USE_MASTER_PASSWORD && strategy == .DONT_USE_MASTER_PASSWORD) {
            lockDatabase(did: actualDID)
        }
    }

    /**
     * Returns the current apps password strategy. If nothing was et earlier, default value
     * is LOCK_WITH_MASTER_PASSWORD.
     *
     * @returns The current apps password strategy
     */
    public func getAppsPasswordStrategy() -> AppsPasswordStrategy {
        let savedPasswordStrategyAsInt = getPrefsInt(key: PasswordManager.PREF_KEY_APPS_PASSWORD_STRATEGY, defaultValue: AppsPasswordStrategy.LOCK_WITH_MASTER_PASSWORD.rawValue)
        return AppsPasswordStrategy(rawValue: savedPasswordStrategyAsInt) ?? AppsPasswordStrategy.LOCK_WITH_MASTER_PASSWORD
    }
    
    /**
     * RESTRICTED
     *
     * Used by the DID session application to toggle DID contexts and deal with DID creation, sign in,
     * sign out. When a virtual context is set, api call such as getPasswordInfo() don't use the currently
     * signed in DID, but they use this virtual DID instead.
     *
     * @param didString The DID context to use for all further api calls. Pass null to clear the virtual context.
     */
    public func setVirtualDIDContext(didString: String?) throws {
        self.virtualDIDContext = didString
    }
    
    private func getActualDIDContext(currentDIDContext: String?) throws -> String {
        if virtualDIDContext != nil {
            return virtualDIDContext!
        }
        else {
            if currentDIDContext != nil {
                return currentDIDContext!
            }
            else {
                throw "No signed in DID or virtual DID context exist. Need at least one of them!"
            }
        }
    }

    private func appIsPasswordManager(appId: String) -> Bool {
        return appId == PasswordManager.PASSWORD_MANAGER_APP_ID
    }

    private func loadDatabase(did: String,
                              onDatabaseLoaded: @escaping ()->Void,
                              onCancel: @escaping ()->Void,
                              onError: @escaping (_ error: String)->Void,
                              isPasswordRetry: Bool) {
        
        if (isDatabaseLoaded(did: did) && !sessionExpired(did: did)) {
            onDatabaseLoaded()
        }
        else {
            if (sessionExpired(did: did)) {
                lockDatabase(did: did)
            }
            
            // Master password is locked - prompt it to user
            let prompterController = MasterPasswordPrompterAlertController(nibName: "MasterPasswordPrompter", bundle: Bundle.main)
            
            prompterController.setPasswordManager(self)
            prompterController.setPreviousAttemptWasWrong(isPasswordRetry)

            let popup = PopupDialog(viewController: prompterController, buttonAlignment: .horizontal, transitionStyle: .fadeIn, preferredWidth: 340, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false, completion: nil)

            popup.view.backgroundColor = UIColor.clear // For rounded corners
            self.appManager!.mainViewController.present(popup, animated: false, completion: nil)

            prompterController.setOnPasswordTypedListener { password, shouldSavePasswordToBiometric in
                popup.dismiss()
                
                do {
                    try self.loadEncryptedDatabase(did: did, masterPassword: password)
                    if (self.isDatabaseLoaded(did: did)) {
                        // User chose to enable biometric authentication (was not enabled before). So we save the
                        // master password to the biometric crypto space.
                        if (shouldSavePasswordToBiometric) {
                            let fingerPrintAuthHelper = FingerPrintAuthHelper(dAppID: PasswordManager.FAKE_PASSWORD_MANAGER_PLUGIN_APP_ID)
                            fingerPrintAuthHelper.authenticateAndSavePassword(passwordKey: PasswordManager.MASTER_PASSWORD_BIOMETRIC_KEY, password: password) { error in
                                if error == nil {
                                    // Save user's choice to use biometric auth method next time
                                    self.setBiometricAuthEnabled(true)
                                    
                                    onDatabaseLoaded()
                                }
                                else {
                                    // Biometric save failed, but we still could open the database, so we return a success here.
                                    // Though, we don't save user's choice to enable biometric auth.
                                    print("Biometric authentication failed to initiate")
                                    print(error!)
                                    onDatabaseLoaded()
                                }
                            }
                        }
                        else {
                            onDatabaseLoaded()
                        }
                    }
                    else {
                        onError("Unknown error while trying to load the passwords database")
                    }
                }
                catch RNCryptor.Error.hmacMismatch {
                    // In case of wrong password exception, try again
                    self.loadDatabase(did: did, onDatabaseLoaded: onDatabaseLoaded, onCancel: onCancel, onError: onError, isPasswordRetry: true)
                }
                catch (let error) {
                    // Other exceptions are passed raw
                    onError(error.localizedDescription)
                }
            }
            
            prompterController.setOnCancelListener {
                popup.dismiss()
                onCancel()
            }
            
            prompterController.setOnErrorListener { error in
                popup.dismiss()
                onError(error)
            }
        }
    }

    /**
     * A "session" is when a database is unlocked. This session can be considered as expired for further calls,
     * in case user wants to unlock the database every time, or in case it's been first unlocked a too long time ago (auto relock
     * for security).
     */
    private func sessionExpired(did: String) -> Bool {
        if getUnlockMode() == .UNLOCK_EVERY_TIME {
            return true
        }

        guard let dbInfo = databasesInfo[did] else {
            return true
        }

        // Last opened more than 1 hour ago? -> Expired
        let oneHourMs = TimeInterval(60*60)
        return dbInfo.openingTime.timeIntervalSinceNow > oneHourMs
    }

    private func isDatabaseLoaded(did: String) -> Bool {
        return databasesInfo[did] != nil
    }

    private func lockDatabase(did: String) {
        if let dbInfo = databasesInfo[did] {
            dbInfo.lock()
            databasesInfo.removeValue(forKey: did)
        }
    }
    
    private func getDatabaseDirectory(did: String) -> String {
        return appManager!.dataPath + "/pwm/" + did
    }

    private func getDatabaseFilePath(did: String) -> String {
        let dbPath = getDatabaseDirectory(did: did) + "/store.db"
        ensureDbPathExists(did: did)
        return dbPath
    }

    private func ensureDbPathExists(did: String) {
        // Create folder in case it's missing
        try? FileManager.default.createDirectory(atPath: getDatabaseDirectory(did: did), withIntermediateDirectories: true, attributes: nil)
    }

    private func databaseExists(did: String) -> Bool {
        return FileManager.default.fileExists(atPath: getDatabaseFilePath(did: did))
    }

    private func createEmptyDatabase(did: String, masterPassword: String) {
        // No database exists yet. Return an empty database info.
        let dbInfo = PasswordDatabaseInfo.createEmpty()
        databasesInfo[did] = dbInfo

        // Save the master password
        dbInfo.activeMasterPassword = masterPassword;
    }

    /**
     * Using user's master password, decrypt the passwords list from disk and load it into memory.
     */
    private func loadEncryptedDatabase(did: String, masterPassword: String?) throws {
        guard let masterPassword = masterPassword, masterPassword != "" else {
            throw "Empty master password is not allowed"
        }

        let dbPath = getDatabaseFilePath(did: did)

        if (!databaseExists(did: did)) {
            createEmptyDatabase(did: did, masterPassword: masterPassword)
        }
        else {
            let encodedData = try Data(contentsOf: URL(fileURLWithPath: dbPath))

            // Now that we've loaded the file, try to decrypt it
            let decodedData = try decryptData(data: encodedData, masterPassword: masterPassword)

            // We can now load the database content as a JSON object
            do {
                if let jsonData = String(data: decodedData, encoding: .utf8), let jsonDict = jsonData.toDict() {
                    let dbInfo = try PasswordDatabaseInfo.fromDictionary(jsonDict)
                    databasesInfo[did] = dbInfo

                    // Decryption was successful, saved master password in memory for a while.
                    dbInfo.activeMasterPassword = masterPassword
                }
                else {
                    throw "Passwords database JSON content for did \(did) is corrupted: Can't decode to json string"
                }
            } catch (let error) {
                throw "Passwords database JSON content for did \(did) is corrupted: \(error.localizedDescription)"
            }
        }
    }

    private func decryptData(data: Data, masterPassword: String) throws -> Data
    {
        let decryptor = RNCryptor.Decryptor(password: masterPassword)
        let plaintext = NSMutableData()

        try plaintext.append(decryptor.update(withData: data))
        try plaintext.append(decryptor.finalData())
        
        return plaintext.copy() as! Data
    }

    private func encryptAndSaveDatabase(did: String, masterPassword: String) throws {
        let dbPath = getDatabaseFilePath(did: did)

        // Make sure the database is open
        guard let dbInfo = databasesInfo[did] else {
            throw "Can't save a closed database"
        }

        // Convert JSON data into bytes
        guard let jsonString = dbInfo.asDictionary().toString() else {
            throw "Unable to convert database json to json string"
        }

        // Encrypt and get result
        let data = Data(jsonString.utf8)
        let result = try encryptData(plainTextBytes: data, masterPassword: masterPassword)

        // Save encrypted data to the database file
        try result.write(to: URL(fileURLWithPath: dbPath))
    }

    private func encryptData(plainTextBytes: Data, masterPassword: String) throws -> Data
    {
        let encryptor = RNCryptor.Encryptor(password: masterPassword)
        let ciphertext = NSMutableData()

        ciphertext.append(encryptor.update(withData: plainTextBytes))
        ciphertext.append(encryptor.finalData())
        
        return ciphertext.copy() as! Data
    }

    private func setPasswordInfoReal(info: PasswordInfo, did: String, appID:String) throws {
        if let dbInfo = databasesInfo[did] {
            try dbInfo.setPasswordInfo(appID: appID, info: info)
            try encryptAndSaveDatabase(did: did, masterPassword: dbInfo.activeMasterPassword!)
        }
    }

    private func getPasswordInfoReal(key: String, did: String, appID: String) throws -> PasswordInfo? {
        return try databasesInfo[did]!.getPasswordInfo(appID: appID, key: key)
    }

    private func getAllPasswordInfoReal(did: String) throws -> [PasswordInfo]  {
        return try databasesInfo[did]!.getAllPasswordInfo()
    }

    private func deletePasswordInfoReal(key: String, did: String, targetAppID: String) throws {
        if let dbInfo = databasesInfo[did] {
            try dbInfo.deletePasswordInfo(appID: targetAppID, key: key)
            try encryptAndSaveDatabase(did: did, masterPassword: dbInfo.activeMasterPassword!)
        }
    }
    
    private func getUserDefaults() -> UserDefaults {
        // TODO: bug here? should be sandboxed for each DID ? IMPORTANT: Also resolve the virtual did context here
        return UserDefaults(suiteName: PasswordManager.SHARED_PREFS_KEY)!
    }

    private func saveToPrefs(key: String, value: Int) {
        getUserDefaults().set(value, forKey: key)
    }
    
    private func saveToPrefs(key: String, value: Bool) {
        getUserDefaults().set(value, forKey: key)
    }
    
    private func getPrefsInt(key: String, defaultValue: Int) -> Int {
        if getUserDefaults().object(forKey: key) == nil {
            return defaultValue
        } else {
            return getUserDefaults().integer(forKey: key)
        }
    }
    
    private func getPrefsBool(key: String, defaultValue: Bool) -> Bool {
        if getUserDefaults().object(forKey: key) == nil {
            return defaultValue
        } else {
            return getUserDefaults().bool(forKey: key)
        }
    }

    /**
     * Checks if a password database exists (master password was set). If not, starts the master password
     * creation flow. After completion, calls the listener so that the base flow can continue.
     */
    private func checkMasterPasswordCreationRequired(did: String,
                                                     onMasterPasswordCreated: @escaping ()->Void,
                                                     onCancel: @escaping ()->Void,
                                                     onError: @escaping (_ error: String)->Void) {
        if (databaseExists(did: did)) {
            onMasterPasswordCreated()
        }
        else {
           let creatorController = MasterPasswordCreatorAlertController(nibName: "MasterPasswordCreator", bundle: Bundle.main)

            let popup = PopupDialog(viewController: creatorController, buttonAlignment: .horizontal, transitionStyle: .fadeIn, preferredWidth: 340, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false, completion: nil)

            popup.view.backgroundColor = UIColor.clear // For rounded corners
            self.appManager!.mainViewController.present(popup, animated: false, completion: nil)

            creatorController.setOnPasswordCreatedListener { password in
                popup.dismiss()

                // Master password was provided and confirmed. Now we can use it.

                // Create an empty database
                self.createEmptyDatabase(did: did, masterPassword: password)

                do {
                    // Save this empty database to remember that we have defined a master password
                    try self.encryptAndSaveDatabase(did: did, masterPassword: password)

                    onMasterPasswordCreated()
                }
                catch (let error) {
                    onError(error.localizedDescription)
                }
            }
                
            creatorController.setOnCancelListener {
                popup.dismiss()
                onCancel()
            }
            
            creatorController.setOnDontUseMasterPasswordListener {
                popup.dismiss()
                
                // User chose to not use a master password. He will have to use the password manager app
                // to change this option.
                self.setAppsPasswordStrategy(strategy: .DONT_USE_MASTER_PASSWORD, did: did, appID: nil, forceSet: true)

                // Consider this as a cancellation for this app
                onCancel()
            }
        }
    }

    public func isBiometricAuthEnabled() -> Bool {
        return getPrefsBool(key: "biometricauth", defaultValue: false)
    }

    public func setBiometricAuthEnabled(_ useBiometricAuth: Bool) {
        saveToPrefs(key: "biometricauth", value: useBiometricAuth)
    }
}
