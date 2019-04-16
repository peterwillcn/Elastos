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

import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaPreferences;
import org.apache.cordova.CordovaWebView;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;

public class TrinityPlugin extends CordovaPlugin {
    private AppWhitelistPlugin whitelistPlugin;
    public String dataPath = null;
    public String appPath = null;
    private AppInfo appInfo = null;
    private AppManager appManager = null;

    public void setWhitelistPlugin(AppWhitelistPlugin appWhitelistPlugin) {
        this.whitelistPlugin = appWhitelistPlugin;
    }

    public void setInfo(AppInfo info) {
        this.appInfo = info;
        this.appManager = AppManager.getShareInstance();
        this.dataPath = appManager.getDataPath(info.app_id);
        this.appPath = appManager.getAppPath(info);
    }

    public Boolean isAllowAccess(String url) {
        return whitelistPlugin.shouldAllowNavigation(url);
    }

    public String getDataPath() {
        return dataPath;
    }

    public String getAppPath() {
        return appPath;
    }

    private String getCanonicalDir(String path, String header) throws Exception {
        File file = new File(path);
        path = file.getCanonicalPath();
        if (!header.startsWith("/")) {
            path = path.substring(1);
        }
        if (!path.startsWith(header)) {
            throw new Exception("Dir is invalid!");
        }
        String dir = path.substring(header.length());
        return dir;
    }

    public String getCanonicalPath(String path) throws Exception {
        String ret = null;
        if (path.startsWith("trinity:///assets/")) {
            String dir = getCanonicalDir(path.substring(10), "/assets/");
            ret = appPath + dir;
        }
        else if (path.startsWith("trinity:///data/")) {
            String dir = getCanonicalDir(path.substring(10), "/data/");
            ret = dataPath + dir;
        }
        else if ((path.indexOf("://") != -1)) {
            if (!(path.startsWith("assets://")) && whitelistPlugin.shouldAllowNavigation(path)) {
                ret = path;
            }
        }
        else if (!path.startsWith("/")) {
            String dir = getCanonicalDir("/assets/" + path, "/assets/");
            ret = appPath + dir;
        }

        if (ret == null) {
            throw new Exception("Dir is invalid!");
        }

        return ret;
    }

    public String getRelativePath(String path) throws Exception {
        String ret = null;
        if (!(path.startsWith("assets://")) && (path.indexOf("://") != -1)) {
            if (whitelistPlugin.shouldAllowNavigation(path)) {
                ret = path;
            }
        }
        else if (path.startsWith(appPath)) {
            File file = new File(appPath);
            String header = file.getCanonicalPath() + "/";
            ret = "trinity:///assets/" + getCanonicalDir(path, header);
        }
        else if (path.startsWith(dataPath)) {
            File file = new File(dataPath);
            String header = file.getCanonicalPath() + "/";
            ret = "trinity:///data/" + getCanonicalDir(path, header);
        }

        if (ret == null) {
            throw new Exception("Dir is invalid!");
        }
        return ret;
    }

    @Override
    public final void privateInitialize(String serviceName, CordovaInterface cordova,
                                        CordovaWebView webView, CordovaPreferences preferences) {
        if (appInfo == null) {
            setInfo(AppManager.getShareInstance().getLauncherInfo());
        }
        super.privateInitialize(serviceName, cordova, webView, preferences);
    }
}
