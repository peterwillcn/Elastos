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
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;

public class PasswordManagerPlugin extends TrinityPlugin {

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
                default:
                    return false;
            }
        }
        catch (Exception e) {
            callbackContext.error(e.getLocalizedMessage());
        }
        return true;
    }

    private void setPasswordInfo(JSONArray args, CallbackContext callbackContext) throws Exception {
        JSONObject info = args.getJSONObject(0);
        callbackContext.success();
    }

    private void getPasswordInfo(JSONArray args, CallbackContext callbackContext) throws Exception {
        JSONObject info = args.getJSONObject(0);
        callbackContext.success();
    }

    private void getAllPasswordInfo(JSONArray args, CallbackContext callbackContext) throws Exception {
        JSONObject info = args.getJSONObject(0);
        callbackContext.success();
    }

    private void deletePasswordInfo(JSONArray args, CallbackContext callbackContext) throws Exception {
        JSONObject info = args.getJSONObject(0);
        callbackContext.success();
    }

    private void generateRandomPassword(JSONArray args, CallbackContext callbackContext) throws Exception {
        JSONObject info = args.getJSONObject(0);
        callbackContext.success();
    }

    private void setMasterPassword(JSONArray args, CallbackContext callbackContext) throws Exception {
        JSONObject info = args.getJSONObject(0);
        callbackContext.success();
    }

    private void lockMasterPassword(JSONArray args, CallbackContext callbackContext) throws Exception {
        JSONObject info = args.getJSONObject(0);
        callbackContext.success();
    }

    private void setUnlockMode(JSONArray args, CallbackContext callbackContext) throws Exception {
        JSONObject info = args.getJSONObject(0);
        callbackContext.success();
    }

    private void setAppsPasswordStrategy(JSONArray args, CallbackContext callbackContext) throws Exception {
        JSONObject info = args.getJSONObject(0);
        callbackContext.success();
    }
}
