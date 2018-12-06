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

import android.net.Uri;

import org.apache.cordova.LOG;
import org.apache.cordova.Whitelist;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class AppWhitelist extends Whitelist {
    AppInfo appInfo;
    private HashMap<String, URLPattern> whiteList;

    public static final String TAG = "AppWhitelist";

    public AppWhitelist(AppInfo info) {
        this.whiteList = new HashMap();
        appInfo = info;
        for (AppInfo.UrlAuth urlAuth : info.urls) {
            addWhiteListEntry(urlAuth.url, false);
        }
    }

    /* Match patterns (from http://developer.chrome.com/extensions/match_patterns.html)
     *
     * <url-pattern> := <scheme>://<host><path>
     * <scheme> := '*' | 'http' | 'https' | 'file' | 'ftp' | 'chrome-extension'
     * <host> := '*' | '*.' <any char except '/' and '*'>+
     * <path> := '/' <any chars>
     *
     * We extend this to explicitly allow a port attached to the host, and we allow
     * the scheme to be omitted for backwards compatibility. (Also host is not required
     * to begin with a "*" or "*.".)
     */
    public void addWhiteListEntry(String origin, boolean subdomains) {
        if (whiteList != null) {
            try {
                // Unlimited access to network resources
                if (origin.compareTo("*") == 0) {
                    LOG.d(TAG, "Unlimited access to network resources");
                    whiteList = null;
                }
                else { // specific access
                    Pattern parts = Pattern.compile("^((\\*|[A-Za-z-]+):(//)?)?(\\*|((\\*\\.)?[^*/:]+))?(:(\\d+))?(/.*)?");
                    Matcher m = parts.matcher(origin);
                    if (m.matches()) {
                        String scheme = m.group(2);
                        String host = m.group(4);
                        // Special case for two urls which are allowed to have empty hosts
                        if (("file".equals(scheme) || "content".equals(scheme)) && host == null) host = "*";
                        String port = m.group(8);
                        String path = m.group(9);
                        if (scheme == null) {
                            // XXX making it stupid friendly for people who forget to include protocol/SSL
                            // whiteList.put(origin, new URLPattern("http", host, port, path));
                            // whiteList.put(origin, new URLPattern("https", host, port, path));
                        } else {
                            whiteList.put(origin, new URLPattern(scheme, host, port, path));
                        }
                    }
                }
            } catch (Exception e) {
                LOG.d(TAG, "Failed to add origin %s", origin);
            }
        }
    }


    /**
     * Determine if URL is in approved list of URLs to load.
     *
     * @param uri
     * @return true if wide open or whitelisted
     */
    public boolean isUrlAllowAuthority(String uri) {
        // If there is no whitelist, then it's wide open
        if (whiteList == null) return true;


        Uri parsedUri = Uri.parse(uri);
        // Look for match in white list
        for (Map.Entry<String, URLPattern> entry : whiteList.entrySet()) {
            URLPattern p = entry.getValue();
            String url = entry.getKey();
            if (p.matches(parsedUri)) {
                int authority = AppManager.appManager.getUrlAuthority(appInfo.app_id, entry.getKey());
                if (authority == AppInfo.AUTHORITY_ALLOW) {
                    return true;
                }
                else if (authority != AppInfo.AUTHORITY_DENY) {
                    AppManager.appManager.runAlertUrlAuth(appInfo, url);
                }
                break;
            }
        }
        return false;
    }
}
