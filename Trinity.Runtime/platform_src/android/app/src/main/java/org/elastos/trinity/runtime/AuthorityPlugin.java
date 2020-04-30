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

import android.content.Intent;
import android.content.res.Configuration;
import android.net.Uri;
import android.os.Bundle;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaArgs;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaPreferences;
import org.apache.cordova.CordovaResourceApi;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.ICordovaClientCertRequest;
import org.apache.cordova.ICordovaHttpAuthHandler;
import org.json.JSONArray;
import org.json.JSONException;

import java.io.FileNotFoundException;
import java.io.IOException;

public class AuthorityPlugin extends CordovaPlugin {

    private CordovaPlugin originalPlugin = null;
    private AppInfo appInfo = null;
    private String pluginName = null;
    private PermissionGroup permissionGroup = null;

    AuthorityPlugin(String className, AppInfo info, String name,
                    AppWhitelistPlugin whitelistPlugin, PermissionGroup permissionGroup) {
        appInfo = info;
        pluginName = name;
        originalPlugin = instantiatePlugin(className, whitelistPlugin);
        this.permissionGroup = permissionGroup;
    }

    public CordovaPlugin getOriginalPlugin() {
        return originalPlugin;
    }

    private CordovaPlugin instantiatePlugin(String className, AppWhitelistPlugin whitelistPlugin) {
        CordovaPlugin plugin = null;
        try {
            Class<?> c = null;
            if ((className != null) && !("".equals(className))) {
                c = Class.forName(className);
            }
            if (c != null & CordovaPlugin.class.isAssignableFrom(c)) {
                plugin = (CordovaPlugin) c.newInstance();
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error adding plugin " + className + ".");
        }
        if (plugin != null) {
            if (plugin instanceof TrinityPlugin) {
                TrinityPlugin trinity = (TrinityPlugin)plugin;
                trinity.setWhitelistPlugin(whitelistPlugin);
                trinity.setInfo(appInfo);
            }
        }
        return plugin;
    }

    @Override
    public final void privateInitialize(String serviceName, CordovaInterface cordova,
                                        CordovaWebView webView, CordovaPreferences preferences) {
        originalPlugin.privateInitialize(serviceName, cordova, webView, preferences);
    }

    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        originalPlugin.initialize(cordova, webView);
    }

    @Override
    public String getServiceName() {
        return originalPlugin.getServiceName();
    }

    private boolean checkApiPermission(String action, CallbackContext callbackContext) {
        boolean ret = permissionGroup.getApiPermission(pluginName, action);
        if (!ret) {
            String errorMessage = "## '" + pluginName + "." + action + "()' is not allowed in permissions!";

            System.err.println(errorMessage);
            callbackContext.error(errorMessage);
        }
        return ret;
    }

    private boolean checkAuthority(String action, CallbackContext callbackContext) {
        if (originalPlugin != null) {
            int authority = ApiAuthorityManager.getShareInstance().getApiAuthority(appInfo, pluginName, action);
            if (authority == AppInfo.AUTHORITY_ALLOW) {
                return checkApiPermission(action,  callbackContext);
            }
            callbackContext.error("Api:'" + pluginName + "." + action + "' have not run authority.");
        }
        return false;
    }

    @Override
    public boolean execute(String action, String rawArgs, CallbackContext callbackContext) throws JSONException {
        if (checkAuthority(action,  callbackContext)) {
            return originalPlugin.execute(action, rawArgs, callbackContext);
        }
        else {
            return false;
        }
    }

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (checkAuthority(action,  callbackContext)) {
            return originalPlugin.execute(action, args, callbackContext);
        }
        else {
            return false;
        }
    }

    @Override
    public boolean execute(String action, CordovaArgs args, CallbackContext callbackContext) throws JSONException {
        if (checkAuthority(action,  callbackContext)) {
            return originalPlugin.execute(action, args, callbackContext);
        }
        else {
            return false;
        }
    }

    @Override
    public void onPause(boolean multitasking) {
        originalPlugin.onPause(multitasking);
    }

    @Override
    public void onResume(boolean multitasking) {
        originalPlugin.onResume(multitasking);
    }

    @Override
    public void onStart() {
        originalPlugin.onStart();
    }

    @Override
    public void onStop() {
        originalPlugin.onStop();
    }

    @Override
    public void onNewIntent(Intent intent) {
        originalPlugin.onNewIntent(intent);
    }

    @Override
    public void onDestroy() {
        originalPlugin.onDestroy();
    }

    @Override
    public Bundle onSaveInstanceState() {
        return originalPlugin.onSaveInstanceState();
    }

    @Override
    public void onRestoreStateForActivityResult(Bundle state, CallbackContext callbackContext) {
        originalPlugin.onRestoreStateForActivityResult(state, callbackContext);
    }

    @Override
    public Object onMessage(String id, Object data) {
        return originalPlugin.onMessage(id, data);
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent intent) {
        originalPlugin.onActivityResult(requestCode, resultCode, intent);
    }

    @Override
    public Boolean shouldAllowRequest(String url) {
        return originalPlugin.shouldAllowRequest(url);
    }

    @Override
    public Boolean shouldAllowNavigation(String url) {
        return originalPlugin.shouldAllowNavigation(url);
    }

    @Override
    public Boolean shouldAllowBridgeAccess(String url) {
        return originalPlugin.shouldAllowBridgeAccess(url);
    }

    @Override
    public Boolean shouldOpenExternalUrl(String url) {
        return originalPlugin.shouldOpenExternalUrl(url);
    }

    @Override
    public boolean onOverrideUrlLoading(String url) {
        return originalPlugin.onOverrideUrlLoading(url);
    }

    @Override
    public Uri remapUri(Uri uri) {
        return originalPlugin.remapUri(uri);
    }

    @Override
    public CordovaResourceApi.OpenForReadResult handleOpenForRead(Uri uri) throws IOException {
        return originalPlugin.handleOpenForRead(uri);
    }

    @Override
    public void onReset() {
        originalPlugin.onReset();
    }

    @Override
    public boolean onReceivedHttpAuthRequest(CordovaWebView view, ICordovaHttpAuthHandler handler, String host, String realm) {
        return originalPlugin.onReceivedHttpAuthRequest(view, handler, host, realm);
    }

    @Override
    public boolean onReceivedClientCertRequest(CordovaWebView view, ICordovaClientCertRequest request) {
        return originalPlugin.onReceivedClientCertRequest(view, request);
    }

    @Override
    public void onConfigurationChanged(Configuration newConfig) {
        originalPlugin.onConfigurationChanged(newConfig);
    }

    @Override
    public void requestPermissions(int requestCode) {
        originalPlugin.requestPermissions(requestCode);
    }

    @Override
    public boolean hasPermisssion() {
        return originalPlugin.hasPermisssion();
    }

    @Override
    public void onRequestPermissionResult(int requestCode, String[] permissions,
                                       int[] grantResults) throws JSONException {
        originalPlugin.onRequestPermissionResult(requestCode, permissions, grantResults);

    }
}
