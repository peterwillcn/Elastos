package org.elastos.trinity.runtime;

import org.apache.cordova.CallbackContext;

public class IntentInfo {

    public static final int API = 0;
    public static final int JWT = 1;
    public static final int URL = 2;

    public static final String REDIRECT_URL = "redirecturl";
    public static final String CALLBACK_URL = "callbackurl";
    public static final String REDIRECT_APP_URL = "redirectappurl";

    String action;
    String params;
    String fromId;
    String toId;
    long intentId;
    CallbackContext callbackContext;

    String originalJwtRequest = null;
    String redirecturl = null;
    String callbackurl = null;
    String redirectappurl = null;
    String aud = null;
    String req = null;
    int type = API;

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
