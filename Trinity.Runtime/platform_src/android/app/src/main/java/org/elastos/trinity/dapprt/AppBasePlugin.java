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

package org.elastos.trinity.dapprt;

import android.net.Uri;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class AppBasePlugin extends CordovaPlugin {
    protected CallbackContext mMessageContext = null;
    protected String id;

    protected void launcher(JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (AppManager.appManager.loadLauncher()) {
            callbackContext.success("ok");
        }
        else {
            callbackContext.error("error");
        }
    }

    protected void start(JSONArray args, CallbackContext callbackContext) throws JSONException {
        String id = args.getString(0);
        if (!id.equals("launcher") && AppManager.appManager.start(id)) {
            callbackContext.success("ok");
        }
        else {
            callbackContext.error("error");
        }
    }

    protected void close(JSONArray args, CallbackContext callbackContext) throws JSONException {
        String appId = this.id;
        if (id.equals("launcher")) {
            appId = args.getString(0);
        }

        if (appId != null && AppManager.appManager.close(appId)) {
            callbackContext.success("ok");
        }
        else {
            callbackContext.error("error");
        }
    }

    protected void sendMessage(JSONArray args, CallbackContext callbackContext) throws JSONException {
        String toId = args.getString(0);
        Integer type = args.getInt(1);
        String msg = args.getString(2);
        if (AppManager.appManager.sendMessage(toId, type, msg, this.id)) {
            callbackContext.success("ok");
        }
        else {
            callbackContext.error("error");
        }
    }

    protected void setListener(JSONArray args, CallbackContext callbackContext) throws JSONException {
        mMessageContext = callbackContext;

        PluginResult pluginResult = new PluginResult(PluginResult.Status.NO_RESULT);
        pluginResult.setKeepCallback(true);
        callbackContext.sendPluginResult(pluginResult);

        if (id.equals("launcher")) {
            AppManager.appManager.setLauncherReady();
        }
    }

    public void onReceive(String msg, int type, String from) {
        if (mMessageContext == null) return;

        JSONObject r = new JSONObject();
        try {
            r.put("message", msg);
            r.put("type", type);
            r.put("from", from);
            PluginResult result = new PluginResult(PluginResult.Status.OK, r);
            result.setKeepCallback(true);
            mMessageContext.sendPluginResult(result);
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }

//    @Override
//    public Object onMessage(String event, Object data) {
//        if (event.equals("onPageFinished")) {
//            webView.loadUrl("javascript:(function(){\n" +
//                    "    var head = document.getElementsByTagName('head')[0];\n" +
//                    "    var script = document.createElement('script');\n" +
//                    "    script.type = 'text/javascript';\n" +
//                    "    script.src = \"file:///android_asset/www/cordova.js\";\n" +
//                    "    head.appendChild(script);\n" +
//                    "    })();");
//        }
//        return null;
//    }

    @Override
    public Boolean shouldAllowRequest(String url) {
        if (url.startsWith("assets://www/cordova") || url.startsWith("assets://www/plugins")) {
            return true;
        }
        return false;
    }

    @Override
    public Uri remapUri(Uri uri) {
        if ("assets".equals(uri.getScheme())) {
            String path = uri.getPath();
            uri = Uri.parse("file:///android_asset/www" + path);
            return uri;
        }
        return null;
    }

}
