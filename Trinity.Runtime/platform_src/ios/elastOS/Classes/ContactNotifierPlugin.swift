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

@objc(ContactNotifierPlugin)
class ContactNotifierPlugin : TrinityPlugin {
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
   
    private func getNotifier() throws -> ContactNotifier {
        return ContactNotifier.getSharedInstance(did)
    }

    @objc func notifierGetCarrierAddress(_ command: CDVInvokedUrlCommand) {
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

    @objc func notifierResolveContact(_ command: CDVInvokedUrlCommand) {
        try {
            String contactDID = args.getString(0);

            Contact contact = getNotifier().resolveContact(contactDID);

            JSONObject result = new JSONObject();
            result.put("contact", contact.toJSONObject());
            sendSuccess(callbackContext, result);
        }
        catch (Exception e) {
            e.printStackTrace();
            sendError(callbackContext, "notifierResolveContact", e.getLocalizedMessage());
        }
    }

    @objc func notifierRemoveContact(_ command: CDVInvokedUrlCommand) {
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

    @objc func notifierSetOnlineStatusListener(_ command: CDVInvokedUrlCommand) {
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

    @objc func notifierSetOnlineStatusMode(_ command: CDVInvokedUrlCommand) {
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

    @objc func notifierGetOnlineStatusMode(_ command: CDVInvokedUrlCommand) {
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

    @objc func notifierSendInvitation(_ command: CDVInvokedUrlCommand) {
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

    @objc func notifierAcceptInvitation(_ command: CDVInvokedUrlCommand) {
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

    @objc func notifierRejectInvitation(_ command: CDVInvokedUrlCommand) {
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

    @objc func notifierSetOnInvitationAcceptedListener(_ command: CDVInvokedUrlCommand) {
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

    @objc func notifierSetInvitationRequestsMode(_ command: CDVInvokedUrlCommand) {
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

    @objc func notifierGetInvitationRequestsMode(_ command: CDVInvokedUrlCommand) {
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

    @objc func contactSendRemoteNotification(_ command: CDVInvokedUrlCommand) {
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

    @objc func contactSetAllowNotifications(_ command: CDVInvokedUrlCommand) {
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

    @objc func contactGetOnlineStatus(_ command: CDVInvokedUrlCommand) {
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

    private func contactDIDFromJSON(JSONObject contactAsJSON) throws -> String {
        if (!contactAsJSON.has("did"))
            return null;
        else
            return contactAsJSON.getString("did");
    }
}
