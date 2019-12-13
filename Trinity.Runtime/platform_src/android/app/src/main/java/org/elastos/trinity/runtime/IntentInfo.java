package org.elastos.trinity.runtime;

import org.apache.cordova.CallbackContext;

public class IntentInfo {
    String action;
    String params;
    String fromId;
    String toId;
    long intentId;
    CallbackContext callbackContext;

    String jwt = null;
    String redirecturl = null;
    String callbackurl = null;
    String aud = null;
    String req = null;
    boolean isJWT = false;

    IntentInfo(String action, String params, String fromId, String toId,
               long intentId, CallbackContext callbackContext) {
        this.action = action;
        this.params = params;
        this.fromId = fromId;
        this.toId = toId;
        this.intentId = intentId;
        this.callbackContext = callbackContext;
    }

}
