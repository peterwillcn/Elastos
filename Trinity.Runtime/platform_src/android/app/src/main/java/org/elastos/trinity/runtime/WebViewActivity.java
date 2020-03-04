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


import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.res.Configuration;
import android.net.Uri;
import android.os.Bundle;
import androidx.core.app.ActivityCompat;
import androidx.fragment.app.FragmentActivity;
import androidx.core.content.ContextCompat;
import android.view.GestureDetector;
import android.view.MotionEvent;

import org.apache.cordova.LOG;
import org.json.JSONException;

//import android.support.v4.view.ViewPager;
//import android.support.v4.app.FragmentPagerAdapter;

public class WebViewActivity extends FragmentActivity {
    public static String TAG = "WebViewActivity";

    public static final int REQUESTCODE_STORAGE = 50;

    protected AppManager appManager = null;
    private GestureDetector gestureDetector = null;

    private String adbUri = "";

    private void getIntentUri() {
        Intent intent = getIntent();
        String action = intent.getAction();
        if ((action != null) && action.equals("android.intent.action.VIEW")) {

            Uri uri = intent.getData();
            if (uri != null) {
                if (IntentManager.checkTrinityScheme(uri.toString())) {
                    appManager.setIntentUri(uri);
                }
                else {
                    //For test
//                    boolean dev = intent.hasCategory("android.intent.category.TEST");
                    //boolean dev = true; // TMP BPI SHOULD BE FALSE
                    boolean dev = false;
                    // if (dev) {
                        if (ContextCompat.checkSelfPermission(this, Manifest.permission.READ_EXTERNAL_STORAGE)
                                != PackageManager.PERMISSION_GRANTED) {
                            this.adbUri = uri.toString();
                            ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.READ_EXTERNAL_STORAGE}, REQUESTCODE_STORAGE);
                            return;
                        }
                    // }
                    appManager.setInstallUri(uri.toString(), dev);
                }
            }
        }
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        //Aqui debo crear el loading

        setContentView(R.layout.activity_view);
        appManager = new AppManager(this);

        getIntentUri();

        gestureDetector = new GestureDetector(this, onGestureListener);


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
        getIntentUri();
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

        if (requestCode == REQUESTCODE_STORAGE && permissions[0].equals(Manifest.permission.READ_EXTERNAL_STORAGE)) {
            if (grantResults[0] != -1) {
                appManager.setInstallUri(this.adbUri, true);
            }
        }
        else {
            try {
                appManager.onRequestPermissionResult(requestCode, permissions, grantResults);
            } catch (JSONException e) {
                LOG.d(TAG, "JSONException: Parameters fed into the method are not valid");
                e.printStackTrace();
            }
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
        if ((gestureDetector != null) && (appManager != null) && (appManager.curFragment != null)) {
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
                        if (appManager != null) {
                            appManager.flingTheme();
                        }
                    }
                    return true;
                }
            };
}
