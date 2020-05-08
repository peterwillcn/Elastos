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
import org.elastos.trinity.runtime.notificationmanager.Notification;
import org.elastos.trinity.runtime.notificationmanager.NotificationManager;
import org.elastos.trinity.runtime.notificationmanager.NotificationRequest;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;


public class NotificationManagerPlugin extends TrinityPlugin {
    private static final int NATIVE_ERROR_CODE_INVALID_PASSWORD = -1;
    private static final int NATIVE_ERROR_CODE_INVALID_PARAMETER = -2;
    private static final int NATIVE_ERROR_CODE_CANCELLED = -3;
    private static final int NATIVE_ERROR_CODE_UNSPECIFIED = -4;

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        try {
            switch (action) {
                case "clearNotification":
                    this.clearNotification(args, callbackContext);
                    break;
                case "getNotifications":
                    this.getNotifications(args, callbackContext);
                    break;
                case "sendNotification":
                    this.sendNotification(args, callbackContext);
                    break;
                case "setNotificationListener":
                    this.setNotificationListener(args, callbackContext);
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
            result.put("code", NATIVE_ERROR_CODE_UNSPECIFIED);
            result.put("reason", error);
            return result;
        }
        catch (Exception e) {
            return null;
        }
    }

    private NotificationManager getNotifier() {
        return NotificationManager.getSharedInstance();
    }

    private void clearNotification(JSONArray args, CallbackContext callbackContext) throws Exception {
        try {
            String notificationId = args.getString(0);
            getNotifier().clearNotification(notificationId);

            JSONObject result = new JSONObject();
            sendSuccess(callbackContext, result);
        }
        catch (Exception e) {
            e.printStackTrace();
            sendError(callbackContext, "clearNotification", e.getLocalizedMessage());
        }
    }

    private void getNotifications(JSONArray args, CallbackContext callbackContext) throws Exception {
        try {
            ArrayList<Notification> notifications = getNotifier().getNotifications();

            JSONArray array = new JSONArray();
            for (Notification entry : notifications) {
                array.put(entry.toJSONObject());
            }

            JSONObject result = new JSONObject();
            result.put("notifications", array);
            sendSuccess(callbackContext, result);
        }
        catch (Exception e) {
            e.printStackTrace();
            sendError(callbackContext, "getNotifications", e.getLocalizedMessage());
        }
    }

    private void sendNotification(JSONArray args, CallbackContext callbackContext) throws Exception {
        try {
            JSONObject notificationRequestAsJson = args.getJSONObject(0);

            NotificationRequest notificationRequest = NotificationRequest.fromJSONObject(notificationRequestAsJson);

            getNotifier().sendNotification(notificationRequest, this.appId);

            JSONObject result = new JSONObject();
            sendSuccess(callbackContext, result);
        }
        catch (Exception e) {
            e.printStackTrace();
            sendError(callbackContext, "sendNotification", e.getLocalizedMessage());
        }
    }

    private void setNotificationListener(JSONArray args, CallbackContext callbackContext) throws Exception {
        try {
            getNotifier().setNotificationListener((notification) -> {
                try {
                    JSONObject listenerResult = new JSONObject();
                    listenerResult.put("notification", notification.toJSONObject());

                    PluginResult res = new PluginResult(PluginResult.Status.OK, listenerResult);
                    res.setKeepCallback(true);
                    callbackContext.sendPluginResult(res);
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            });

            PluginResult result = new PluginResult(PluginResult.Status.NO_RESULT);
            result.setKeepCallback(true);
            callbackContext.sendPluginResult(result);
        }
        catch (Exception e) {
            e.printStackTrace();
            sendError(callbackContext, "setNotificationListener", e.getLocalizedMessage());
        }
    }
}
