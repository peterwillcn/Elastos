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
import java.util.Locale;
import java.util.Map;

public class TitleBarPlugin extends TrinityPlugin {

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        try {
            switch (action) {
                case "showActivityIndicator":
                    this.showActivityIndicator(args, callbackContext);
                    break;
                case "hideActivityIndicator":
                    this.hideActivityIndicator(args, callbackContext);
                    break;
                case "setTitle":
                    this.setTitle(args, callbackContext);
                    break;
                case "setBackgroundColor":
                    this.setBackgroundColor(args, callbackContext);
                    break;
                case "setForegroundMode":
                    this.setForegroundMode(args, callbackContext);
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

    private void showActivityIndicator(JSONArray args, CallbackContext callbackContext) throws Exception {
        int activityIndicatoryType = args.getInt(0);

        getTitleBar().showActivityIndicator(TitleBar.TitleBarActivityType.fromId(activityIndicatoryType));

        callbackContext.success();
    }

    private void hideActivityIndicator(JSONArray args, CallbackContext callbackContext) throws Exception {
        int activityIndicatoryType = args.getInt(0);

        getTitleBar().hideActivityIndicator(TitleBar.TitleBarActivityType.fromId(activityIndicatoryType));

        callbackContext.success();
    }

    private void setTitle(JSONArray args, CallbackContext callbackContext) throws Exception {
        String title = args.getString(0);

        getTitleBar().setTitle(title);

        callbackContext.success();
    }

    private void setBackgroundColor(JSONArray args, CallbackContext callbackContext) throws Exception {
        String hexColor = args.getString(0);

        if (getTitleBar().setBackgroundColor(hexColor))
            callbackContext.success();
        else
            callbackContext.error("Invalid color "+hexColor);
    }

    private void setForegroundMode(JSONArray args, CallbackContext callbackContext) throws Exception {
        int modeAsInt = args.getInt(0);

        getTitleBar().setForegroundMode(TitleBar.TitleBarForegroundMode.fromId(modeAsInt));

        callbackContext.success();
    }

    private TitleBar getTitleBar() {
        return ((WebViewFragment)((TrinityCordovaInterfaceImpl)cordova).fragment).getTitlebar();
    }
}
