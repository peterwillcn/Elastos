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

public class DIDSessionManagerPlugin extends TrinityPlugin {
    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        try {
            switch (action) {
                case "addIdentityEntry":
                    this.addIdentityEntry(args, callbackContext);
                    break;
                case "deleteIdentityEntry":
                    this.deleteIdentityEntry(args, callbackContext);
                    break;
                case "getIdentityEntries":
                    this.getIdentityEntries(args, callbackContext);
                    break;
                case "getSignedInIdentity":
                    this.getSignedInIdentity(args, callbackContext);
                    break;
                case "signIn":
                    this.signIn(args, callbackContext);
                    break;
                case "signOut":
                    this.signOut(args, callbackContext);
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

    private void addIdentityEntry(JSONArray args, CallbackContext callbackContext) throws Exception {
        if (args.length() != 1) {
            callbackContext.error("Wrong number of parameters passed");
            return;
        }

        JSONObject identityEntryJson = args.getJSONObject(0);

        DIDSessionManager.IdentityEntry identityEntry = DIDSessionManager.IdentityEntry.fromJsonObject(identityEntryJson);
        DIDSessionManager.getSharedInstance().addIdentityEntry(identityEntry);

        callbackContext.success();
    }

    private void deleteIdentityEntry(JSONArray args, CallbackContext callbackContext) throws Exception {
        if (args.length() != 1) {
            callbackContext.error("Wrong number of parameters passed");
            return;
        }

        String didString = args.getString(0);

        DIDSessionManager.getSharedInstance().deleteIdentityEntry(didString);

        callbackContext.success();
    }

    private void getIdentityEntries(JSONArray args, CallbackContext callbackContext) throws Exception {
        if (args.length() != 0) {
            callbackContext.error("Wrong number of parameters passed");
            return;
        }

        ArrayList<DIDSessionManager.IdentityEntry> entries = DIDSessionManager.getSharedInstance().getIdentityEntries();

        JSONObject jsonObj = new JSONObject();
        JSONArray jsonEntries = new JSONArray();
        for (DIDSessionManager.IdentityEntry entry : entries) {
            jsonEntries.put(entry.asJsonObject());
        }
        jsonObj.put("entries", jsonEntries);

        sendSuccess(callbackContext, jsonObj);
    }

    private void getSignedInIdentity(JSONArray args, CallbackContext callbackContext) throws Exception {
        DIDSessionManager.IdentityEntry signedInIdentity = DIDSessionManager.getSharedInstance().getSignedInIdentity();

        if (signedInIdentity == null)
            callbackContext.success(); // Not signed in, no data to return
        else
            sendSuccess(callbackContext, signedInIdentity.asJsonObject());
    }

    private void signIn(JSONArray args, CallbackContext callbackContext) throws Exception {
        if (args.length() != 1) {
            callbackContext.error("Wrong number of parameters passed");
            return;
        }

        JSONObject identityEntryJson = args.getJSONObject(0);
        DIDSessionManager.IdentityEntry identityToSignIn = DIDSessionManager.IdentityEntry.fromJsonObject(identityEntryJson);
        DIDSessionManager.getSharedInstance().signIn(identityToSignIn);

        callbackContext.success();
    }

    private void signOut(JSONArray args, CallbackContext callbackContext) throws Exception {
        DIDSessionManager.getSharedInstance().signOut();
        callbackContext.success();
    }
}
