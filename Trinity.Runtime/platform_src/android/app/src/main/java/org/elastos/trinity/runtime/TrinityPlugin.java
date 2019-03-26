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
    private String canonicalDataPath = null;

    public void setWhitelistPlugin(AppWhitelistPlugin appWhitelistPlugin) {
        this.whitelistPlugin = appWhitelistPlugin;
    }

    public void setDataPath(String path) {
        this.dataPath = path;
        File file = new File(path);
        try {
            canonicalDataPath = file.getCanonicalPath();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Boolean isAllowAccess(String url) {
        return whitelistPlugin.shouldAllowNavigation(url);
    }

    public String getDataAbsolutePath(String dir) throws Exception {
        File file = new File(dataPath, dir);
        String path = file.getCanonicalPath();
        if (!path.startsWith(canonicalDataPath)) {
            throw new Exception("Dir is invalid!");
        }
        String substr = path.substring(canonicalDataPath.length() + 1);
        path = dataPath + substr;
        return path;
    }

    public String getDataRelativePath(String path) throws Exception {
        File file = new File(path);
        path = file.getCanonicalPath() ;
        if (!path.startsWith(canonicalDataPath)) {
            throw new Exception("Path is invalid!");
        }
        String dir  = path.substring(canonicalDataPath.length());
        return dir;
    }

    @Override
    public final void privateInitialize(String serviceName, CordovaInterface cordova,
                                        CordovaWebView webView, CordovaPreferences preferences) {
        super.privateInitialize(serviceName, cordova, webView, preferences);
    }
}
