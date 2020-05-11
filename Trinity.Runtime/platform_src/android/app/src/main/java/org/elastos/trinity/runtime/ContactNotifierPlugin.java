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
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.PluginResult;
import org.elastos.carrier.Carrier;
import org.elastos.carrier.exceptions.CarrierException;
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
                case "notifierGetOnlineStatusMode":
                    this.notifierGetOnlineStatusMode(args, callbackContext);
                    break;
                case "notifierSendInvitation":
                    this.notifierSendInvitation(args, callbackContext);
                    break;
                case "notifierAcceptInvitation":
                    this.notifierAcceptInvitation(args, callbackContext);
                    break;
                case "notifierRejectInvitation":
                    this.notifierRejectInvitation(args, callbackContext);
                    break;
                case "notifierSetOnInvitationAcceptedListener":
                    this.notifierSetOnInvitationAcceptedListener(args, callbackContext);
                    break;
                case "notifierSetInvitationRequestsMode":
                    this.notifierSetInvitationRequestsMode(args, callbackContext);
                    break;
                case "notifierGetInvitationRequestsMode":
                    this.notifierGetInvitationRequestsMode(args, callbackContext);
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

    private ContactNotifier getNotifier() throws CarrierException {
        return ContactNotifier.getSharedInstance(cordova.getContext(), did);
    }

    private void notifierGetCarrierAddress(JSONArray args, CallbackContext callbackContext) throws Exception {
        try {
            String carrierAddress = getNotifier().getCarrierAddress();

            JSONObject result = new JSONObject();
            result.put("address", carrierAddress);
            sendSuccess(callbackContext, result);
        }
        catch (Exception e) {
            e.printStackTrace();
            sendError(callbackContext, "notifierGetCarrierAddress", e.getLocalizedMessage());
        }
    }

    private void notifierResolveContact(JSONArray args, CallbackContext callbackContext) throws Exception {
        try {
            String contactDID = args.getString(0);

            Contact contact = getNotifier().resolveContact(contactDID);

            JSONObject result = new JSONObject();
            if (contact != null)
                result.put("contact", contact.toJSONObject());
            else
                result.put("contact", null);
            sendSuccess(callbackContext, result);
        }
        catch (Exception e) {
            e.printStackTrace();
            sendError(callbackContext, "notifierResolveContact", e.getLocalizedMessage());
        }
    }

    private void notifierRemoveContact(JSONArray args, CallbackContext callbackContext) throws Exception {
        try {
            String contactDID = args.getString(0);

            getNotifier().removeContact(contactDID);

            JSONObject result = new JSONObject();
            sendSuccess(callbackContext, result);
        }
        catch (Exception e) {
            e.printStackTrace();
            sendError(callbackContext, "notifierRemoveContact", e.getLocalizedMessage());
        }
    }

    private void notifierSetOnlineStatusListener(JSONArray args, CallbackContext callbackContext) throws Exception {
        try {
            getNotifier().addOnlineStatusListener((contact, status) -> {
                try {
                    JSONObject listenerResult = new JSONObject();
                    listenerResult.put("contact", contact.toJSONObject());
                    listenerResult.put("status", status.mValue);

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
            sendError(callbackContext, "notifierSetOnlineStatusListener", e.getLocalizedMessage());
        }
    }

    private void notifierSetOnlineStatusMode(JSONArray args, CallbackContext callbackContext) throws Exception {
        try {
            int onlineStatusModeAsInt = args.getInt(0);

            OnlineStatusMode mode = OnlineStatusMode.fromValue(onlineStatusModeAsInt);

            getNotifier().setOnlineStatusMode(mode);

            JSONObject result = new JSONObject();
            sendSuccess(callbackContext, result);
        }
        catch (Exception e) {
            e.printStackTrace();
            sendError(callbackContext, "notifierSetOnlineStatusMode", e.getLocalizedMessage());
        }
    }

    private void notifierGetOnlineStatusMode(JSONArray args, CallbackContext callbackContext) throws Exception {
        try {
            OnlineStatusMode mode = getNotifier().getOnlineStatusMode();

            JSONObject result = new JSONObject();
            result.put("onlineStatusMode", mode.mValue);
            sendSuccess(callbackContext, result);
        }
        catch (Exception e) {
            e.printStackTrace();
            sendError(callbackContext, "notifierGetOnlineStatusMode", e.getLocalizedMessage());
        }
    }

    private void notifierSendInvitation(JSONArray args, CallbackContext callbackContext) throws Exception {
        try {
            String did = args.getString(0);
            String carrierAddress = args.getString(1);

            getNotifier().sendInvitation(did, carrierAddress);

            JSONObject result = new JSONObject();
            sendSuccess(callbackContext, result);
        }
        catch (Exception e) {
            e.printStackTrace();
            sendError(callbackContext, "notifierSendInvitation", e.getLocalizedMessage());
        }
    }

    private void notifierAcceptInvitation(JSONArray args, CallbackContext callbackContext) throws Exception {
        try {
            String invitationId = args.getString(0);

            getNotifier().acceptInvitation(invitationId, new ContactNotifier.OnInvitationAcceptedByUsListener() {
                @Override
                public void onInvitationAccepted(Contact contact) {
                    try {
                        JSONObject result = new JSONObject();
                        result.put("contact", contact.toJSONObject());
                        sendSuccess(callbackContext, result);
                    }
                    catch (JSONException e) {
                        e.printStackTrace();
                        sendError(callbackContext, "notifierAcceptInvitation", e.getLocalizedMessage());
                    }
                }

                @Override
                public void onNotExistingInvitation() {
                    sendError(callbackContext, "notifierAcceptInvitation", "No pending invitation found for the given invitation ID");
                }

                @Override
                public void onError(String reason) {
                    sendError(callbackContext, "notifierAcceptInvitation", reason);
                }
            });
        }
        catch (Exception e) {
            e.printStackTrace();
            sendError(callbackContext, "notifierAcceptInvitation", e.getLocalizedMessage());
        }
    }

    private void notifierRejectInvitation(JSONArray args, CallbackContext callbackContext) throws Exception {
        try {
            String invitationId = args.getString(0);

            getNotifier().rejectInvitation(invitationId);

            JSONObject result = new JSONObject();
            sendSuccess(callbackContext, result);
        }
        catch (Exception e) {
            e.printStackTrace();
            sendError(callbackContext, "notifierRejectInvitation", e.getLocalizedMessage());
        }
    }

    private void notifierSetOnInvitationAcceptedListener(JSONArray args, CallbackContext callbackContext) throws Exception {
        try {
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
        catch (Exception e) {
            e.printStackTrace();
            sendError(callbackContext, "notifierSetOnInvitationAcceptedListener", e.getLocalizedMessage());
        }
    }

    private void notifierSetInvitationRequestsMode(JSONArray args, CallbackContext callbackContext) throws Exception {
        try {
            int invitationRequestModeAsInt = args.getInt(0);

            InvitationRequestsMode mode = InvitationRequestsMode.fromValue(invitationRequestModeAsInt);

            getNotifier().setInvitationRequestsMode(mode);

            JSONObject result = new JSONObject();
            sendSuccess(callbackContext, result);
        }
        catch (Exception e) {
            e.printStackTrace();
            sendError(callbackContext, "notifierSetInvitationRequestsMode", e.getLocalizedMessage());
        }
    }

    private void notifierGetInvitationRequestsMode(JSONArray args, CallbackContext callbackContext) throws Exception {
        try {
            InvitationRequestsMode mode = getNotifier().getInvitationRequestsMode();

            JSONObject result = new JSONObject();
            result.put("invitationRequestsMode", mode.mValue);
            sendSuccess(callbackContext, result);
        }
        catch (Exception e) {
            e.printStackTrace();
            sendError(callbackContext, "notifierGetInvitationRequestsMode", e.getLocalizedMessage());
        }
    }

    private void contactSendRemoteNotification(JSONArray args, CallbackContext callbackContext) throws Exception {
        try {
            JSONObject contactAsJson = args.getJSONObject(0);
            JSONObject notificationAsJson = args.getJSONObject(1);

            Contact contact = getNotifier().resolveContact(contactDIDFromJSON(contactAsJson));
            if (contact == null) {
                sendError(callbackContext, "contactSendRemoteNotification", "Invalid contact object");
                return;
            }

            RemoteNotificationRequest remoteNotificationRequest = RemoteNotificationRequest.fromJSONObject(notificationAsJson);

            contact.sendRemoteNotification(remoteNotificationRequest);

            JSONObject result = new JSONObject();
            sendSuccess(callbackContext, result);
        }
        catch (Exception e) {
            e.printStackTrace();
            sendError(callbackContext, "contactSendRemoteNotification", e.getLocalizedMessage());
        }
    }

    private void contactSetAllowNotifications(JSONArray args, CallbackContext callbackContext) throws Exception {
        try {
            JSONObject contactAsJson = args.getJSONObject(0);
            boolean allowNotifications = args.getBoolean(1);

            Contact contact = getNotifier().resolveContact(contactDIDFromJSON(contactAsJson));
            if (contact == null) {
                sendError(callbackContext, "contactSetAllowNotifications", "Invalid contact object");
                return;
            }

            contact.setAllowNotifications(allowNotifications);

            JSONObject result = new JSONObject();
            sendSuccess(callbackContext, result);
        }
        catch (Exception e) {
            e.printStackTrace();
            sendError(callbackContext, "contactSetAllowNotifications", e.getLocalizedMessage());
        }
    }

    private void contactGetOnlineStatus(JSONArray args, CallbackContext callbackContext) throws Exception {
        try {
            JSONObject contactAsJson = args.getJSONObject(0);

            Contact contact = getNotifier().resolveContact(contactDIDFromJSON(contactAsJson));
            if (contact == null) {
                sendError(callbackContext, "contactSetAllowNotifications", "Invalid contact object");
                return;
            }

            OnlineStatus status = contact.getOnlineStatus();

            JSONObject result = new JSONObject();
            result.put("onlineStatus", status.mValue);
            sendSuccess(callbackContext, result);
        }
        catch (Exception e) {
            e.printStackTrace();
            sendError(callbackContext, "contactGetOnlineStatus", e.getLocalizedMessage());
        }
    }

    private String contactDIDFromJSON(JSONObject contactAsJSON) throws JSONException {
        if (!contactAsJSON.has("did"))
            return null;
        else
            return contactAsJSON.getString("did");
    }
}
