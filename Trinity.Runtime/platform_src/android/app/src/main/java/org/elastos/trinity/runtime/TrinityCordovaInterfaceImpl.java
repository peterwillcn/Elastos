package org.elastos.trinity.runtime;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;

import org.apache.cordova.CordovaInterfaceImpl;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaPreferences;
import org.apache.cordova.CordovaWebViewEngine;
import org.apache.cordova.engine.SystemWebView;
import org.apache.cordova.engine.SystemWebViewEngine;

import java.lang.reflect.Constructor;
import java.util.concurrent.Executors;

public class TrinityCordovaInterfaceImpl extends CordovaInterfaceImpl {

    public WebViewFragment fragment;

    public static CordovaWebViewEngine createEngine(SystemWebView webView, CordovaPreferences preferences) {
        String className = preferences.getString("webview", SystemWebViewEngine.class.getCanonicalName());
        try {
            Class<?> webViewClass = Class.forName(className);
            Constructor<?> constructor = webViewClass.getConstructor(SystemWebView.class, CordovaPreferences.class);
            return (CordovaWebViewEngine) constructor.newInstance(webView, preferences);
        } catch (Exception e) {
            throw new RuntimeException("Failed to create webview. ", e);
        }
    }

    public TrinityCordovaInterfaceImpl(Activity activity, WebViewFragment fragment) {
        super(activity);
        this.fragment = fragment;
    }

    @Override
    public void startActivityForResult(CordovaPlugin command, Intent intent, int requestCode) {
        setActivityResultCallback(command);
        try {
            fragment.startActivityForResult(intent, requestCode);
        } catch (RuntimeException e) { // E.g.: ActivityNotFoundException
            activityResultCallback = null;
            throw e;
        }
    }

    public CordovaPlugin getActivityResultCallback() {
        return activityResultCallback;
    }
}
