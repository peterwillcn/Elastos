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

import android.net.Uri;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

public class AppBasePlugin extends CordovaPlugin {
    protected CallbackContext mMessageContext = null;
    protected String id;

    protected void launcher(JSONArray args, CallbackContext callbackContext) throws Exception {
        AppManager.appManager.loadLauncher();
        callbackContext.success("ok");
    }

    protected void start(JSONArray args, CallbackContext callbackContext) throws Exception {
        String id = args.getString(0);

        if (id == null || id.equals("")) {
            callbackContext.error("Invalid id.");
        } else if (id.equals("launcher")) {
            callbackContext.error("Can't start launcher! Please use launcher().");
        } else {
            AppManager.appManager.start(id);
            callbackContext.success("ok");
        }
    }

    protected void close(JSONArray args, CallbackContext callbackContext) throws Exception {
        String appId = this.id;
        if (id.equals("launcher")) {
            appId = args.getString(0);
        }

        if (appId == null || appId.equals("")) {
            callbackContext.error("Invalid id.");
        }
        AppManager.appManager.close(appId);
        callbackContext.success("ok");
    }

    private List<JSONObject> jsonAppPlugins(ArrayList<AppInfo.PluginAuth> plugins) throws JSONException {
        List<JSONObject> jsons = new ArrayList<JSONObject>();
        for (AppInfo.PluginAuth pluginAuth : plugins) {
            JSONObject r = new JSONObject();
            r.put("plugin", pluginAuth.plugin);
            r.put("authority", pluginAuth.authority);
            jsons.add(r);
        }
        return jsons;
    }

    private List<JSONObject> jsonAppUrls(ArrayList<AppInfo.UrlAuth> plugins) throws JSONException {
        List<JSONObject> jsons = new ArrayList<JSONObject>();
        for (AppInfo.UrlAuth urlAuth : plugins) {
            JSONObject r = new JSONObject();
            r.put("url", urlAuth.url);
            r.put("authority", urlAuth.authority);
            jsons.add(r);
        }
        return jsons;
    }

    private List<JSONObject> jsonAppIcons(AppInfo info) throws JSONException {
        List<JSONObject> jsons = new ArrayList<JSONObject>();
        String appUrl = AppManager.appManager.getAppUrl(info);
        for (AppInfo.Icon icon : info.icons) {
            JSONObject r = new JSONObject();
            r.put("src", AppManager.appManager.resetPath(appUrl, icon.src));
            r.put("sizes", icon.sizes);
            r.put("type", icon.type);
            jsons.add(r);
        }
        return jsons;
    }

    protected JSONObject jsonAppInfo(AppInfo info) throws JSONException {
        String appUrl = AppManager.appManager.getAppUrl(info);
        String dataUrl = AppManager.appManager.getDataUrl(info.app_id);
        JSONObject r = new JSONObject();
        r.put("id", info.app_id);
        r.put("version", info.version);
        r.put("name", info.name);
        r.put("shortName", info.short_name);
        r.put("description", info.description);
        r.put("startUrl", AppManager.appManager.getStartPath(info));
        r.put("icons", jsonAppIcons(info));
        r.put("authorName", info.author_name);
        r.put("authorEmail", info.author_email);
        r.put("defaultLocale", info.default_locale);
        r.put("plugins", jsonAppPlugins(info.plugins));
        r.put("urls", jsonAppUrls(info.urls));
        r.put("backgroundColor", info.background_color);
        r.put("themeDisplay", info.theme_display);
        r.put("themeColor", info.theme_color);
        r.put("themeFontName", info.theme_font_name);
        r.put("themeFontColor", info.theme_font_color);
        r.put("installTime", info.install_time);
        r.put("builtIn", info.built_in);
        r.put("remote", info.remote);
        r.put("appPath", appUrl);
        r.put("dataPath", dataUrl);
        return r;
    }

    protected void getAppInfo(JSONArray args, CallbackContext callbackContext) throws JSONException {
        String appId = this.id;
        if (this.id == "launcher") {
            appId = args.getString(0);
        }

        AppInfo info = AppManager.appManager.getAppInfo(appId);
        if (info != null) {
            callbackContext.success(jsonAppInfo(info));
        } else {
            callbackContext.error("No such app!");
        }
    }

    protected void sendMessage(JSONArray args, CallbackContext callbackContext) throws Exception {
        String toId = args.getString(0);
        Integer type = args.getInt(1);
        String msg = args.getString(2);
        AppManager.appManager.sendMessage(toId, type, msg, this.id);
        callbackContext.success("ok");
    }

    protected void setListener(CallbackContext callbackContext) {
        mMessageContext = callbackContext;

        PluginResult pluginResult = new PluginResult(PluginResult.Status.NO_RESULT);
        pluginResult.setKeepCallback(true);
        callbackContext.sendPluginResult(pluginResult);

        if (id.equals("launcher")) {
            AppManager.appManager.setLauncherReady();
        }
    }

    public void onReceive(String msg, int type, String from) {
        if (mMessageContext == null)
            return;

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

    // @Override
    // public Object onMessage(String event, Object data) {
    // if (event.equals("onPageFinished")) {
    // webView.loadUrl("javascript:(function(){\n" +
    // " var head = document.getElementsByTagName('head')[0];\n" +
    // " var script = document.createElement('script');\n" +
    // " script.type = 'text/javascript';\n" +
    // " script.src = \"file:///android_asset/www/cordova.js\";\n" +
    // " head.appendChild(script);\n" +
    // " })();");
    // }
    // return null;
    // }

    @Override
    public Boolean shouldAllowRequest(String url) {
        if (url.startsWith("assets://www/cordova") || url.startsWith("assets://www/plugins")) {
            return true;
        }
        return null;
    }

    @Override
    public Uri remapUri(Uri uri) {
        String url = uri.toString();
        if ("assets".equals(uri.getScheme())) {
            url = "file:///android_asset/www" + uri.getPath();

        }
        else if (url.startsWith("file:///assets/")) {
            AppInfo info = AppManager.appManager.getAppInfo(id);
            url = AppManager.appManager.getAppUrl(info) + url.substring(15);
        }
//        else if (url.startsWith("file:///data/")) {、
//            url = AppManager.appManager.getDataUrl(id) + url.substring(15);
//        }
        else {
            return null;
        }

        uri = Uri.parse(url);
        return uri;
    }

}
