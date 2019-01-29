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

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.pm.PackageManager;
import android.os.Build;
import android.support.v4.app.Fragment;
import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.util.Pair;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;

import org.apache.cordova.CallbackMap;
import org.apache.cordova.ConfigXmlParser;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaInterfaceImpl;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaPreferences;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.CordovaWebViewEngine;
import org.apache.cordova.CordovaWebViewImpl;
import org.apache.cordova.CoreAndroid;
import org.apache.cordova.LOG;
import org.apache.cordova.PluginEntry;
import org.apache.cordova.PluginManager;
import org.apache.cordova.PluginResult;
import org.apache.cordova.ResumeCallback;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.Locale;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;


/**
 * This is the Home section fragment that implements {@link CordovaInterface} and uses a layout that contains
 * a {@link CordovaWebView}.
 *
 */
public class WebViewFragment extends Fragment implements CordovaInterface {
    private static final String TAG = "WebViewFragment";

    protected static CordovaPreferences cfgPreferences;
    protected static ArrayList<PluginEntry> cfgPluginEntries;

    // Plugin to call when activity result is received
    protected CordovaPlugin activityResultCallback = null;
    protected boolean activityResultKeepRunning;


    protected Activity activity;
    protected PluginManager pluginManager;

    protected ActivityResultHolder savedResult;
    protected CallbackMap permissionResultCallbacks = new CallbackMap();
    protected String initCallbackService;
    protected int activityResultRequestCode;
    protected boolean activityWasDestroyed = false;
    protected Bundle savedPluginState;

    // Keep app running when pause is received. (default = true)
    // If true, then the JavaScript and native code continue to run in the background
    // when another application (activity) is started.
    protected boolean keepRunning = true;

    //Instance of the actual Cordova WebView
    protected CordovaWebView appView;
    protected int viewId = 100;
    protected CordovaPreferences preferences;
    protected ArrayList<PluginEntry> pluginEntries;
//    protected CordovaInterface cordovaInterface;
    protected String launchUrl;
    protected AppBasePlugin basePlugin;
    protected String id;

    private final ExecutorService threadPool = Executors.newCachedThreadPool();
    private String url;

//    Bundle savedState;

    /**
     * Returns a new instance of this fragment for the given section
     * number.
     */

    @Override
    /**
     * Initialize the {@link CordovaWebView} and load its start URL.
     *
     * The fragment inflator needs to be cloned first to use an instance of {@link CordovaContext} instead.  This
     * alternate context object implements the {@link CordovaInterface} as well and acts as a proxy between the activity
     * and fragment for the {@link CordovaWebView}.  The actual {@link CordovaWebView} is defined in the home_view_frag.xml layout
     * and has an id of <b>aemWebView</b>.
     */
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
            Bundle savedInstanceState) {
        activity = getActivity();

        if(savedInstanceState != null) {
            restoreInstanceState(savedInstanceState);
        }

        loadConfig();

        // If keepRunning
        this.keepRunning = preferences.getBoolean("KeepRunning", true);

        init();

        appView.loadUrlIntoView(launchUrl, true);

        return appView.getView();
    }

    protected void loadConfig() {

    }

    protected void init() {
        appView = makeWebView();
        createViews();
        if (!appView.isInitialized()) {
            appView.init(this, pluginEntries, preferences);
        }
//        cordovaInterface.onCordovaInit(appView.getPluginManager());
    }


    protected void createViews() {
        //Why are we setting a constant as the ID? This should be investigated
        appView.getView().setId(viewId++);
        appView.getView().setLayoutParams(new FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.MATCH_PARENT));

//        getActivity().setContentView(appView.getView());

        if (preferences.contains("BackgroundColor")) {
            try {
                int backgroundColor = preferences.getInteger("BackgroundColor", Color.BLACK);
                // Background of activity:
                appView.getView().setBackgroundColor(backgroundColor);
            }
            catch (NumberFormatException e){
                e.printStackTrace();
            }
        }

        appView.getView().requestFocusFromTouch();
    }

    protected CordovaWebView makeWebView() {
        return new CordovaWebViewImpl(makeWebViewEngine());
    }

    protected CordovaWebViewEngine makeWebViewEngine() {
        return CordovaWebViewImpl.createEngine(getActivity(), preferences);
    }

    /**
     * Called when the system is about to start resuming a previous activity.
     */
    @Override
    public void onPause() {
        super.onPause();
        LOG.d(TAG, "Paused the fragment.");

        if (this.appView != null) {
            // CB-9382 If there is an activity that started for result and main activity is waiting for callback
            // result, we shoudn't stop WebView Javascript timers, as activity for result might be using them
            boolean keepRunning = this.keepRunning || this.activityResultCallback != null;
            this.appView.handlePause(keepRunning);
        }
    }

    /**
     * Called when the activity will start interacting with the user.
     */
    @Override
    public void onResume() {
        super.onResume();
        LOG.d(TAG, "Resumed the fragment.");

        if (this.appView == null) {
            return;
        }
//        // Force window to have focus, so application always
//        // receive user input. Workaround for some devices (Samsung Galaxy Note 3 at least)
//        this.getWindow().getDecorView().requestFocus();

        this.appView.handleResume(this.keepRunning);
    }

    /**
     * Called when the activity is no longer visible to the user.
     */
    @Override
    public void onStop() {
        super.onStop();
        LOG.d(TAG, "Stopped the fragment.");

        if (this.appView == null) {
            return;
        }
        this.appView.handleStop();
    }

    /**
     * Called when the activity is becoming visible to the user.
     */
    @Override
    public void onStart() {
        super.onStart();
        LOG.d(TAG, "Started the fragment.");

        if (this.appView == null) {
            return;
        }
        this.appView.handleStart();
    }

    /**
     * The final call you receive before your activity is destroyed.
     */
    @Override
    public void onDestroy() {
        LOG.d(TAG, "WebViewFragment.onDestroy()");
        super.onDestroy();

        if (this.appView != null) {
            appView.handleDestroy();
        }
    }

    /*
     * Hook in Cordova for menu plugins
     */
    @Override
    public void onCreateOptionsMenu (Menu menu,
                              MenuInflater inflater) {
        if (appView != null) {
            appView.getPluginManager().postMessage("onCreateOptionsMenu", menu);
        }
        super.onCreateOptionsMenu(menu, inflater);
    }

    @Override
    public void onPrepareOptionsMenu(Menu menu) {
        if (appView != null) {
            appView.getPluginManager().postMessage("onPrepareOptionsMenu", menu);
        }
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        if (appView != null) {
            appView.getPluginManager().postMessage("onOptionsItemSelected", item);
        }
        return true;
    }


    //
    // Cordova
    //

    /**
     * Called when a message is sent to plugin.
     *
     * @param id   The message id
     * @param data The message data
     * @return Object or null
     */
    public Object onMessage(String id, Object data) {
//        if ("onReceivedError".equals(id)) {
//            JSONObject d = (JSONObject) data;
//            try {
//                this.onReceivedError(d.getInt("errorCode"), d.getString("description"), d.getString("url"));
//            } catch (JSONException e) {
//                e.printStackTrace();
//            }
//        }
        return null;
    }

    // Cordova Interface Events
    @Override
    public ExecutorService getThreadPool() {
        return threadPool;
    }

    /**
     * Dispatches any pending onActivityResult callbacks and sends the resume event if the
     * Activity was destroyed by the OS.
     */
    public void onCordovaInit(PluginManager pluginManager) {
        this.pluginManager = pluginManager;
        if (savedResult != null) {
            onActivityResult(savedResult.requestCode, savedResult.resultCode, savedResult.intent);
        } else if(activityWasDestroyed) {
            // If there was no Activity result, we still need to send out the resume event if the
            // Activity was destroyed by the OS
            activityWasDestroyed = false;
            if(pluginManager != null)
            {
                CoreAndroid appPlugin = (CoreAndroid) pluginManager.getPlugin(CoreAndroid.PLUGIN_NAME);
                if(appPlugin != null) {
                    JSONObject obj = new JSONObject();
                    try {
                        obj.put("action", "resume");
                    } catch (JSONException e) {
                        LOG.e(TAG, "Failed to create event message", e);
                    }
                    appPlugin.sendResumeEvent(new PluginResult(PluginResult.Status.OK, obj));
                }
            }

        }
    }
//    @Override
//    /**
//     * Called when an activity you launched exits, giving you the requestCode you started it with,
//     * the resultCode it returned, and any additional data from it.
//     *
//     * @param requestCode       The request code originally supplied to startActivityForResult(),
//     *                          allowing you to identify who this result came from.
//     * @param resultCode        The integer result code returned by the child activity through its setResult().
//     * @param data              An Intent, which can return result data to the caller (various data can be attached to Intent "extras").
//     */
//    public void onActivityResult(int requestCode, int resultCode, Intent intent) {
//        super.onActivityResult(requestCode, resultCode, intent);
//        CordovaPlugin callback = this.activityResultCallback;
//        if (callback != null) {
//            callback.onActivityResult(requestCode, resultCode, intent);
//        }
//    }

    /**
     * Routes the result to the awaiting plugin. Returns false if no plugin was waiting.
     */
    public void onActivityResult(int requestCode, int resultCode, Intent intent) {
        CordovaPlugin callback = activityResultCallback;
        if(callback == null && initCallbackService != null) {
            // The application was restarted, but had defined an initial callback
            // before being shut down.
            savedResult = new ActivityResultHolder(requestCode, resultCode, intent);
            if (pluginManager != null) {
                callback = pluginManager.getPlugin(initCallbackService);
                if(callback != null) {
                    callback.onRestoreStateForActivityResult(savedPluginState.getBundle(callback.getServiceName()),
                            new ResumeCallback(callback.getServiceName(), pluginManager));
                }
            }
        }
        activityResultCallback = null;

        if (callback != null) {
            LOG.d(TAG, "Sending activity result to plugin");
            initCallbackService = null;
            savedResult = null;
            callback.onActivityResult(requestCode, resultCode, intent);
            return;
        }
        LOG.w(TAG, "Got an activity result, but no plugin was registered to receive it" + (savedResult != null ? " yet!" : "."));
        return;
    }

    /**
     * Call this from your startActivityForResult() overload. This is required to catch the case
     * where plugins use Activity.startActivityForResult() + CordovaInterface.setActivityResultCallback()
     * rather than CordovaInterface.startActivityForResult().
     */
    public void setActivityResultRequestCode(int requestCode) {
        activityResultRequestCode = requestCode;
    }

    /**
     * Saves parameters for startActivityForResult().
     */
    public void onSaveInstanceState(Bundle outState) {
        if (activityResultCallback != null) {
            String serviceName = activityResultCallback.getServiceName();
            outState.putString("callbackService", serviceName);
        }
        if(pluginManager != null){
            outState.putBundle("plugin", pluginManager.onSaveInstanceState());
        }

    }

    /**
     * Call this from onCreate() so that any saved startActivityForResult parameters will be restored.
     */
    public void restoreInstanceState(Bundle savedInstanceState) {
        initCallbackService = savedInstanceState.getString("callbackService");
        savedPluginState = savedInstanceState.getBundle("plugin");
        activityWasDestroyed = true;
    }

    private static class ActivityResultHolder {
        private int requestCode;
        private int resultCode;
        private Intent intent;

        public ActivityResultHolder(int requestCode, int resultCode, Intent intent) {
            this.requestCode = requestCode;
            this.resultCode = resultCode;
            this.intent = intent;
        }
    }

    /**
     * Called by the system when the user grants permissions
     *
     * @param requestCode
     * @param permissions
     * @param grantResults
     */
    public void onRequestPermissionResult(int requestCode, String[] permissions,
                                          int[] grantResults) throws JSONException {
        Pair<CordovaPlugin, Integer> callback = permissionResultCallbacks.getAndRemoveCallback(requestCode);
        if(callback != null) {
            callback.first.onRequestPermissionResult(callback.second, permissions, grantResults);
        }
    }

    public void requestPermission(CordovaPlugin plugin, int requestCode, String permission) {
        String[] permissions = new String [1];
        permissions[0] = permission;
        requestPermissions(plugin, requestCode, permissions);
    }

    @SuppressLint("NewApi")
    public void requestPermissions(CordovaPlugin plugin, int requestCode, String [] permissions) {
        int mappedRequestCode = permissionResultCallbacks.registerCallback(plugin, requestCode);
        getActivity().requestPermissions(permissions, mappedRequestCode);
    }

    public boolean hasPermission(String permission)
    {
        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.M)
        {
            int result = activity.checkSelfPermission(permission);
            return PackageManager.PERMISSION_GRANTED == result;
        }
        else
        {
            return true;
        }
    }

    @Override
    public void setActivityResultCallback(CordovaPlugin plugin) {
        this.activityResultCallback = plugin;
    }

    /**
     * Launch an activity for which you would like a result when it finished. When this activity exits,
     * your onActivityResult() method is called.
     *
     * @param command           The command object
     * @param intent            The intent to start
     * @param requestCode       The request code that is passed to callback to identify the activity
     */
    public void startActivityForResult(CordovaPlugin command, Intent intent, int requestCode) {
        this.activityResultCallback = command;
        this.activityResultKeepRunning = this.keepRunning;

        // If multitasking turned on, then disable it for activities that return results
        if (command != null) {
            this.keepRunning = false;
        }

        // Start activity
        super.startActivityForResult(intent, requestCode);

    }



    /**
     * A {@link ContextWrapper} that also implements {@link CordovaInterface} and acts as a proxy between the base
     * activity context and the fragment that contains a {@link CordovaWebView}.
     *
     */
    class CordovaContext extends ContextWrapper implements CordovaInterface
    {
        CordovaInterface cordova;
        Context context;

        public CordovaContext(Context base, CordovaInterface cordova) {
            super(base);
            this.context = base;
            this.cordova = cordova;
        }
        public void startActivityForResult(CordovaPlugin command,
                                           Intent intent, int requestCode) {
            cordova.startActivityForResult(command, intent, requestCode);
        }
        public void setActivityResultCallback(CordovaPlugin plugin) {
            cordova.setActivityResultCallback(plugin);
        }
        public Activity getActivity() {
            return cordova.getActivity();
        }

        @Override
        public Context getContext() {
            return this.context;
        }

        public Object onMessage(String id, Object data) {
            return cordova.onMessage(id, data);
        }
        public ExecutorService getThreadPool() {
            return cordova.getThreadPool();
        }

        @Override
        public void requestPermission(CordovaPlugin plugin, int requestCode, String permission) {

        }

        @Override
        public void requestPermissions(CordovaPlugin plugin, int requestCode, String[] permissions) {

        }

        @Override
        public boolean hasPermission(String permission) {
            return false;
        }

    }
}
