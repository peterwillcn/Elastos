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

package org.elastos.trinity.runtime;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.PluginResult;
import org.elastos.trinity.runtime.passwordmanager.AppsPasswordStrategy;
import org.elastos.trinity.runtime.passwordmanager.PasswordInfoBuilder;
import org.elastos.trinity.runtime.passwordmanager.passwordinfo.PasswordInfo;
import org.elastos.trinity.runtime.passwordmanager.PasswordManager;
import org.elastos.trinity.runtime.passwordmanager.PasswordUnlockMode;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;

public class PasswordManagerPlugin extends TrinityPlugin {
    private static final int NATIVE_ERROR_CODE_INVALID_PASSWORD = -1;
    private static final int NATIVE_ERROR_CODE_INVALID_PARAMETER = -2;
    private static final int NATIVE_ERROR_CODE_CANCELLED = -3;
    private static final int NATIVE_ERROR_CODE_UNSPECIFIED = -4;

    public class BooleanWithReason {
        public boolean value;
        public String reason;

        BooleanWithReason(boolean value, String reason) {
            this.value = value;
            this.reason = reason;
        }
    }

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        try {
            switch (action) {
                case "setPasswordInfo":
                    this.setPasswordInfo(args, callbackContext);
                    break;
                case "getPasswordInfo":
                    this.getPasswordInfo(args, callbackContext);
                    break;
                case "getAllPasswordInfo":
                    this.getAllPasswordInfo(args, callbackContext);
                    break;
                case "deletePasswordInfo":
                    this.deletePasswordInfo(args, callbackContext);
                    break;
                case "deleteAppPasswordInfo":
                    this.deleteAppPasswordInfo(args, callbackContext);
                    break;
                case "generateRandomPassword":
                    this.generateRandomPassword(args, callbackContext);
                    break;
                case "setMasterPassword":
                    this.setMasterPassword(args, callbackContext);
                    break;
                case "lockMasterPassword":
                    this.lockMasterPassword(args, callbackContext);
                    break;
                case "setUnlockMode":
                    this.setUnlockMode(args, callbackContext);
                    break;
                case "setAppsPasswordStrategy":
                    this.setAppsPasswordStrategy(args, callbackContext);
                    break;
                case "getAppsPasswordStrategy":
                    this.getAppsPasswordStrategy(args, callbackContext);
                    break;
                default:
                    return false;
            }
        }
        catch (Exception e) {
            callbackContext.error(e.getLocalizedMessage());
        }
        return true;
    }

    private void sendSuccess(CallbackContext callbackContext, JSONObject jsonObj) {
        callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.OK, jsonObj));
    }

    private void sendError(CallbackContext callbackContext, JSONObject jsonObj) {
        callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.ERROR, jsonObj));
    }

    private void sendError(CallbackContext callbackContext, String method, String message) {
        callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.ERROR, method+": "+message));
    }

    private JSONObject buildCancellationError() {
        try {
            JSONObject result = new JSONObject();
            result.put("code", NATIVE_ERROR_CODE_CANCELLED);
            return result;
        }
        catch (Exception e) {
            return null;
        }
    }

    private JSONObject buildGenericError(String error) {
        try {
            JSONObject result = new JSONObject();
            if (error.contains("BAD_DECRYPT"))
                result.put("code", NATIVE_ERROR_CODE_INVALID_PASSWORD);
            else
                result.put("code", NATIVE_ERROR_CODE_UNSPECIFIED);
            result.put("reason", error);
            return result;
        }
        catch (Exception e) {
            return null;
        }
    }

    private void setPasswordInfo(JSONArray args, CallbackContext callbackContext) throws Exception {
        JSONObject info = args.getJSONObject(0);

        PasswordInfo passwordInfo = PasswordInfoBuilder.buildFromType(info);
        if (passwordInfo == null) {
            sendError(callbackContext, "setPasswordInfo", "Invalid JSON object for password info");
            return;
        }

        JSONObject result = new JSONObject();
        PasswordManager.getSharedInstance().setPasswordInfo(passwordInfo, did, appId, new PasswordManager.OnPasswordInfoSetListener(){
            @Override
            public void onPasswordInfoSet() {
                try {
                    result.put("couldSet", true);
                }
                catch (JSONException ignored) {}
                sendSuccess(callbackContext, result);
            }

            @Override
            public void onCancel() {
                sendError(callbackContext, buildCancellationError());
            }

            @Override
            public void onError(String error) {
                sendError(callbackContext, buildGenericError(error));
            }
        });
    }

    private void getPasswordInfo(JSONArray args, CallbackContext callbackContext) throws Exception {
        String key = args.getString(0);

        JSONObject result = new JSONObject();
        PasswordManager.getSharedInstance().getPasswordInfo(key, did, appId, new PasswordManager.OnPasswordInfoRetrievedListener() {
            @Override
            public void onPasswordInfoRetrieved(PasswordInfo info) {
                try {
                    if (info != null)
                        result.put("passwordInfo", info.asJsonObject());
                    else
                        result.put("passwordInfo", null);
                }
                catch (JSONException ignored) {}
                sendSuccess(callbackContext, result);
            }

            @Override
            public void onCancel() {
                sendError(callbackContext, buildCancellationError());
            }

            @Override
            public void onError(String error) {
                sendError(callbackContext, buildGenericError(error));
            }
        });
    }

    private void getAllPasswordInfo(JSONArray args, CallbackContext callbackContext) throws Exception {
        JSONObject result = new JSONObject();
        PasswordManager.getSharedInstance().getAllPasswordInfo(did, appId, new PasswordManager.OnAllPasswordInfoRetrievedListener() {
            @Override
            public void onAllPasswordInfoRetrieved(ArrayList<PasswordInfo> infos) {
                try {
                    JSONArray allPasswordInfo = new JSONArray();
                    for (PasswordInfo info : infos) {
                        allPasswordInfo.put(info.asJsonObject());
                    }

                    result.put("allPasswordInfo", allPasswordInfo);

                    sendSuccess(callbackContext, result);
                }
                catch (Exception e) {
                    sendError(callbackContext, "getAllPasswordInfo", e.getMessage());
                }
            }

            @Override
            public void onCancel() {
                sendError(callbackContext, buildCancellationError());
            }

            @Override
            public void onError(String error) {
                sendError(callbackContext, buildGenericError(error));
            }
        });
    }

    private void deletePasswordInfo(JSONArray args, CallbackContext callbackContext) throws Exception {
        String key = args.getString(0);

        JSONObject result = new JSONObject();
        PasswordManager.getSharedInstance().deletePasswordInfo(key, did, appId, appId, new PasswordManager.OnPasswordInfoDeletedListener() {
            @Override
            public void onPasswordInfoDeleted() {
                try {
                    result.put("couldDelete", true);
                }
                catch (JSONException ignored) {}
                sendSuccess(callbackContext, result);
            }

            @Override
            public void onCancel() {
                sendError(callbackContext, buildCancellationError());
            }

            @Override
            public void onError(String error) {
                sendError(callbackContext, buildGenericError(error));
            }
        });
    }

    private void deleteAppPasswordInfo(JSONArray args, CallbackContext callbackContext) throws Exception {
        String targetAppID = args.getString(0);
        String key = args.getString(1);

        JSONObject result = new JSONObject();
        PasswordManager.getSharedInstance().deletePasswordInfo(key, did, appId, targetAppID, new PasswordManager.OnPasswordInfoDeletedListener() {
            @Override
            public void onPasswordInfoDeleted() {
                try {
                    result.put("couldDelete", true);
                }
                catch (JSONException ignored) {}
                sendSuccess(callbackContext, result);
            }

            @Override
            public void onCancel() {
                sendError(callbackContext, buildCancellationError());
            }

            @Override
            public void onError(String error) {
                sendError(callbackContext, buildGenericError(error));
            }
        });
    }

    private void generateRandomPassword(JSONArray args, CallbackContext callbackContext) throws Exception {
        JSONObject options = args.getJSONObject(0); // Currently unused

        String password = PasswordManager.getSharedInstance().generateRandomPassword(null);

        JSONObject result = new JSONObject();
        result.put("generatedPassword", password);

        sendSuccess(callbackContext, result);
    }

    private void setMasterPassword(JSONArray args, CallbackContext callbackContext) throws Exception {
        String oldPassword = args.getString(0);
        String newPassword = args.getString(1);

        JSONObject result = new JSONObject();
        try {
            PasswordManager.getSharedInstance().setMasterPassword(oldPassword, newPassword, did, appId);
            result.put("couldSet", true);
        }
        catch (Exception e) {
            result.put("couldSet", false);
            result.put("reason", e.getMessage());
        }

        sendSuccess(callbackContext, result);
    }

    private void lockMasterPassword(JSONArray args, CallbackContext callbackContext) throws Exception {
        PasswordManager.getSharedInstance().lockMasterPassword(did, appId);

        JSONObject result = new JSONObject();

        sendSuccess(callbackContext, result);
    }

    private void setUnlockMode(JSONArray args, CallbackContext callbackContext) throws Exception {
        int unlockModeAsInt = args.getInt(0);

        PasswordUnlockMode unlockMode = PasswordUnlockMode.fromValue(unlockModeAsInt);

        PasswordManager.getSharedInstance().setUnlockMode(unlockMode, did, appId);

        JSONObject result = new JSONObject();

        sendSuccess(callbackContext, result);
    }

    private void setAppsPasswordStrategy(JSONArray args, CallbackContext callbackContext) throws Exception {
        int appsPasswordStrategyAsInt = args.getInt(0);

        AppsPasswordStrategy appsPasswordStrategy = AppsPasswordStrategy.fromValue(appsPasswordStrategyAsInt);

        PasswordManager.getSharedInstance().setAppsPasswordStrategy(appsPasswordStrategy, did, appId, false);

        JSONObject result = new JSONObject();

        sendSuccess(callbackContext, result);
    }

    private void getAppsPasswordStrategy(JSONArray args, CallbackContext callbackContext) throws Exception {
        AppsPasswordStrategy appsPasswordStrategy = PasswordManager.getSharedInstance().getAppsPasswordStrategy();

        JSONObject result = new JSONObject();
        result.put("strategy", appsPasswordStrategy.ordinal());

        sendSuccess(callbackContext, result);
    }
}
