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

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;

public class AuthorityPlugin extends CordovaPlugin {

    private CordovaPlugin originalPlugin = null;
    private AppInfo appInfo = null;
    private String pluginName = null;

    AuthorityPlugin(String className, AppInfo info, String name, AppWhitelistPlugin whitelistPlugin) {
        appInfo = info;
        pluginName = name;
        originalPlugin = instantiatePlugin(className, whitelistPlugin);
    }

    private TrinityPlugin instantiatePlugin(String className, AppWhitelistPlugin whitelistPlugin) {
        TrinityPlugin ret = null;
        try {
            Class<?> c = null;
            if ((className != null) && !("".equals(className))) {
                c = Class.forName(className);
            }
            if (c != null & CordovaPlugin.class.isAssignableFrom(c)) {
                ret = (TrinityPlugin) c.newInstance();
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error adding plugin " + className + ".");
        }
        if (ret != null) {
            ret.setWhitelistPlugin(whitelistPlugin);
        }
        return ret;
    }

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (originalPlugin != null) {
            int authority = AppManager.appManager.getPluginAuthority(appInfo.app_id, pluginName);
            if (authority == AppInfo.AUTHORITY_ALLOW) {
                return originalPlugin.execute(action, args, callbackContext);
            }
            else if (authority == AppInfo.AUTHORITY_NOINIT || authority == AppInfo.AUTHORITY_ASK) {
                AppManager.appManager.runAlertPluginAuth(appInfo, pluginName);
//                AppManager.appManager.sendMessage("launcher", AppInfo.MSG_PLUGIN_AUTHORITY,
//                        "{plugin:" + pluginName + ", authority:" + authority + "}", appId);
            }
            callbackContext.error("Plugin:'" + pluginName + "' have not run authority.");
        }
        return false;
    }
}
