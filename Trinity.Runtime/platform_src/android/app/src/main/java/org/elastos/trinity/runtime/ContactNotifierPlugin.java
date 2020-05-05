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
import org.elastos.trinity.runtime.TrinityPlugin;
import org.elastos.trinity.runtime.contactnotifier.Contact;
import org.elastos.trinity.runtime.contactnotifier.ContactNotifier;
import org.elastos.trinity.runtime.contactnotifier.InvitationRequestsMode;
import org.elastos.trinity.runtime.contactnotifier.OnlineStatus;
import org.elastos.trinity.runtime.contactnotifier.OnlineStatusMode;
import org.elastos.trinity.runtime.contactnotifier.RemoteNotificationRequest;
import org.elastos.trinity.runtime.passwordmanager.AppsPasswordStrategy;
import org.elastos.trinity.runtime.passwordmanager.PasswordInfoBuilder;
import org.elastos.trinity.runtime.passwordmanager.PasswordManager;
import org.elastos.trinity.runtime.passwordmanager.PasswordUnlockMode;
import org.elastos.trinity.runtime.passwordmanager.passwordinfo.PasswordInfo;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;

public class ContactNotifierPlugin extends TrinityPlugin {
    private static final int NATIVE_ERROR_CODE_INVALID_PASSWORD = -1;
    private static final int NATIVE_ERROR_CODE_INVALID_PARAMETER = -2;
    private static final int NATIVE_ERROR_CODE_CANCELLED = -3;
    private static final int NATIVE_ERROR_CODE_UNSPECIFIED = -4;

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        try {
            switch (action) {
                case "notifierGetCarrierAddress":
                    this.notifierGetCarrierAddress(args, callbackContext);
                    break;
                case "notifierResolveContact":
                    this.notifierResolveContact(args, callbackContext);
                    break;
                case "notifierRemoveContact":
                    this.notifierRemoveContact(args, callbackContext);
                    break;
                case "notifierSetOnlineStatusListener":
                    this.notifierSetOnlineStatusListener(args, callbackContext);
                    break;
                case "notifierSetOnlineStatusMode":
                    this.notifierSetOnlineStatusMode(args, callbackContext);
                    break;
                case "notifierSendInvitation":
                    this.notifierSendInvitation(args, callbackContext);
                    break;
                case "notifierAcceptInvitation":
                    this.notifierAcceptInvitation(args, callbackContext);
                    break;
                case "notifierSetOnInvitationAcceptedListener":
                    this.setOnInvitationAcceptedListener(args, callbackContext);
                    break;
                case "notifierSetInvitationRequestsMode":
                    this.notifierSetInvitationRequestsMode(args, callbackContext);
                    break;

                case "contactSendRemoteNotification":
                    this.contactSendRemoteNotification(args, callbackContext);
                    break;
                case "contactSetAllowNotifications":
                    this.contactSetAllowNotifications(args, callbackContext);
                    break;
                case "contactGetOnlineStatus":
                    this.contactGetOnlineStatus(args ,callbackContext);
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

    private ContactNotifier getNotifier() {
        return ContactNotifier.getSharedInstance(cordova.getContext(), did);
    }

    private void notifierGetCarrierAddress(JSONArray args, CallbackContext callbackContext) throws Exception {
        String carrierAddress = getNotifier().getCarrierAddress();

        JSONObject result = new JSONObject();
        result.put("address", carrierAddress);
        sendSuccess(callbackContext, result);
    }

    private void notifierResolveContact(JSONArray args, CallbackContext callbackContext) throws Exception {
        String contactDID = args.getString(0);

        Contact contact = getNotifier().resolveContact(contactDID);

        JSONObject result = new JSONObject();
        result.put("contact", contact.toJSONObject());
        sendSuccess(callbackContext, result);
    }

    private void notifierRemoveContact(JSONArray args, CallbackContext callbackContext) throws Exception {
        String contactDID = args.getString(0);

        getNotifier().removeContact(contactDID);

        JSONObject result = new JSONObject();
        sendSuccess(callbackContext, result);
    }

    private void notifierSetOnlineStatusListener(JSONArray args, CallbackContext callbackContext) throws Exception {
        getNotifier().addOnlineStatusListener((contact, status) -> {
            try {
                JSONObject listenerResult = new JSONObject();
                listenerResult.put("contact", contact.toJSONObject());
                listenerResult.put("status", status.mValue);

                PluginResult res = new PluginResult(PluginResult.Status.OK, listenerResult);
                res.setKeepCallback(true);
                callbackContext.sendPluginResult(res);
            }
            catch (JSONException e) {
                e.printStackTrace();
            }
        });

        PluginResult result = new PluginResult(PluginResult.Status.NO_RESULT);
        result.setKeepCallback(true);
        callbackContext.sendPluginResult(result);
    }

    private void notifierSetOnlineStatusMode(JSONArray args, CallbackContext callbackContext) throws Exception {
        int onlineStatusModeAsInt = args.getInt(0);

        OnlineStatusMode mode = OnlineStatusMode.fromValue(onlineStatusModeAsInt);

        getNotifier().setOnlineStatusMode(mode);

        JSONObject result = new JSONObject();
        sendSuccess(callbackContext, result);
    }

    private void notifierSendInvitation(JSONArray args, CallbackContext callbackContext) throws Exception {
        String carrierAddress = args.getString(0);

        getNotifier().sendInvitation(carrierAddress);

        JSONObject result = new JSONObject();
        sendSuccess(callbackContext, result);
    }

    private void notifierAcceptInvitation(JSONArray args, CallbackContext callbackContext) throws Exception {
        String invitationId = args.getString(0);

        Contact connectedContact = getNotifier().acceptInvitation(invitationId);

        JSONObject result = new JSONObject();
        result.put("contact", connectedContact.toJSONObject());
        sendSuccess(callbackContext, result);
    }

    private void setOnInvitationAcceptedListener(JSONArray args, CallbackContext callbackContext) throws Exception {
        // TODO IMPORTANT: when an app is closed, need to remove the listener heer otherwise this will retain a memory
        // reference on that app and things can't be deallocated! Ask Dongxiao how to get notified when an app closes

        getNotifier().addOnInvitationAcceptedListener((contact) -> {
            try {
                JSONObject listenerResult = new JSONObject();
                listenerResult.put("contact", contact.toJSONObject());

                PluginResult res = new PluginResult(PluginResult.Status.OK, listenerResult);
                res.setKeepCallback(true);
                callbackContext.sendPluginResult(res);
            }
            catch (JSONException e) {
                e.printStackTrace();
            }
        });

        PluginResult result = new PluginResult(PluginResult.Status.NO_RESULT);
        result.setKeepCallback(true);
        callbackContext.sendPluginResult(result);
    }

    private void notifierSetInvitationRequestsMode(JSONArray args, CallbackContext callbackContext) throws Exception {
        int invitationRequestModeAsInt = args.getInt(0);

        InvitationRequestsMode mode = InvitationRequestsMode.fromValue(invitationRequestModeAsInt);

        getNotifier().setInvitationRequestsMode(mode);

        JSONObject result = new JSONObject();
        sendSuccess(callbackContext, result);
    }

    private void contactSendRemoteNotification(JSONArray args, CallbackContext callbackContext) throws Exception {
        JSONObject contactAsJson = args.getJSONObject(0);
        JSONObject notificationAsJson = args.getJSONObject(1);

        Contact contact = Contact.fromJSONObject(getNotifier(), contactAsJson);
        if (contact == null) {
            sendError(callbackContext, "contactSendRemoteNotification", "Invalid contact object");
            return;
        }

        RemoteNotificationRequest remoteNotificationRequest = RemoteNotificationRequest.fromJSONObject(notificationAsJson);

        contact.sendRemoteNotification(remoteNotificationRequest);

        JSONObject result = new JSONObject();
        sendSuccess(callbackContext, result);
    }

    private void contactSetAllowNotifications(JSONArray args, CallbackContext callbackContext) throws Exception {
        JSONObject contactAsJson = args.getJSONObject(0);
        boolean allowNotifications = args.getBoolean(1);

        Contact contact = Contact.fromJSONObject(getNotifier(), contactAsJson);
        if (contact == null) {
            sendError(callbackContext, "contactSetAllowNotifications", "Invalid contact object");
            return;
        }

        contact.setAllowNotifications(allowNotifications);

        JSONObject result = new JSONObject();
        sendSuccess(callbackContext, result);
    }

    private void contactGetOnlineStatus(JSONArray args, CallbackContext callbackContext) throws Exception {
        JSONObject contactAsJson = args.getJSONObject(0);

        Contact contact = Contact.fromJSONObject(getNotifier(), contactAsJson);
        if (contact == null) {
            sendError(callbackContext, "contactSetAllowNotifications", "Invalid contact object");
            return;
        }

        OnlineStatus status = contact.getOnlineStatus();

        JSONObject result = new JSONObject();
        result.put("onlineStatus", status.mValue);
        sendSuccess(callbackContext, result);
    }
}
