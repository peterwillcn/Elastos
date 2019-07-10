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
import android.support.v4.app.FragmentActivity;
import android.view.GestureDetector;
import android.view.MotionEvent;

import org.apache.cordova.LOG;
import org.elastos.trinity.runtime.R;
import org.json.JSONException;

//import android.support.v4.view.ViewPager;
//import android.support.v4.app.FragmentPagerAdapter;

public class WebViewActivity extends FragmentActivity {
    public static String TAG = "WebViewActivity";

    protected AppManager appManager;
    private GestureDetector gestureDetector;

    private void getInstallUri() {
        Intent intent = getIntent();
        String action=intent.getAction();
        if ((action != null) && action.equals("android.intent.action.VIEW")) {
            Uri uri = intent.getData();
            if (uri != null) {
                appManager.setInstallUri(uri.toString());
            }
        }
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        //Aqui debo crear el loading

        setContentView(R.layout.fragments_view);
        appManager = new AppManager(this);

        getInstallUri();

        gestureDetector = new GestureDetector(this, onGestureListener);

        // Set by <content src="index.html" /> in config.xml
        try {
            appManager.loadLauncher();
        }
        catch (Exception e){
            e.printStackTrace();
        }


//        Bundle b = getIntent().getExtras();
//        String url = b.getString("url");
//        Boolean shouldShowLoading = false;
//        try{
//            shouldShowLoading = b.getBoolean("shouldShowLoading");
//        }
//        catch(Exception e){
//
//        }
//        if(shouldShowLoading){
//            showLoading();
//        }

        // If keepRunning
//        this.keepRunning = preferences.getBoolean("KeepRunning", true);

//        loadUrl((url.matches("^(.*://|javascript:)[\\s\\S]*$") ? "" : "file:///android_asset/www/" + (isPluginCryptFileActive() ? "+++/" : "")) + url);
    }

    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        setIntent(intent);
        getInstallUri();
    }

    @Override
    public void onBackPressed() {
        if (appManager.doBackPressed()) {
            super.onBackPressed();
        }
    }

    /**
     * Called by the system when the device configuration changes while your activity is running.
     *
     * @param newConfig The new device configuration
     */
    @Override
    public void onConfigurationChanged(Configuration newConfig) {
        super.onConfigurationChanged(newConfig);
        appManager.onConfigurationChanged(newConfig);
    }

    /**
     * Called by the system when the user grants permissions
     *
     * @param requestCode
     * @param permissions
     * @param grantResults
     */
    @Override
    public void onRequestPermissionsResult(int requestCode, String permissions[],
                                           int[] grantResults) {
        try
        {
            appManager.onRequestPermissionResult(requestCode, permissions, grantResults);
        }
        catch (JSONException e)
        {
            LOG.d(TAG, "JSONException: Parameters fed into the method are not valid");
            e.printStackTrace();
        }

    }

//    public static boolean showLoading() {
//        // Loading spinner
//        activity.runOnUiThread(new Runnable() {
//            @Override
//            public void run() {
//                dialog = new Dialog(activity,android.R.style.Theme_Translucent_NoTitleBar);
//                ProgressBar progressBar = new ProgressBar(activity,null,android.R.attr.progressBarStyle);
//
//                LinearLayout linearLayout = new LinearLayout(activity);
//                linearLayout.setOrientation(LinearLayout.VERTICAL);
//                RelativeLayout layoutPrincipal = new RelativeLayout(activity);
//                layoutPrincipal.setBackgroundColor(Color.parseColor("#d9000000"));
//
//                RelativeLayout.LayoutParams params = new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
//                params.addRule(RelativeLayout.CENTER_IN_PARENT);
//
//                linearLayout.addView(progressBar);
//
//                linearLayout.setLayoutParams(params);
//
//                layoutPrincipal.addView(linearLayout);
//
//                dialog.setContentView(layoutPrincipal);
//                dialog.setOnCancelListener(new DialogInterface.OnCancelListener() {
//                    @Override
//                    public void onCancel(DialogInterface dialogInterface) {
//
//                    }
//                });
//                dialog.setOnKeyListener(new DialogInterface.OnKeyListener() {
//                    @Override
//                    public boolean onKey(DialogInterface dialogInterface, int i, KeyEvent keyEvent) {
//                        if(keyEvent.getKeyCode() == KeyEvent.KEYCODE_BACK)
//                            return true;
//                        return false;
//                    }
//                });
//
//                dialog.show();
//            }
//        });
//
//        return true;
//    }

//    public static boolean hideLoading() {
//        // Loading spinner
//        activity.runOnUiThread(new Runnable() {
//            @Override
//            public void run() {
//                dialog.hide();
//            }
//        });
//        return true;
//    }

    /**
     * Revisa si existe el plugin cordova-plugin-crypt-file
     * @return boolean
     */
    private boolean isPluginCryptFileActive() {
        try {
            Class.forName("com.tkyaji.cordova.DecryptResource");
            return true;
        } catch(Exception e) {
            return false;
        }
    }

    @Override
    public boolean dispatchTouchEvent (MotionEvent ev) {
        if (!appManager.curFragment.id.equals("launcher")) {
            gestureDetector.onTouchEvent(ev);
        }
        return super.dispatchTouchEvent(ev);
    }

    private GestureDetector.OnGestureListener onGestureListener =
            new GestureDetector.SimpleOnGestureListener() {
                @Override
                public boolean onFling(MotionEvent e1, MotionEvent e2, float velocityX,
                                       float velocityY) {
                    float y1 = e1.getY();
                    float distance = e2.getY() - e1.getY();

                    if (distance > 200 && y1 < 200) {
                        appManager.flingTheme();
                    }
                    return true;
                }
            };
}
