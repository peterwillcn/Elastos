package org.elastos.trinity.runtime.passwordmanager;

import android.content.Context;
import android.content.SharedPreferences;
import android.util.Log;

import org.elastos.trinity.runtime.AppManager;
import org.elastos.trinity.runtime.WebViewActivity;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Random;

/**
 * Database format is a plain JSON file, not mysql, why? Because we want to ensure unicity when changing the
 * master password (and in a simple way). The JSON file is then re-encrypted at once. It also better matches the
 * custom password info data that we store, instead of storing JSON strings in a mysql table.
 */
public class PasswordManager {
    private static final String LOG_TAG = "PWDManager";
    private static final String SHARED_PREFS_KEY = "PWDMANAGERPREFS";
    private static final String PASSWORD_MANAGER_APP_ID = "org.elastos.trinity.dapp.passwordmanager";

    private static final String PREF_KEY_UNLOCK_MODE = "unlockmode";
    private static final String PREF_KEY_APPS_PASSWORD_STRATEGY = "appspasswordstrategy";

    private WebViewActivity activity;
    private static PasswordManager instance;
    private AppManager appManager;
    private HashMap<String, PasswordDatabaseInfo> databasesInfo = new HashMap<>();

    private interface BasePasswordManagerListener {
        void onCancel();
        void onError(String error);
    }

    private interface OnDatabaseLoadedListener extends BasePasswordManagerListener {
        void onDatabaseLoaded();
    }

    public interface OnMasterPasswordRetrievedListener extends BasePasswordManagerListener {
        void onMasterPasswordRetrieved(String password);
    }

    public interface OnPasswordInfoRetrievedListener extends BasePasswordManagerListener {
        void onPasswordInfoRetrieved(PasswordInfo info);
    }

    public interface OnAllPasswordInfoRetrievedListener extends BasePasswordManagerListener {
        void onAllPasswordInfoRetrieved(ArrayList<PasswordInfo> info);
    }

    public interface OnPasswordInfoDeletedListener extends BasePasswordManagerListener {
        void onPasswordInfoDeleted();
    }

    public interface OnPasswordInfoSetListener extends BasePasswordManagerListener {
        void onPasswordInfoSet();
    }

    PasswordManager(WebViewActivity activity) {
        this.activity = activity;
        PasswordManager.instance = this;
    }

    public void setAppManager(AppManager appManager) {
        this.appManager = appManager;
    }

    public static PasswordManager getSharedInstance() {
        return instance;
    }

    /**
     * Saves or updates a password information into the secure database.
     * The passwordInfo's key field is checked to match existing content. Existing content
     * is overwritten.
     *
     * Password info could fail to be saved in case user cancels the master password creation or enters
     * a wrong master password then cancels.
     */
    public void setPasswordInfo(PasswordInfo info, String did, String appID, OnPasswordInfoSetListener listener) {
        // If the calling app is NOT the password manager, we can set password info only if the APPS password
        // strategy is LOCK_WITH_MASTER_PASSWORD.
        if (!appIsPasswordManager(appID) && getAppsPasswordStrategy() == AppsPasswordStrategy.DONT_USE_MASTER_PASSWORD) {
            listener.onError("Saving password info with a DONT_USE_MASTER_PASSWORD apps strategy is forbidden");
            return;
        }

        loadDatabase(did, new OnDatabaseLoadedListener() {
            @Override
            public void onDatabaseLoaded() {
                try {
                    setPasswordInfoReal(info, did, appID);
                    listener.onPasswordInfoSet();
                }
                catch (Exception e) {
                    listener.onError(e.getMessage());
                }
            }

            @Override
            public void onCancel() {
                listener.onCancel();
            }

            @Override
            public void onError(String error) {
                listener.onError(error);
            }
        });
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
    public void getPasswordInfo(String key, String did, String appID, OnPasswordInfoRetrievedListener listener) throws Exception {
        // If the calling app is NOT the password manager, we can get password info only if the APPS password
        // strategy is LOCK_WITH_MASTER_PASSWORD.
        if (!appIsPasswordManager(appID) && getAppsPasswordStrategy() == AppsPasswordStrategy.DONT_USE_MASTER_PASSWORD) {
            // Force apps to prompt user password by themselves as we are not using a master password.
            listener.onPasswordInfoRetrieved(null);
            return;
        }

        loadDatabase(did, new OnDatabaseLoadedListener() {
            @Override
            public void onDatabaseLoaded() {
                try {
                    PasswordInfo info = getPasswordInfoReal(key, did, appID);
                    listener.onPasswordInfoRetrieved(info);
                }
                catch (Exception e) {
                    listener.onError(e.getMessage());
                }
            }

            @Override
            public void onCancel() {
                listener.onCancel();
            }

            @Override
            public void onError(String error) {
                listener.onError(error);
            }
        });
    }

    /**
     * Returns the whole list of password information contained in the password database.
     *
     * Only the password manager application is allowed to call this API.
     *
     * @returns The list of existing password information.
     */
    public void getAllPasswordInfo(String did, String appID, OnAllPasswordInfoRetrievedListener listener) {
        if (!appIsPasswordManager(appID)) {
            listener.onError("Only the password manager application can call this API");
            return;
        }

        loadDatabase(did, new OnDatabaseLoadedListener() {
            @Override
            public void onDatabaseLoaded() {
                try {
                    ArrayList<PasswordInfo> infos = getAllPasswordInfoReal(did);
                    listener.onAllPasswordInfoRetrieved(infos);
                }
                catch (Exception e) {
                    listener.onError(e.getMessage());
                }
            }

            @Override
            public void onCancel() {
                listener.onCancel();
            }

            @Override
            public void onError(String error) {
                listener.onError(error);
            }
        });
    }

    /**
     * Deletes an existing password information from the secure database.
     *
     * A regular application can only delete password info that it created itself.
     * The password manager application is able to delete information from all applications.
     *
     * @param key Unique identifier for the password info to delete.
     */
    public void deletePasswordInfo(String key, String did, String appID, String targetAppID, OnPasswordInfoDeletedListener listener) throws Exception {
        // Only the password manager app can delete content that is not its own content.
        if (!appIsPasswordManager(appID) && !appID.equals(targetAppID)) {
            listener.onError("Only the application manager application can delete password info that does not belong to it.");
            return;
        }

        loadDatabase(did, new OnDatabaseLoadedListener() {
            @Override
            public void onDatabaseLoaded() {
                try {
                    deletePasswordInfoReal(key, did, targetAppID);
                    listener.onPasswordInfoDeleted();
                }
                catch (Exception e) {
                    listener.onError(e.getMessage());
                }
            }

            @Override
            public void onCancel() {
                listener.onCancel();
            }

            @Override
            public void onError(String error) {
                listener.onError(error);
            }
        });
    }

    /**
     * Convenience method to generate a random password based on given criteria (options).
     * Used by applications to quickly generate new user passwords.
     *
     * @param options unused for now
     */
    public String generateRandomPassword(PasswordCreationOptions options) {
        int sizeOfRandomString = 8;

        String allowedCharacters = "";
        allowedCharacters += "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        allowedCharacters += "abcdefghijklmnopqrstuvwxyz";
        allowedCharacters += "0123456789";
        allowedCharacters += "!@#$%^&*()_-+=<>?/{}~|";

        final Random random = new Random();
        final StringBuilder sb = new StringBuilder(sizeOfRandomString);

        for(int i=sb.length();i < sizeOfRandomString;++i){
            sb.append(allowedCharacters.charAt(random.nextInt(allowedCharacters.length())));
        }

        return sb.toString();
    }

    /**
     * Sets the new master password for the current DID session. This master password locks the whole
     * database of password information.
     *
     * In case of a master password change, the password info database is re-encrypted with this new password.
     *
     * Only the password manager application is allowed to call this API.
     *
     * @param oldPassword the current master password if any, or null if none exists yet.
     * @param newPassword the new master password
     */
    public void setMasterPassword(String oldPassword, String newPassword, String appID) throws Exception {
        if (!appIsPasswordManager(appID)) {
            Log.e(LOG_TAG, "Only the password manager application can call this API");
            return;
        }
        // TODO
    }

    /**
     * If the master password has ben unlocked earlier, all passwords are accessible for a while.
     * This API re-locks the passwords database and further requests from applications to this password
     * manager will require user to provide his master password again.
     */
    public void lockMasterPassword(String did, String appID) {
        if (!appIsPasswordManager(appID)) {
            Log.e(LOG_TAG, "Only the password manager application can call this API");
            return;
        }

        lockDatabase(did);
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
    public void setUnlockMode(PasswordUnlockMode unlockMode, String did, String appID) {
        if (!appIsPasswordManager(appID)) {
            Log.e(LOG_TAG, "Only the password manager application can call this API");
            return;
        }

        getPrefs().edit().putInt(PREF_KEY_UNLOCK_MODE, unlockMode.ordinal()).apply();

        // if the mode becomes UNLOCK_EVERY_TIME, we lock the database
        if (getUnlockMode() != PasswordUnlockMode.UNLOCK_EVERY_TIME && unlockMode == PasswordUnlockMode.UNLOCK_EVERY_TIME) {
            lockDatabase(did);
        }
    }

    private PasswordUnlockMode getUnlockMode() {
        int savedUnlockModeAsInt = getPrefs().getInt(PREF_KEY_UNLOCK_MODE, PasswordUnlockMode.UNLOCK_FOR_A_WHILE.ordinal());
        return PasswordUnlockMode.fromValue(savedUnlockModeAsInt);
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
    public void setAppsPasswordStrategy(AppsPasswordStrategy strategy, String did, String appID) {
        if (!appIsPasswordManager(appID)) {
            Log.e(LOG_TAG, "Only the password manager application can call this API");
            return;
        }

        getPrefs().edit().putInt(PREF_KEY_APPS_PASSWORD_STRATEGY, strategy.ordinal()).apply();

        // if the mode becomes DONT_USE_MASTER_PASSWORD, we lock the database
        if (getAppsPasswordStrategy() != AppsPasswordStrategy.DONT_USE_MASTER_PASSWORD && strategy == AppsPasswordStrategy.DONT_USE_MASTER_PASSWORD) {
            lockDatabase(did);
        }
    }

    /**
     * Returns the current apps password strategy. If nothing was et earlier, default value
     * is LOCK_WITH_MASTER_PASSWORD.
     *
     * @returns The current apps password strategy
     */
    public AppsPasswordStrategy getAppsPasswordStrategy() {
        int savedPasswordStrategyAsInt = getPrefs().getInt(PREF_KEY_APPS_PASSWORD_STRATEGY, AppsPasswordStrategy.LOCK_WITH_MASTER_PASSWORD.ordinal());
        return AppsPasswordStrategy.fromValue(savedPasswordStrategyAsInt);
    }

    private boolean appIsPasswordManager(String appId) {
        return appId.equals(PASSWORD_MANAGER_APP_ID);
    }

    private void loadDatabase(String did, OnDatabaseLoadedListener listener) {
        if (isDatabaseLoaded(did)) {
            listener.onDatabaseLoaded();
        }
        else {
            // Master password is locked - prompt it to user
            new MasterPasswordPrompter().prompt(new OnMasterPasswordRetrievedListener() {
                @Override
                public void onMasterPasswordRetrieved(String password) {
                    try {
                        loadEncryptedDatabase(did, password);
                        if (isDatabaseLoaded(did))
                            listener.onDatabaseLoaded();
                        else
                            listener.onError("TODO - UNKNOWN - WRONG MASTER PASSWORD?");
                    }
                    catch (Exception e) {
                        listener.onError(e.getMessage());
                    }
                }

                @Override
                public void onCancel() {
                    listener.onCancel();
                }

                @Override
                public void onError(String error) {
                    listener.onError(error);
                }
            });
        }
    }

    private boolean isDatabaseLoaded(String did) {
        return (databasesInfo.get(did) != null);
    }

    private void lockDatabase(String did) {
        PasswordDatabaseInfo dbInfo = databasesInfo.get(did);
        if (dbInfo != null) {
            dbInfo.lock();
            databasesInfo.remove(did);
        }
    }

    /**
     * Using user's master password, decrypt the passwords list from disk and load it into memory.
     */
    private void loadEncryptedDatabase(String did, String masterPassword) throws Exception {
        String dataDir = activity.getFilesDir() + "/data/pwm/" + did;
        String dbPath = dataDir + "/store.db";

        File file = new File(dbPath);

        if (!file.exists()) {
            throw new Exception("No passwords database file exists");
        }

        StringBuilder jsonData = new StringBuilder();
        try {
            BufferedReader br = new BufferedReader(new FileReader(file));
            String line;

            while ((line = br.readLine()) != null) {
                jsonData.append(line);
                //jsonData.append('\n');
            }
            br.close();

            // Now that we've loaded the file, load it as a JSON object
            try {
                databasesInfo.put(did, PasswordDatabaseInfo.fromJson(jsonData.toString()));
            }
            catch (JSONException e) {
                throw new Exception("Passwords database JSON content for did "+did+" is corrupted");
            }
        }
        catch (IOException e) {
            throw new Exception("Passwords database file for did "+did+" is corrupted");
        }
    }

    private void setPasswordInfoReal(PasswordInfo info, String did, String appID) throws Exception {
        databasesInfo.get(did).setPasswordInfo(appID, info);
    }

    private PasswordInfo getPasswordInfoReal(String key, String did, String appID) throws Exception {
        return databasesInfo.get(did).getPasswordInfo(appID, key);
    }

    private ArrayList<PasswordInfo> getAllPasswordInfoReal(String did) throws Exception {
        return  databasesInfo.get(did).getAllPasswordInfo();
    }

    private void deletePasswordInfoReal(String key, String did, String targetAppID) throws Exception {
        databasesInfo.get(did).deletePasswordInfo(targetAppID, key);
    }

    private SharedPreferences getPrefs() {
        return activity.getSharedPreferences(SHARED_PREFS_KEY, Context.MODE_PRIVATE);
    }
}
