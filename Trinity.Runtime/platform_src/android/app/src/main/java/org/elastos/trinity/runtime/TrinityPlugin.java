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
import org.elastos.trinity.runtime.contactnotifier.ContactNotifier;
import org.elastos.trinity.runtime.didsessions.DIDSessionManager;

import java.io.File;

public class TrinityPlugin extends CordovaPlugin {
    private AppWhitelistPlugin whitelistPlugin = null;
    public String dataPath = null;
    public String appPath = null;
    public String tempPath = null;
    public String configPath = null;
    private AppInfo appInfo = null;
    public AppManager appManager = null;
    protected String appId;
    protected String did;

    public void setWhitelistPlugin(AppWhitelistPlugin appWhitelistPlugin) {
        this.whitelistPlugin = appWhitelistPlugin;
    }

    public void setInfo(AppInfo info) {
        this.appInfo = info;
        this.appManager = AppManager.getShareInstance();
        this.appPath = appManager.getAppPath(info);
        this.dataPath = appManager.getDataPath(info.app_id);
        this.configPath = appManager.getConfigPath();
        this.tempPath = appManager.getTempPath(info.app_id);
        this.appId = info.app_id;

        try {
            // TODO @dongxiao - handle the exception this.did = DIDSessionManager.getSharedInstance().getSignedInIdentity().didString;
            this.did = DIDSessionManager.getSharedInstance().getSignedInIdentity().didString; // TODO: FAKE DID FOR NOW
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean isAllowAccess(String url) {
        if (whitelistPlugin != null) {
            Boolean ret = whitelistPlugin.shouldAllowNavigation(url);
            if (ret == Boolean.TRUE) {
                return true;
            }
            else {
                return false;
            }
        }
        else {
            return true;
        }
    }

    public boolean shouldOpenExternalIntentUrl(String url) {
        return webView.getPluginManager().shouldOpenExternalUrl(url);
    }

    public boolean isUrlApp() {
        return appInfo.type.equals("url");
    }

    public String getAppPath() {
        return appPath;
    }

    public String getDataPath() {
        return dataPath;
    }

    public String getTempPath() {
        return tempPath;
    }

    public String getAppUrl() {
        return appManager.getAppUrl(appInfo);
    }

    public String getDataUrl() {
        return appManager.getDataUrl(appInfo.app_id);
    }

    public String getTempUrl() {
        return appManager.getDataUrl(appInfo.app_id);
    }

    public String getConfigPath() {
        return configPath;
    }

    private String getCanonicalDir(String path, String header) throws Exception {
        File file = new File(path);
        path = file.getCanonicalPath();

        if (header.equals(path + "/")) {
            return "";
        }

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
        if (path.startsWith("trinity://")) {
            String subPath = path.substring(10);
            String id = null;
            String _appPath = appPath, _dataPath = dataPath, _tempPath = tempPath;
            if (!(path.startsWith("trinity:///"))) {
                int index = subPath.indexOf("/");
                if (index != -1) {
                    id = subPath.substring(0, index);
                    subPath = subPath.substring(index);

                    AppInfo info = appManager.getAppInfo(id);
                    if (info == null) {
                        id = null;
                    }
                    else {
                        _appPath = appManager.getAppPath(info);
                        _dataPath = appManager.getDataPath(info.app_id);
                        _tempPath = appManager.getTempPath(info.app_id);
                    }
                }
            }
            else {
                id = this.appInfo.app_id;
            }

            if (id != null) {
                if (subPath.startsWith("/asset/")) {
                    String dir = getCanonicalDir(subPath, "/asset/");
                    ret = _appPath + dir;
                } else if (subPath.startsWith("/data/")) {
                    String dir = getCanonicalDir(subPath, "/data/");
                    ret = _dataPath + dir;
                } else if (subPath.startsWith("/temp/")) {
                    String dir = getCanonicalDir(subPath, "/temp/");
                    ret = _tempPath + dir;
                }
            }
        }
        else if ((path.indexOf("://") != -1)) {
            if (!(path.startsWith("asset://")) && isAllowAccess(path)) {
                ret = path;
            }
        }
        else if (!path.startsWith("/")) {
            String dir = getCanonicalDir("/asset/" + path, "/asset/");
            ret = appPath + dir;
        }

        if (ret == null) {
            throw new Exception("Dir is invalid!");
        }

        return ret;
    }

    public String getDataCanonicalPath(String path) throws Exception {
        if (!path.startsWith("trinity:///data/"))  {
            throw new Exception("Dir is invalid!");
        }
        return getCanonicalPath(path);
    }

    public String getRelativePath(String path) throws Exception {
        String ret = null;
        if (!(path.startsWith("asset://")) && (path.indexOf("://") != -1)) {
            if (isAllowAccess(path)) {
                ret = path;
            }
        }
        else if (path.startsWith(appPath)) {
            File file = new File(appPath);
            String header = file.getCanonicalPath() + "/";
            ret = "trinity:///asset/" + getCanonicalDir(path, header);
        }
        else if (path.startsWith(dataPath)) {
            File file = new File(dataPath);
            String header = file.getCanonicalPath() + "/";
            ret = "trinity:///data/" + getCanonicalDir(path, header);
        }
        else if (path.startsWith(tempPath)) {
            File file = new File(tempPath);
            String header = file.getCanonicalPath() + "/";
            ret = "trinity:///temp/" + getCanonicalDir(path, header);
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
