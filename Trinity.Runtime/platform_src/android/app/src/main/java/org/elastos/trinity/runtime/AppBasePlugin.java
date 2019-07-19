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
import org.elastos.trinity.plugins.appmanager.AppManagerPlugin;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

public class AppBasePlugin extends CordovaPlugin {
    protected CallbackContext mMessageContext = null;
    protected String id;

    protected void launcher(JSONArray args, CallbackContext callbackContext) throws Exception {
        AppManager.getShareInstance().loadLauncher();
        callbackContext.success("ok");
    }

    protected void start(JSONArray args, CallbackContext callbackContext) throws Exception {
        String id = args.getString(0);

        if (id == null || id.equals("")) {
            callbackContext.error("Invalid id.");
        } else if (id.equals("launcher")) {
            callbackContext.error("Can't start launcher! Please use launcher().");
        } else {
            AppManager.getShareInstance().start(id);
            callbackContext.success("ok");
        }
    }

    protected void close(JSONArray args, CallbackContext callbackContext) throws Exception {
        String appId = this.id;

        if (this instanceof AppManagerPlugin) {
            appId = args.getString(0);
        }

        if (appId == null || appId.equals("")) {
            callbackContext.error("Invalid id.");
        }
        AppManager.getShareInstance().close(appId);
        callbackContext.success("ok");
    }

    private JSONArray jsonAppPlugins(ArrayList<AppInfo.PluginAuth> plugins) throws JSONException {
        JSONArray jsons = new JSONArray();
        for (AppInfo.PluginAuth pluginAuth : plugins) {
            JSONObject ret = new JSONObject();
            ret.put("plugin", pluginAuth.plugin);
            ret.put("authority", pluginAuth.authority);
            jsons.put(ret);
        }
        return jsons;
    }

    private JSONArray jsonAppUrls(ArrayList<AppInfo.UrlAuth> plugins) throws JSONException {
        JSONArray jsons = new JSONArray();
        for (AppInfo.UrlAuth urlAuth : plugins) {
            JSONObject ret = new JSONObject();
            ret.put("url", urlAuth.url);
            ret.put("authority", urlAuth.authority);
            jsons.put(ret);
        }
        return jsons;
    }

    protected JSONArray jsonAppIcons(AppInfo info) throws JSONException {
        JSONArray jsons = new JSONArray();

        for (AppInfo.Icon icon : info.icons) {
            JSONObject ret = new JSONObject();
            ret.put("src", icon.src);
            ret.put("sizes", icon.sizes);
            ret.put("type", icon.type);
            jsons.put(ret);
        }
        return jsons;
    }

    private JSONObject jsonAppLocales(AppInfo info) throws JSONException {
        JSONObject ret = new JSONObject();
        for (AppInfo.Locale locale : info.locales) {
            JSONObject language = new JSONObject();
            language.put("name", locale.name);
            language.put("shortName", locale.short_name);
            language.put("description", locale.description);
            language.put("authorName", locale.author_name);
            ret.put(locale.language, language);
        }
        return ret;
    }

    protected JSONArray jsonAppFramworks(AppInfo info) throws JSONException {
        JSONArray jsons = new JSONArray();

        for (AppInfo.Framework framework : info.frameworks) {
            JSONObject ret = new JSONObject();
            ret.put("name", framework.name);
            ret.put("version", framework.version);
            jsons.put(ret);
        }
        return jsons;
    }

    protected JSONArray jsonAppPlatforms(AppInfo info) throws JSONException {
        JSONArray jsons = new JSONArray();

        for (AppInfo.Platform platform : info.platforms) {
            JSONObject ret = new JSONObject();
            ret.put("name", platform.name);
            ret.put("version", platform.version);
            jsons.put(ret);
        }
        return jsons;
    }

    protected JSONObject jsonAppInfo(AppInfo info) throws JSONException {
        String appUrl = AppManager.getShareInstance().getAppUrl(info);
        String dataUrl = AppManager.getShareInstance().getDataUrl(info.app_id);
        JSONObject ret = new JSONObject();
        ret.put("id", info.app_id);
        ret.put("version", info.version);
        ret.put("name", info.name);
        ret.put("shortName", info.short_name);
        ret.put("description", info.description);
        ret.put("startUrl", AppManager.getShareInstance().getStartPath(info));
        ret.put("icons", jsonAppIcons(info));
        ret.put("authorName", info.author_name);
        ret.put("authorEmail", info.author_email);
        ret.put("defaultLocale", info.default_locale);
        ret.put("plugins", jsonAppPlugins(info.plugins));
        ret.put("urls", jsonAppUrls(info.urls));
        ret.put("backgroundColor", info.background_color);
        ret.put("themeDisplay", info.theme_display);
        ret.put("themeColor", info.theme_color);
        ret.put("themeFontName", info.theme_font_name);
        ret.put("themeFontColor", info.theme_font_color);
        ret.put("installTime", info.install_time);
        ret.put("builtIn", info.built_in);
        ret.put("remote", info.remote);
        ret.put("appPath", appUrl);
        ret.put("dataPath", dataUrl);
        ret.put("locales", jsonAppLocales(info));
        ret.put("frameworks", jsonAppFramworks(info));
        ret.put("platforms", jsonAppPlatforms(info));
        return ret;
    }

    protected void getAppInfo(JSONArray args, CallbackContext callbackContext) throws JSONException {
        String appId = this.id;
        if (this instanceof AppManagerPlugin) {
            appId = args.getString(0);
        }

        AppInfo info = AppManager.getShareInstance().getAppInfo(appId);
        if (info != null) {
            callbackContext.success(jsonAppInfo(info));
        } else {
            callbackContext.error("No such app!");
        }
    }

    protected void getLocale(JSONArray args, CallbackContext callbackContext) throws JSONException {
        JSONObject ret = new JSONObject();
        AppInfo info = AppManager.getShareInstance().getAppInfo(this.id);
        ret.put("defaultLang", info.default_locale);
        ret.put("currentLang", AppManager.getShareInstance().getCurrentLocale());
        ret.put("systemLang", Locale.getDefault().getLanguage());

        callbackContext.success(ret);
    }

    protected void sendMessage(JSONArray args, CallbackContext callbackContext) throws Exception {
        String toId = args.getString(0);
        Integer type = args.getInt(1);
        String msg = args.getString(2);
        AppManager.getShareInstance().sendMessage(toId, type, msg, this.id);
        callbackContext.success("ok");
    }

    protected void setListener(CallbackContext callbackContext) {
        mMessageContext = callbackContext;

        PluginResult pluginResult = new PluginResult(PluginResult.Status.NO_RESULT);
        pluginResult.setKeepCallback(true);
        callbackContext.sendPluginResult(pluginResult);

        if (this instanceof AppManagerPlugin) {
            AppManager.getShareInstance().setLauncherReady();
        }
    }

    public void onReceive(String msg, int type, String from) {
        if (mMessageContext == null)
            return;

        JSONObject ret = new JSONObject();
        try {
            ret.put("message", msg);
            ret.put("type", type);
            ret.put("from", from);
            PluginResult result = new PluginResult(PluginResult.Status.OK, ret);
            result.setKeepCallback(true);
            mMessageContext.sendPluginResult(result);
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Boolean shouldAllowRequest(String url) {
        if (url.startsWith("asset://www/cordova") || url.startsWith("asset://www/plugins")
                || url.startsWith("trinity:///asset/") || url.startsWith("trinity:///data/")
                || url.startsWith("trinity:///temp/")) {
            return true;
        }

        return null;
    }

    @Override
    public Uri remapUri(Uri uri) {
        String url = uri.toString();
        if ("asset".equals(uri.getScheme())) {
            url = "file:///android_asset/www" + uri.getPath();
        }
        else if (url.startsWith("trinity:///asset/")) {
            AppInfo info = AppManager.getShareInstance().getAppInfo(id);
            url = AppManager.getShareInstance().getAppUrl(info) + url.substring(17);
        }
        else if (url.startsWith("trinity:///data/")) {
            url = AppManager.getShareInstance().getDataUrl(id) + url.substring(16);
        }
        else if (url.startsWith("trinity:///temp/")) {
            url = AppManager.getShareInstance().getTempUrl(id) + url.substring(16);
        }
        else {
            return null;
        }

        uri = Uri.parse(url);
        return uri;
    }

}
