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

import android.app.AlertDialog;
import android.content.ActivityNotFoundException;
import android.content.DialogInterface;
import android.net.Uri;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

public class AppBasePlugin extends TrinityPlugin {
    protected CallbackContext mMessageContext = null;
    protected CallbackContext mIntentContext = null;

    private boolean isChangeIconPath = false;


    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        try {
            switch (action) {
                case "getVersion":
                    this.getVersion(callbackContext);
                    break;
                case "start":
                    this.start(args, callbackContext);
                    break;
                case "closeApp":
                    this.closeApp(args, callbackContext);
                    break;
                case "getAppInfos":
                    this.getAppInfos(args, callbackContext);
                    break;
                case "setCurrentLocale":
                    this.setCurrentLocale(args, callbackContext);
                    break;
                case "install":
                    this.install(args, callbackContext);
                    break;
                case "unInstall":
                    this.unInstall(args, callbackContext);
                    break;
                case "setPluginAuthority":
                    this.setPluginAuthority(args, callbackContext);
                    break;
                case "setUrlAuthority":
                    this.setUrlAuthority(args, callbackContext);
                    break;
                case "getRunningList":
                    this.getRunningList(callbackContext);
                    break;
                case "getAppList":
                    this.getAppList(callbackContext);
                    break;
                case "alertPrompt":
                    this.alertPrompt(args, callbackContext);
                    break;
                case "infoPrompt":
                    this.infoPrompt(args, callbackContext);
                    break;
                case "askPrompt":
                    this.askPrompt(args, callbackContext);
                    break;
                case "getAppInfo":
                    this.getAppInfo(args, callbackContext);
                    break;

                case "getLocale":
                    this.getLocale(args, callbackContext);
                    break;
                case "getInfo":
                    this.getInfo(args, callbackContext);
                    break;
                case "launcher":
                    this.launcher(callbackContext);
                    break;
                case "close":
                    this.close(args, callbackContext);
                    break;
                case "sendMessage":
                    this.sendMessage(args, callbackContext);
                    break;
                case "setListener":
                    this.setListener(callbackContext);
                    break;
                case "sendIntent":
                    this.sendIntent(args, callbackContext);
                    break;
                case "sendUrlIntent":
                    this.sendUrlIntent(args, callbackContext);
                    break;
                case "setIntentListener":
                    this.setIntentListener(callbackContext);
                    break;
                case "sendIntentResponse":
                    this.sendIntentResponse(args, callbackContext);
                    break;
                case "hasPendingIntent":
                    this.hasPendingIntent(callbackContext);
                    break;
                case "setVisible":
                    this.setVisible(args, callbackContext);
                    break;

                case "titleBar_showActivityIndicator":
                    this.titleBar_showActivityIndicator(args, callbackContext);
                    break;
                case "titleBar_hideActivityIndicator":
                    this.titleBar_hideActivityIndicator(args, callbackContext);
                    break;
                case "titleBar_setTitle":
                    this.titleBar_setTitle(args, callbackContext);
                    break;
                case "titleBar_setBackgroundColor":
                    this.titleBar_setBackgroundColor(args, callbackContext);
                    break;
                case "titleBar_setForegroundMode":
                    this.titleBar_setForegroundMode(args, callbackContext);
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

    protected void getVersion(CallbackContext callbackContext) throws Exception {
        String version = ConfigManager.getShareInstance().getStringValue("version", "undefined");
        callbackContext.success(version);
    }

    protected void launcher(CallbackContext callbackContext) throws Exception {
        appManager.loadLauncher();
        callbackContext.success("ok");
    }

    protected void start(JSONArray args, CallbackContext callbackContext) throws Exception {
        String id = args.getString(0);

        if (id == null || id.equals("")) {
            callbackContext.error("Invalid id.");
        }
        else if (appManager.isLauncher(id)) {
            callbackContext.error("Can't start launcher! Please use launcher().");
        }
        else {
            appManager.start(id);
            callbackContext.success("ok");
        }
    }

    protected void close(JSONArray args, CallbackContext callbackContext) throws Exception {
        appManager.close(this.appId);
        callbackContext.success("ok");
    }

    protected void setVisible(JSONArray args, CallbackContext callbackContext) throws Exception {
        String visible = args.getString(0);

        if (visible == null || !visible.equals("hide")) {
            visible = "show";
        }

        appManager.setAppVisible(appId, visible);
        if (visible.equals("show")) {
            appManager.start(this.appId);
        }
        else {
            appManager.loadLauncher();
        }
        appManager.sendLauncherMessage(AppManager.MSG_TYPE_INTERNAL,
                "{\"visible\": \"" + visible + "\"}", this.appId);
        callbackContext.success("ok");
    }

    protected void closeApp(JSONArray args, CallbackContext callbackContext) throws Exception {
        String appId = args.getString(0);

        if (appId == null || appId.equals("")) {
            callbackContext.error("Invalid id.");
        }
        appManager.close(appId);
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

    private JSONArray jsonAppIcons(AppInfo info) throws JSONException {
        JSONArray jsons = new JSONArray();
        String appUrl = appManager.getIconUrl(info);

        AppInfo.Icon[] icons = new AppInfo.Icon[info.icons.size()];
        info.icons.toArray(icons);

        for (int i = 0; i < icons.length; i++) {
            AppInfo.Icon icon = icons[i];
            String src = icon.src;
            if (isChangeIconPath) {
                src = "icon://" + info.app_id + "/" + String.valueOf(i);
            }

            JSONObject ret = new JSONObject();
            ret.put("src", src);
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

    protected JSONArray jsonAppFrameworks(AppInfo info) throws JSONException {
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
        String appUrl = appManager.getAppUrl(info);
        String dataUrl = appManager.getDataUrl(info.app_id);
        JSONObject ret = new JSONObject();
        ret.put("id", info.app_id);
        ret.put("version", info.version);
        ret.put("versionCode", info.version_code);
        ret.put("name", info.name);
        ret.put("shortName", info.short_name);
        ret.put("description", info.description);
        ret.put("startUrl", appManager.getStartPath(info));
        ret.put("startVisible", info.start_visible);
        ret.put("icons", jsonAppIcons(info));
        ret.put("authorName", info.author_name);
        ret.put("authorEmail", info.author_email);
        ret.put("defaultLocale", info.default_locale);
        ret.put("category", info.category);
        ret.put("keyWords", info.key_words);
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
        ret.put("frameworks", jsonAppFrameworks(info));
        ret.put("platforms", jsonAppPlatforms(info));
        return ret;
    }

    protected void getAppInfo(JSONArray args, CallbackContext callbackContext) throws JSONException {
        String appId = args.getString(0);

        if (appId == null || appId.equals("")) {
            callbackContext.error("Invalid id.");
        }

        AppInfo info = appManager.getAppInfo(appId);
        if (info != null) {
            isChangeIconPath = true;
            callbackContext.success(jsonAppInfo(info));
        } else {
            callbackContext.error("No such app!");
        }
    }

    protected void getInfo(JSONArray args, CallbackContext callbackContext) throws JSONException {
        AppInfo info = appManager.getAppInfo(this.appId);
        if (info != null) {
            callbackContext.success(jsonAppInfo(info));
        } else {
            callbackContext.error("No such app!");
        }
    }

    protected void getLocale(JSONArray args, CallbackContext callbackContext) throws JSONException {
        JSONObject ret = new JSONObject();
        AppInfo info = appManager.getAppInfo(this.appId);
        ret.put("defaultLang", info.default_locale);
        ret.put("currentLang", appManager.getCurrentLocale());
        ret.put("systemLang", Locale.getDefault().getLanguage());

        callbackContext.success(ret);
    }

    protected void sendMessage(JSONArray args, CallbackContext callbackContext) throws Exception {
        String toId = args.getString(0);
        Integer type = args.getInt(1);
        String msg = args.getString(2);
        appManager.sendMessage(toId, type, msg, this.appId);
        callbackContext.success("ok");
    }

    protected void setListener(CallbackContext callbackContext) {
        mMessageContext = callbackContext;

        PluginResult pluginResult = new PluginResult(PluginResult.Status.NO_RESULT);
        pluginResult.setKeepCallback(true);
        callbackContext.sendPluginResult(pluginResult);

        if (appManager.isLauncher(this.appId)) {
            appManager.setLauncherReady();
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

    protected void sendIntent(JSONArray args, CallbackContext callbackContext) throws Exception {
        String action = args.getString(0);
        String params = args.getString(1);
        long currentTime = System.currentTimeMillis();
        String toId = null;

        if (!args.isNull(2)) {
            JSONObject options = args.getJSONObject(2);
            if (options.has("appId")) {
                toId = options.getString("appId");
            }
        }

        IntentInfo info = new IntentInfo(action, params, this.appId, toId, currentTime, callbackContext);

        IntentManager.getShareInstance().doIntent(info);
        PluginResult pluginResult = new PluginResult(PluginResult.Status.NO_RESULT);
        pluginResult.setKeepCallback(true);
        callbackContext.sendPluginResult(pluginResult);
    }

    protected void sendUrlIntent(JSONArray args, CallbackContext callbackContext) throws Exception {
        String url = args.getString(0);

        try {
            if (checkIntentScheme(url)) {
                IntentManager.getShareInstance().sendIntentByUri(Uri.parse(url), this.appId);
            }
            else if (shouldOpenExternalIntentUrl(url)) {
                webView.showWebPage(url, true, false, null);
                callbackContext.success("ok");
            }
            else {
                callbackContext.error("Can't access this url: " + url);
            }
        }
        catch(ActivityNotFoundException e) {
            callbackContext.error("Error loading url " + url + " no activity found");
        }
    }

    protected void sendIntentResponse(JSONArray args, CallbackContext callbackContext) throws Exception {
        String action = args.getString(0);
        String result = args.getString(1);
        long intentId = args.getLong(2);
        IntentManager.getShareInstance().sendIntentResponse(this, result, intentId, this.appId);
        callbackContext.success("ok");
    }

    protected void setIntentListener(CallbackContext callbackContext) throws Exception {
        mIntentContext = callbackContext;
        PluginResult pluginResult = new PluginResult(PluginResult.Status.NO_RESULT);
        pluginResult.setKeepCallback(true);
        callbackContext.sendPluginResult(pluginResult);
        IntentManager.getShareInstance().setIntentReady(this.appId);
    }

    protected void hasPendingIntent(CallbackContext callbackContext) throws Exception {
        Boolean ret = IntentManager.getShareInstance().getIntentCount(this.appId) != 0;
        callbackContext.success(ret.toString());
    }

    public Boolean isIntentReady() {
        return (mIntentContext != null);
    }

    public void onReceiveIntent(IntentInfo info) {
        if (mIntentContext == null)
            return;

        JSONObject ret = new JSONObject();
        try {
            ret.put("action", info.action);
            ret.put("params", info.params);
            ret.put("from", info.fromId);
            ret.put("intentId", info.intentId);
            PluginResult result = new PluginResult(PluginResult.Status.OK, ret);
            result.setKeepCallback(true);
            mIntentContext.sendPluginResult(result);
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }

    public void onReceiveIntentResponse(IntentInfo info) {
        JSONObject obj = new JSONObject();
        try {
            obj.put("action", info.action);
            obj.put("result", info.params);
            obj.put("from", info.fromId);
            PluginResult result = new PluginResult(PluginResult.Status.OK, obj);
            result.setKeepCallback(false);
            info.callbackContext.sendPluginResult(result);
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }

    private boolean checkIntentScheme(String url) {
        return IntentManager.checkTrinityScheme(url);// && (!isUrlApp() || url.contains("callbackurl="));
    }

    @Override
    public Boolean shouldAllowNavigation(String url) {
        if (appManager.isLauncher(this.appId)) {
            return true;
        }
        else if (checkIntentScheme(url)) {
            try {
                IntentManager.getShareInstance().sendIntentByUri(Uri.parse(url), this.appId);
            } catch (Exception e) {
                e.printStackTrace();
            }
            return false;
        }

        return null;
    }

    @Override
    public Boolean shouldAllowRequest(String url) {
        if (appManager.isLauncher(this.appId)) {
            return true;
        }
        else if (checkIntentScheme(url)) {
            try {
                IntentManager.getShareInstance().sendIntentByUri(Uri.parse(url), this.appId);
            } catch (Exception e) {
                e.printStackTrace();
            }
            return false;
        }

        if (url.startsWith("asset://www/cordova") || url.startsWith("asset://www/plugins")
                || url.startsWith("trinity:///asset/") || url.startsWith("trinity:///data/")
                || url.startsWith("trinity:///temp/")) {
            return true;
        }

        if (isChangeIconPath && url.startsWith("icon://")) {
            return true;
        }

        return null;
    }

    @Override
    public Uri remapUri(Uri uri) {
        String url = uri.toString();
        if (isChangeIconPath && url.startsWith("icon://")) {
            String str = url.substring(7);
            int index = str.indexOf("/");
            if (index > 0) {
                String app_id = str.substring(0, index);
                AppInfo info = appManager.getAppInfo(app_id);
                if (info != null) {
                    index = Integer.valueOf(str.substring(index + 1));
                    AppInfo.Icon icon = info.icons.get(index);
                    String appUrl = appManager.getIconUrl(info);
                    url = appManager.resetPath(appUrl, icon.src);
                }
            }
        }
        else if ("asset".equals(uri.getScheme())) {;
            url = "file:///android_asset/www" + uri.getPath();
        }
        else if (url.startsWith("trinity:///asset/")) {
            AppInfo info = appManager.getAppInfo(this.appId);
            url = appManager.getAppUrl(info) + url.substring(17);
        }
        else if (url.startsWith("trinity:///data/")) {
            url = appManager.getDataUrl(this.appId) + url.substring(16);
        }
        else if (url.startsWith("trinity:///temp/")) {
            url = appManager.getTempUrl(this.appId) + url.substring(16);
        }
//        else if (checkIntentScheme(url)) {
//            try {
//                IntentManager.getShareInstance().sendIntentByUri(uri, this.appId);
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
//        }
        else {
            return null;
        }

        uri = Uri.parse(url);
        return uri;
    }

    //---------------- for AppManager --------------------------------------------------------------
    private void setCurrentLocale(JSONArray args, CallbackContext callbackContext) throws JSONException {
        String code = args.getString(0);
        appManager.setCurrentLocale(code);
        callbackContext.success("ok");
    }

    protected void install(JSONArray args, CallbackContext callbackContext) throws Exception {
        String url = args.getString(0);
        boolean update = args.getBoolean(1);

        if (url.startsWith("trinity://")) {
            url = getCanonicalPath(url);
        }

        AppInfo info = appManager.install(url, update);
        if (info != null) {
            callbackContext.success(jsonAppInfo(info));
        }
        else {
            callbackContext.error("error");
        }
    }

    protected void unInstall(JSONArray args, CallbackContext callbackContext) throws Exception {
        String id = args.getString(0);
        appManager.unInstall(id, false);
        callbackContext.success(id);
    }

    protected void getAppInfos(JSONArray args, CallbackContext callbackContext) throws JSONException {
        HashMap<String, AppInfo> appInfos = appManager.getAppInfos();
        JSONObject infos = new JSONObject();
        isChangeIconPath = true;

        if (appInfos != null) {
            for (Map.Entry<String, AppInfo> entry : appInfos.entrySet()) {
                infos.put(entry.getKey(), jsonAppInfo(entry.getValue()));
            }
        }
        String[]  ids = appManager.getAppIdList();
        JSONArray list = jsonIdList(ids);

        JSONObject ret = new JSONObject();
        ret.put("infos", infos);
        ret.put("list", list);
        callbackContext.success(ret);
    }

    protected void setPluginAuthority(JSONArray args, CallbackContext callbackContext) throws Exception {
        String id = args.getString(0);
        String plugin = args.getString(1);
        int authority = args.getInt(2);

        if (id == null || id.equals("")) {
            callbackContext.error("Invalid id.");
            return;
        }
        appManager.setPluginAuthority(id, plugin, authority);
        callbackContext.success("ok");
    }

    protected void setUrlAuthority(JSONArray args, CallbackContext callbackContext) throws Exception {
        String id = args.getString(0);
        String url = args.getString(1);
        int authority = args.getInt(2);

        if (id == null || id.equals("")) {
            callbackContext.error("Invalid id.");
            return;
        }
        appManager.setUrlAuthority(id, url, authority);
        callbackContext.success("ok");
    }

    protected JSONArray jsonIdList(String[] ids) {
        JSONArray json = new JSONArray();
        for (String id: ids) {
            if (!appManager.isLauncher(id)) {
                json.put(id);
            }
        }
        return json;
    }

    protected void getRunningList(CallbackContext callbackContext) {
        String[] ids = appManager.getRunningList();
        JSONArray ret = jsonIdList(ids);
        callbackContext.success(ret);
    }

    protected void getAppList(CallbackContext callbackContext) {
        String[]  ids = appManager.getAppIdList();
        JSONArray ret = jsonIdList(ids);
        callbackContext.success(ret);
    }

    protected void getLastList(CallbackContext callbackContext) {
        String[]  ids = appManager.getLastList();
        JSONArray ret = jsonIdList(ids);
        callbackContext.success(ret);
    }


    private void alertDialog(JSONArray args, int icon, CallbackContext callbackContext) throws Exception {
        String title = args.getString(0);
        String msg = args.getString(1);
        AlertDialog.Builder ab = new AlertDialog.Builder(this.cordova.getActivity());
        ab.setTitle(title);
        ab.setMessage(msg);
        ab.setIcon(icon);

        ab.setPositiveButton("OK", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                if (callbackContext != null) {
                    callbackContext.success("ok");
                }
            }
        });
        if (callbackContext != null) {
            ab.setNegativeButton("Cancel", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {

                }
            });
        }
        ab.show();
    }

    protected void alertPrompt(JSONArray args, CallbackContext callbackContext) throws Exception {
        alertDialog(args, android.R.drawable.ic_dialog_alert, null);
    }

    protected void infoPrompt(JSONArray args, CallbackContext callbackContext) throws Exception {
        alertDialog(args, android.R.drawable.ic_dialog_info, null);
    }

    protected void askPrompt(JSONArray args, CallbackContext callbackContext) throws Exception {
        alertDialog(args, android.R.drawable.ic_dialog_info, callbackContext);
    }

    private TitleBar getTitleBar() {
        return ((WebViewFragment)((TrinityCordovaInterfaceImpl)cordova).fragment).getTitlebar();
    }

    private void titleBar_showActivityIndicator(JSONArray args, CallbackContext callbackContext) throws Exception {
        int activityIndicatoryType = args.getInt(0);

        getTitleBar().showActivityIndicator(TitleBar.TitleBarActivityType.fromId(activityIndicatoryType));

        callbackContext.success();
    }

    private void titleBar_hideActivityIndicator(JSONArray args, CallbackContext callbackContext) throws Exception {
        int activityIndicatoryType = args.getInt(0);

        getTitleBar().hideActivityIndicator(TitleBar.TitleBarActivityType.fromId(activityIndicatoryType));

        callbackContext.success();
    }

    private void titleBar_setTitle(JSONArray args, CallbackContext callbackContext) throws Exception {
        String title = args.getString(0);

        getTitleBar().setTitle(title);

        callbackContext.success();
    }

    private void titleBar_setBackgroundColor(JSONArray args, CallbackContext callbackContext) throws Exception {
        String hexColor = args.getString(0);

        if (getTitleBar().setBackgroundColor(hexColor))
            callbackContext.success();
        else
            callbackContext.error("Invalid color "+hexColor);
    }

    private void titleBar_setForegroundMode(JSONArray args, CallbackContext callbackContext) throws Exception {
        int modeAsInt = args.getInt(0);

        getTitleBar().setForegroundMode(TitleBar.TitleBarForegroundMode.fromId(modeAsInt));

        callbackContext.success();
    }
}
