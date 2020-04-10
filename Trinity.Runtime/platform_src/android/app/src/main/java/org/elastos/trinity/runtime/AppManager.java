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
//import android.app.FragmentManager;
//import android.app.FragmentTransaction;
import android.content.DialogInterface;
import android.content.res.AssetManager;
import android.content.res.Configuration;
import android.net.Uri;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;
import android.util.Log;
import android.view.View;

import org.apache.cordova.PluginManager;
import org.json.JSONException;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

public class AppManager {

    /** The internal message */
    public static final int MSG_TYPE_INTERNAL = 1;
    /** The internal return message. */
    public static final int MSG_TYPE_IN_RETURN = 2;
    /** The internal refresh message. */
    public static final int MSG_TYPE_IN_REFRESH = 3;
    /** The installing message. */
    public static final int MSG_TYPE_INSTALLING = 4;

    /** The external message */
    public static final int MSG_TYPE_EXTERNAL = 11;
    /** The external launcher message */
    public static final int MSG_TYPE_EX_LAUNCHER = 12;
    /** The external install message */
    public static final int MSG_TYPE_EX_INSTALL = 13;
    /** The external return message. */
    public static final int MSG_TYPE_EX_RETURN = 14;


    public static final String LAUNCHER = "launcher";

    private static AppManager appManager;
    public WebViewActivity activity;
    public WebViewFragment curFragment = null;
    ManagerDBAdapter dbAdapter = null;

    public String appsPath = null;
    public String dataPath = null;
    public String configPath = null;
    public String tempPath = null;

    private AppInstaller installer;

    protected LinkedHashMap<String, AppInfo> appInfos;
    private ArrayList<String> lastList = new ArrayList<String>();
    private ArrayList<String> runningList = new ArrayList<String>();
    public AppInfo[] appList;
    protected LinkedHashMap<String, Boolean> visibles = new LinkedHashMap<String, Boolean>();

    private AppInfo launcherInfo;

    private class InstallInfo {
        String uri;
        boolean dev;

        InstallInfo(String uri, boolean dev) {
            this.uri = uri;
            this.dev = dev;
        }
    }

    private ArrayList<InstallInfo>  installUriList = new ArrayList<InstallInfo>();
    private ArrayList<Uri>          intentUriList = new ArrayList<Uri>();
    private PermissionManager permissionManager;
    private boolean launcherReady = false;

    final static String[] defaultPlugins = {
            "AppManager",
            "StatusBar",
            "Clipboard",
            "TitleBarPlugin"
    };

    AppManager(WebViewActivity activity) {
        AppManager.appManager = this;
        this.activity = activity;
        permissionManager = new PermissionManager(activity);

        appsPath = activity.getFilesDir() + "/apps/";
        dataPath = activity.getFilesDir() + "/data/";
        configPath = activity.getFilesDir() + "/config/";
        tempPath = activity.getFilesDir() + "/temp/";

        File destDir = new File(appsPath);
        if (!destDir.exists()) {
            destDir.mkdirs();
        }
        destDir = new File(dataPath);
        if (!destDir.exists()) {
            destDir.mkdirs();
        }
        destDir = new File(configPath);
        if (!destDir.exists()) {
            destDir.mkdirs();
        }
        destDir = new File(tempPath);
        if (!destDir.exists()) {
            destDir.mkdirs();
        }

        dbAdapter = new ManagerDBAdapter(activity);
//        dbAdapter.clean();

        installer = new AppInstaller();
        installer.init(activity, dbAdapter, appsPath, dataPath, tempPath);

        refreashInfos();
        getLauncherInfo();
        saveLauncher();
        try {
            // TMP BPI loadLauncher();
            launchStartupScreen();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        saveBuiltInApps();
        refreashInfos();
        sendRefreshList("initiated", null);

        if (PreferenceManager.getShareInstance().getDeveloperMode()) {
//            CLIService.getShareInstance().start();
        }
    }


    public static AppManager getShareInstance() {
        return AppManager.appManager;
    }

    public ManagerDBAdapter getDBAdapter() {
        return dbAdapter;
    }

    private InputStream getAssetsFile(String path) {
        InputStream input = null;

        AssetManager manager = activity.getAssets();
        try {
            input = manager.open(path);
        }
        catch (IOException e) {
            e.printStackTrace();
        }

        return input;
    }

    private void installBuiltInApp(String path, String id, int launcher) throws Exception {
        Log.d("AppManager", "Entering installBuiltInApp path="+path+" id="+id+" launcher="+launcher);

        path = path + id;
        InputStream input = getAssetsFile(path + "/manifest.json");
        if (input == null) {
            input = getAssetsFile(path + "/assets/manifest.json");
            if (input == null) {
                Log.e("AppManager", "No manifest found, returning");
                return;
            }
        }
        AppInfo builtInInfo = installer.parseManifest(input, launcher);

        AppInfo installedInfo = getAppInfo(id);
        Boolean needInstall = true;
        if (installedInfo != null) {
            if (builtInInfo.version_code > installedInfo.version_code) {
                Log.d("AppManager", "built in version > installed version: uninstalling installed");
                installer.unInstall(installedInfo, true);
            }
            else {
                Log.d("AppManager", "Built in version <= installed version, No need to install");
                needInstall = false;
            }
        }
        else {
            Log.d("AppManager", "No installed info found");
        }

        if (needInstall) {
            Log.d("AppManager", "Needs install - copying assets and setting built-in to 1");
            installer.copyAssetsFolder(path, appsPath + builtInInfo.app_id);
            builtInInfo.built_in = 1;
            dbAdapter.addAppInfo(builtInInfo);
            if (launcher == 1) {
                launcherInfo = null;
                getLauncherInfo();
            }
        }
    }

    private void saveLauncher() {
        try {
            installBuiltInApp("www/", "launcher", 1);

            File launcher = new File(appsPath, AppManager.LAUNCHER);
            if (launcher.exists()) {
                AppInfo info = installer.getInfoByManifest(appsPath + AppManager.LAUNCHER + "/", 1);
                info.built_in = 1;
                int count = dbAdapter.removeAppInfo(launcherInfo);
                if (count < 1) {
                    Log.e("AppManager", "Launcher upgrade -- Can't remove the older DB info.");
                    //TODO:: need remove the files? now, restart will try again.
                    return;
                }
                installer.renameFolder(launcher, appsPath, launcherInfo.app_id);
                dbAdapter.addAppInfo(info);
                launcherInfo = null;
                getLauncherInfo();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * USE CASES:
     *
     * Built-in dapp -> update using trinity CLI:
     *  - Should use the uploaded dapp
     *  - Should not check version_code
     * Built-in dapp -> downloaded dapp + install():
     *  - Should install and use only if version code > existing app
     * Built-in dapp -> downloaded dapp + install() ok -> install new trinity:
     *  - Should install built-in only if version code > installed
     * Built-in dapp -> Removed in next trinity version:
     *  - Do nothing, use can manually uninstall.
     *
     *  ALGORITHM:
     *  - At start:
     *      - For each built-in app:
     *          - if version > installed version => install built-in over installed
     *  - When installing from ADB:
     *      - Don't check versions, just force install over installed, even if version is equal
     *  - When installing from dapp store:
     *      - Install if new version > installed version
     *
     */
    public void saveBuiltInApps(){
        AssetManager manager = activity.getAssets();
        try {
            String[] appdirs= manager.list("www/built-in");

            for (String appdir : appdirs) {
                installBuiltInApp("www/built-in/", appdir, 0);
            }

            for (int i = 0; i < appList.length; i++) {
                System.err.println("save / app "+appList[i].app_id+" buildin "+appList[i].built_in);
                if (appList[i].built_in != 1) {
                    continue;
                }

                boolean needChange = true;
                for (String appdir : appdirs) {
                    if (appdir.equals(appList[i].app_id)) {
                        needChange = false;
                        break;
                    }
                }
                if (needChange) {
                    dbAdapter.changeBuiltInToNormal(appList[i].app_id);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public void setAppVisible(String id, String visible) {
        if (visible.equals("hide")) {
            visibles.put(id, false);
        }
        else {
            visibles.put(id, true);
        }
    }

    public Boolean getAppVisible(String id) {
        Boolean ret = visibles.get(id);
        if (ret == null) {
            return true;
        }
        return ret;
    }

    public AppInfo getLauncherInfo() {
        if (launcherInfo == null) {
            launcherInfo = dbAdapter.getLauncherInfo();
        }
        return launcherInfo;
    }

    public boolean isLauncher(String appId) {
        if (appId == null || launcherInfo == null) {
            return false;
        }

        if (appId.equals(LAUNCHER) || appId.equals(launcherInfo.app_id)) {
            return true;
        }
        else {
            return false;
        }
    }

    private void refreashInfos() {
        appList = dbAdapter.getAppInfos();
        appInfos = new LinkedHashMap();
        for (int i = 0; i < appList.length; i++) {
            appInfos.put(appList[i].app_id, appList[i]);
            Boolean visible = visibles.get(appList[i].app_id);
            if (visible == null) {
                setAppVisible(appList[i].app_id, appList[i].start_visible);
            }
        }
    }

    public AppInfo getAppInfo(String id) {
        if (isLauncher(id)) {
            return getLauncherInfo();
        }
        else {
            return appInfos.get(id);
        }
    }

    public HashMap<String, AppInfo> getAppInfos() {
        return appInfos;
    }

    public String getStartPath(AppInfo info) {
        if (info.remote == 0) {
            return getAppUrl(info) + info.start_url;
        }
        else {
            return info.start_url;
        }
    }

    public String getAppPath(AppInfo info) {
        if (info.remote == 0) {
            return appsPath + info.app_id + "/";
        }
        else {
            return info.start_url.substring(0, info.start_url.lastIndexOf("/") + 1);
        }
    }

    public String getAppUrl(AppInfo info) {
        String url = getAppPath(info);
        if (info.remote == 0) {
            url = "file://" + url;
        }
        return url;
    }

    public String getDataPath(String id) {
        if (isLauncher(id)) {
            id = launcherInfo.app_id;
        }
        return dataPath + id + "/";
    }

    public String getDataUrl(String id) {
        return "file://" + getDataPath(id);
    }


    public String getTempPath(String id) {
        if (isLauncher(id)) {
            id = launcherInfo.app_id;
        }
        return tempPath + id + "/";
    }

    public String getTempUrl(String id) {
        return "file://" + getTempPath(id);
    }

    public String getConfigPath() {
        return configPath;
    }



    public String getIconUrl(AppInfo info) {
        if (info.type.equals("url")) {
            return "file://" + appsPath + info.app_id + "/";
        }
        else {
            return getAppUrl(info);
        }
    }

    public String[] getIconPaths(AppInfo info) {
        String path = getAppPath(info);
        String[] iconPaths = new String[info.icons.size()];
        for (int i = 0; i < info.icons.size(); i++) {
            iconPaths[i] = path + info.icons.get(i).src;
        }
        return iconPaths;
    }

    public String resetPath(String dir, String origin) {
        if (origin.indexOf("http://") != 0 && origin.indexOf("https://") != 0
                && origin.indexOf("file:///") != 0) {
            while (origin.startsWith("/")) {
                origin = origin.substring(1);
            }
            origin = dir + origin;
        }
        return origin;
    }

    public AppInfo install(String url, boolean update) throws Exception  {
        AppInfo info = installer.install(url, update);
        if (info != null) {
            refreashInfos();
        }
        if (info.launcher == 1) {
            sendRefreshList("launcher_upgraded", info);
        }
        else {
            sendRefreshList("installed", info);
        }
        return info;
    }

    public void unInstall(String id, boolean update) throws Exception {
        close(id);
        AppInfo info = appInfos.get(id);
        installer.unInstall(info, update);
        refreashInfos();
        if (!update) {
           if (info.built_in == 1) {
               installBuiltInApp("www/built-in/", info.app_id, 0);
               refreashInfos();
           }
           sendRefreshList("unInstalled", info);
        }
    }

    public WebViewFragment getFragmentById(String id) {
        if (isLauncher(id)) {
            id = LAUNCHER;
        }

        FragmentManager manager = activity.getSupportFragmentManager();
        List<Fragment> fragments = manager.getFragments();
        for (int i = 0; i < fragments.size(); i++) {
            WebViewFragment fragment = (WebViewFragment)fragments.get(i);
            if ((fragment != null) && (fragment.id.equals(id))) {
                return fragment;
            }
        }
        return null;
    }

    public void switchContent(WebViewFragment fragment, String id) {
        FragmentManager manager = activity.getSupportFragmentManager();
        FragmentTransaction transaction = manager.beginTransaction();
        if ((curFragment != null) && (curFragment != fragment)) {
            transaction.hide(curFragment);
        }
        if (curFragment != fragment) {
            if (!fragment.isAdded()) {
                transaction.add(R.id.content, fragment, id);
            }
            else if (curFragment != fragment) {
                transaction.setCustomAnimations(android.R.animator.fade_in, android.R.animator.fade_out)
                        .show(fragment);
            }
//            transaction.addToBackStack(null);
            transaction.commit();
        }

        curFragment = fragment;

        runningList.remove(id);
        runningList.add(0, id);
        lastList.remove(id);
        lastList.add(0, id);
    }

    private void hideFragment(WebViewFragment fragment, String id) {
            FragmentManager manager = activity.getSupportFragmentManager();
            FragmentTransaction transaction = manager.beginTransaction();
            if (!fragment.isAdded()) {
                transaction.add(R.id.content, fragment, id);
            }
            transaction.hide(fragment);
            transaction.commit();

            runningList.add(0, id);
            lastList.add(1, id);
    }

    Boolean isCurrentFragment(WebViewFragment fragment) {
        return (fragment == curFragment);
    }

    public boolean doBackPressed() {
        if (launcherInfo == null || curFragment == null || isLauncher(curFragment.id)) {
            return true;
        }
        else {
            switchContent(getFragmentById(launcherInfo.app_id), launcherInfo.app_id);
            try {
                AppManager.getShareInstance().sendLauncherMessageMinimize(curFragment.id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            return false;
        }
    }

    public void start(String id) throws Exception {
        AppInfo info = getAppInfo(id);
        if (info == null) {
            throw new Exception("No such app!");
        }

        WebViewFragment fragment = getFragmentById(id);
        if (fragment == null) {
            fragment = WebViewFragment.newInstance(id);
            if (!isLauncher(id)) {
                sendRefreshList("started", info);
            }

            if (!getAppVisible(id)) {
                hideFragment(fragment, id);
            }
        }


        if (getAppVisible(id)) {
            switchContent(fragment, id);
        }
    }

    public void close(String id) throws Exception {
        if (isLauncher(id)) {
            return; // TMP BPI TEST throw new Exception("Launcher can't close!");
        }

        AppInfo info = appInfos.get(id);
        if (info == null) {
            throw new Exception("No such app!");
        }

        setAppVisible(id, info.start_visible);

        FragmentManager manager = activity.getSupportFragmentManager();
        WebViewFragment fragment = getFragmentById(id);
        if (fragment == null) {
            return;
        }

        if (fragment == curFragment) {
            String id2 = lastList.get(1);
            WebViewFragment fragment2 = getFragmentById(id2);
            if (fragment2 == null) {
                fragment2 = getFragmentById(LAUNCHER);
                if (fragment2 == null) {
                    throw new Exception("RT inner error!");
                }
            }
            switchContent(fragment2, id2);
        }

        FragmentTransaction transaction = manager.beginTransaction();
        transaction.remove(fragment);
        transaction.commit();
        lastList.remove(id);
        runningList.remove(id);

        sendRefreshList("closed", info);
    }

    /**
     * Closes all running apps, except the launch app.
     */
    public void closeAll() throws Exception {
        for (String appId : getRunningList()) {
            close(appId);
        }
    }

    public void loadLauncher() throws Exception {
        start(LAUNCHER);
    }

    public void launchStartupScreen() throws Exception {
        // Check if a there is a signed in DID. If so, directly start the launcher. If not,
        // start the DID session dapp
        DIDSessionManager.getSharedInstance().setAppManager(this);
        DIDSessionManager.IdentityEntry signedInIdentity = DIDSessionManager.getSharedInstance().getSignedInIdentity();
        if (signedInIdentity == null) {
            // No DID signed in
            loadLauncher(); // TODO - IMPORTANT NOTE: for now because did session app crashes if launcher was not loaded, we also start the launcher FOR TEST. Later , launcher should NOT start if DID session starts
            start("org.elastos.trinity.dapp.didsession");
        }
        else {
            // A DID is signed in
            loadLauncher();
        }
    }

    /**
     * Signs in to a new DID session.
     */
    public void signIn() throws Exception {
        // Stop the did session app
        close("org.elastos.trinity.dapp.didsession");

        // Start the launcher app
        launchStartupScreen();
    }

    /**
     * Signs out from a DID session. All apps and services are closed, and launcher goes back to the DID session app prompt.
     */
    public void signOut() throws Exception {
        closeAll();

        // Go back to the startup screen
        launchStartupScreen();
    }

    private void installUri(String uri, boolean dev) {
        if (dev && PreferenceManager.getShareInstance().getDeveloperMode()) {
            try {
                install(uri, true);
            }
            catch (Exception e) {
                Utility.alertPrompt("Error", e.getLocalizedMessage(), this.activity);
            }
        }
        else {
            sendInstallMsg(uri);
        }
    }

    public void setInstallUri(String uri, boolean dev) {
        if (uri == null) return;

        if (launcherReady || dev) {
            installUri(uri, dev);
        }
        else {
            installUriList.add(new InstallInfo(uri, dev));
        }
    }

    public void setIntentUri(Uri uri) {
        if (uri == null) return;

        if (launcherReady) {
            IntentManager.getShareInstance().doIntentByUri(uri);
        }
        else {
            intentUriList.add(uri);
        }
    }

    public boolean isLauncherReady() {
        return launcherReady;
    }

    public void setLauncherReady() {
        launcherReady = true;

        for (int i = 0; i < installUriList.size(); i++) {
            InstallInfo info = installUriList.get(i);
            sendInstallMsg(info.uri);
        }

        for (int i = 0; i < intentUriList.size(); i++) {
            Uri uri = intentUriList.get(i);
            IntentManager.getShareInstance().doIntentByUri(uri);
        }
    }

    public void sendLauncherMessage(int type, String msg, String fromId) throws Exception {
        sendMessage(LAUNCHER, type, msg, fromId);
    }

    public void sendLauncherMessageMinimize(String fromId) throws Exception {
        sendLauncherMessage(AppManager.MSG_TYPE_INTERNAL,
                "{\"action\":\"minimize\"}", fromId);
    }

    private void sendInstallMsg(String uri) {
        String msg = "{\"uri\":\"" + uri + "\", \"dev\":\"false\"}";
        try {
            sendLauncherMessage(MSG_TYPE_EX_INSTALL, msg, "system");
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void sendRefreshList(String action, AppInfo info) {
        try {
            if (info != null) {
                sendLauncherMessage(MSG_TYPE_IN_REFRESH,
                        "{\"action\":\"" + action + "\", \"id\":\"" + info.app_id + "\" , \"name\":\"" + info.name + "\"}", "system");
            }
            else {
                sendLauncherMessage( MSG_TYPE_IN_REFRESH,
                    "{\"action\":\"" + action + "\"}", "system");
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void sendMessage(String toId, int type, String msg, String fromId) throws Exception {
        WebViewFragment fragment = getFragmentById(toId);
        if (fragment != null) {
            fragment.basePlugin.onReceive(msg, type, fromId);
        }
        else if (!isLauncher(toId)){
            throw new Exception(toId + " isn't running!");
        }
    }

    public void broadcastMessage(int type, String msg, String fromId) {
        FragmentManager manager = activity.getSupportFragmentManager();
        List<Fragment> fragments = manager.getFragments();

        for (int i = 0; i < fragments.size(); i++) {
            WebViewFragment fragment = (WebViewFragment)fragments.get(i);
            if (fragment != null && fragment.appView != null) {
                fragment.basePlugin.onReceive(msg, type, fromId);
            }
        }
    }

    public int getPluginAuthority(String id, String plugin) {
        for (String item : defaultPlugins) {
            if (item.equals(plugin)) {
                return AppInfo.AUTHORITY_ALLOW;
            }
        }

        AppInfo info = appInfos.get(id);
        if (info != null) {
            for (AppInfo.PluginAuth pluginAuth : info.plugins) {
                if (pluginAuth.plugin.equals(plugin)) {
                    return pluginAuth.authority;
                }
            }
        }
        return AppInfo.AUTHORITY_NOEXIST;
    }

    public int getUrlAuthority(String id, String url) {
        AppInfo info = appInfos.get(id);
        if (info != null) {
            for (AppInfo.UrlAuth urlAuth : info.urls) {
                if (urlAuth.url.equals(url)) {
                    return urlAuth.authority;
                }
            }
        }
        return AppInfo.AUTHORITY_NOEXIST;
    }

    public int getIntentAuthority(String id, String url) {
        AppInfo info = appInfos.get(id);
        if (info != null) {
            for (AppInfo.UrlAuth urlAuth : info.intents) {
                if (urlAuth.url.equals(url)) {
                    return urlAuth.authority;
                }
            }
        }
        return AppInfo.AUTHORITY_NOEXIST;
    }

    public void setPluginAuthority(String id, String plugin, int authority) throws Exception {
        AppInfo info = appInfos.get(id);
        if (info == null) {
            throw new Exception("No such app!");
        }

        for (AppInfo.PluginAuth pluginAuth : info.plugins) {
            if (pluginAuth.plugin.equals(plugin)) {
                int count = dbAdapter.updatePluginAuth(info.tid, plugin, authority);
                if (count > 0) {
                    pluginAuth.authority = authority;
                    sendRefreshList("authorityChanged", info);
                }
                return;
            }
        }
        throw new Exception("The plugin isn't in list!");
    }

    public void setUrlAuthority(String id, String url, int authority)  throws Exception {
        AppInfo info = appInfos.get(id);
        if (info == null) {
            throw new Exception("No such app!");
        }

        for (AppInfo.UrlAuth urlAuth : info.urls) {
            if (urlAuth.url.equals(url)) {
                int count = dbAdapter.updateURLAuth(info.tid, url, authority);
                if (count > 0) {
                    urlAuth.authority = authority;
                    sendRefreshList("authorityChanged", info);
                }
                return ;
            }
        }
        throw new Exception("The plugin isn't in list!");
    }

    private static void print(String msg) {
        String name = Thread.currentThread().getName();
        System.out.println(name + ": " + msg);
    }

    private class LockObj {
        int authority = AppInfo.AUTHORITY_NOINIT;
    }
    private LockObj urlLock = new LockObj();
    private LockObj pluginLock = new LockObj();

    public synchronized int runAlertPluginAuth(AppInfo info, String plugin, int originAuthority) {
        try {
            synchronized (pluginLock) {
                pluginLock.authority = getPluginAuthority(info.app_id, plugin);
                if (pluginLock.authority != originAuthority) {
                    return pluginLock.authority;
                }
                activity.runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        alertPluginAuth(info, plugin, pluginLock);
                    }
                });

                if (pluginLock.authority == originAuthority) {
                    pluginLock.wait();
                }
            }
        } catch (InterruptedException e) {
            e.printStackTrace();
            return originAuthority;
        }
        return pluginLock.authority;
    }

    public void alertPluginAuth(AppInfo info, String plugin, LockObj lock) {
        AlertDialog.Builder ab = new AlertDialog.Builder(activity);
        ab.setTitle("Plugin authority request");
        ab.setMessage("App:'" + info.name + "' request plugin:'" + plugin + "' access authority.");
        ab.setIcon(android.R.drawable.ic_dialog_info);
        ab.setCancelable(false);

        ab.setPositiveButton("Allow", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                try {
                    setPluginAuthority(info.app_id, plugin, AppInfo.AUTHORITY_ALLOW);
                }
                catch (Exception e) {
                    e.printStackTrace();
                }
                synchronized (lock) {
                    lock.authority = AppInfo.AUTHORITY_ALLOW;
                    lock.notify();
                }
            }
        });
        ab.setNegativeButton("Refuse", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                try {
                    setPluginAuthority(info.app_id, plugin, AppInfo.AUTHORITY_DENY);
                }
                catch (Exception e) {
                    e.printStackTrace();
                }
                synchronized (lock) {
                    lock.authority = AppInfo.AUTHORITY_DENY;
                    lock.notify();
                }
            }
        });
        ab.show();
    }

    public synchronized int runAlertUrlAuth(AppInfo info, String url, int originAuthority) {
        try {
            synchronized (urlLock) {
                urlLock.authority = getUrlAuthority(info.app_id, url);
                if (urlLock.authority != originAuthority) {
                    return urlLock.authority;
                }

                activity.runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        alertUrlAuth(info, url, urlLock);
                    }
                });

                if (urlLock.authority == originAuthority) {
                    urlLock.wait();
                }
            }

        } catch (InterruptedException e) {
            e.printStackTrace();
            return originAuthority;
        }
        return urlLock.authority;
    }

    public void alertUrlAuth(AppInfo info, String url, LockObj lock) {
        AlertDialog.Builder ab = new AlertDialog.Builder(activity);
        ab.setTitle("Url authority request");
        ab.setMessage("App:'" + info.name + "' request url:'" + url + "' access authority.");
        ab.setIcon(android.R.drawable.ic_dialog_info);
        ab.setCancelable(false);

        ab.setPositiveButton("Allow", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                try {
                    setUrlAuthority(info.app_id, url, AppInfo.AUTHORITY_ALLOW);
                }
                catch (Exception e) {
                    e.printStackTrace();
                }
                synchronized (lock) {
                    lock.authority = AppInfo.AUTHORITY_ALLOW;
                    lock.notify();
                }
            }
        });
        ab.setNegativeButton("Refuse", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                try {
                    setUrlAuthority(info.app_id, url, AppInfo.AUTHORITY_DENY);
                }
                catch (Exception e) {
                    e.printStackTrace();
                }
                synchronized (lock) {
                    lock.authority = AppInfo.AUTHORITY_DENY;
                    lock.notify();
                }
            }
        });
        ab.show();
    }

    public String[] getAppIdList() {
        String[] ids = new String[appList.length];
        for (int i = 0; i < appList.length; i++) {
            ids[i] = appList[i].app_id;
        }
        return ids;
    }

    public AppInfo[] getAppInfoList() {
        return appList;
    }

    public String[] getRunningList() {
        String[] ids = new String[runningList.size()];
        return runningList.toArray(ids);
    }

    public String[] getLastList() {
        String[] ids = new String[lastList.size()];
        return lastList.toArray(ids);
    }


    public void flingTheme() {
        if (curFragment == null) {
            return;
        }

        if (curFragment.titlebar.getVisibility() == View.VISIBLE) {
            curFragment.titlebar.setVisibility(View.GONE);
        } else {
//            fragment.titlebar.bringToFront();//for qrscanner
            curFragment.titlebar.setVisibility(View.VISIBLE);
        }
    }

    public void onConfigurationChanged(Configuration newConfig) {
        FragmentManager manager = activity.getSupportFragmentManager();
        List<Fragment> fragments = manager.getFragments();

        for (int i = 0; i < fragments.size(); i++) {
            WebViewFragment fragment = (WebViewFragment)fragments.get(i);
            if (fragment != null && fragment.appView != null) {
                PluginManager pm = fragment.appView.getPluginManager();
                if (pm != null) {
                    pm.onConfigurationChanged(newConfig);
                }
            }
        }
    }

    public void onRequestPermissionResult(int requestCode, String permissions[],
                                           int[] grantResults) throws JSONException {
        FragmentManager manager = activity.getSupportFragmentManager();
        List<Fragment> fragments = manager.getFragments();

        for (int i = 0; i < fragments.size(); i++) {
            WebViewFragment fragment = (WebViewFragment)fragments.get(i);
            if (fragment != null) {
                fragment.onRequestPermissionResult(requestCode, permissions, grantResults);
            }
        }
    }
}
