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
import android.os.Handler;
import android.os.Looper;
import android.os.MessageQueue;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.Whitelist;

public class AppWhitelistPlugin extends CordovaPlugin {
    private static final String LOG_TAG = "AppWhitelist";
    private AppInfo appInfo = null;

    final String[] intentList = {
            "mailto:*",
            "tel:*",
            "sms:*",
            "geo:*"
    };

    private AppWhitelist allowedAppNavigations;
    private AppWhitelist allowedAppIntents;
    private Whitelist allowedNavigations;
    private Whitelist allowedIntents;
    private Whitelist allowedRequests;

    public AppWhitelistPlugin(AppInfo info) {
        this.appInfo = info;
        AppManager appManager = AppManager.getShareInstance();
        String appPath = appManager.getAppUrl(info) + "*";
        String dataPath = appManager.getDataUrl(info.app_id) + "*";
        allowedRequests  = new Whitelist();
        allowedRequests.addWhiteListEntry(appPath, false);
        allowedRequests.addWhiteListEntry(dataPath, false);
        allowedRequests.addWhiteListEntry("asset://www/cordova*", false);
        allowedRequests.addWhiteListEntry("asset://www/plugins/*", false);
        allowedRequests.addWhiteListEntry("asset://www/public/*", false);

        allowedRequests.addWhiteListEntry("trinity:///asset/*", false);
        allowedRequests.addWhiteListEntry("trinity:///data/*", false);

        allowedRequests.addWhiteListEntry("http://localhost/*", false);
        allowedRequests.addWhiteListEntry("https://localhost/*", false);

        String[] list = ConfigManager.getShareInstance().getStringArrayValue("whitelist.urls", new String[0]);
        for (int i = 0; i < list.length; i++) {
            allowedRequests.addWhiteListEntry(list[i], false);
        }

        allowedNavigations = allowedRequests;
        allowedIntents = new Whitelist();

        for (String item : intentList) {
            allowedIntents.addWhiteListEntry(item, false);
        }

        allowedAppNavigations = new AppWhitelist(info, AppWhitelist.TYPE_URL);
        allowedAppIntents= new AppWhitelist(info, AppWhitelist.TYPE_INTENT);
    }

    @Override
    public void pluginInitialize() {
        if (allowedNavigations == null) {
            allowedNavigations = new Whitelist();
            allowedIntents = new Whitelist();
            allowedRequests = new Whitelist();
//            new CustomAppXmlParser().parse(webView.getContext());
        }
    }


    @Override
    public Boolean shouldAllowNavigation(String url) {
        if (allowedNavigations.isUrlWhiteListed(url)) {
            return true;
        }
        else if (allowedAppNavigations.isUrlAllowAuthority(url)) {
            return true;
        }
        return null; // Default policy
    }

    @Override
    public Boolean shouldAllowRequest(String url) {
        if (Boolean.TRUE == shouldAllowNavigation(url)) {
            return true;
        }
        if (allowedRequests.isUrlWhiteListed(url)) {
            return true;
        }
        return null; // Default policy
    }

    @Override
    public Boolean shouldOpenExternalUrl(String url) {
//        if (IntentManager.checkTrinityScheme(url)) {
//            return true;
//        }
        if (allowedIntents.isUrlWhiteListed(url)) {
            return true;
        }
        else if (allowedAppIntents.isUrlAllowAuthority(url)) {
            return true;
        }
        return false; // Default policy
    }

    public Whitelist getAllowedNavigations() {
        return allowedNavigations;
    }

    public void setAllowedNavigations(Whitelist allowedNavigations) {
        this.allowedNavigations = allowedNavigations;
    }

    public Whitelist getAllowedIntents() {
        return allowedIntents;
    }

    public void setAllowedIntents(Whitelist allowedIntents) {
        this.allowedIntents = allowedIntents;
    }

    public Whitelist getAllowedRequests() {
        return allowedRequests;
    }

    public void setAllowedRequests(Whitelist allowedRequests) {
        this.allowedRequests = allowedRequests;
    }
}
