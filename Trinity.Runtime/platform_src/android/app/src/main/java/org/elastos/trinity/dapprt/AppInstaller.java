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

import android.content.Context;
import android.content.res.AssetManager;
import android.net.Uri;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.Random;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

public class AppInstaller {

    final String[] pluginWhitelist = {
            "device",
            "networkstatus",
            "splashscreen",
    };

    final String[] urlWhitelist = {
            "http://www.elastos.org/*",
    };

    private String appPath = null;
    private String dataPath = null;
    private ManagerDBAdapter dbAdapter = null;
    private Context context = null;

    private Random random =new Random();

    public boolean init(Context context, ManagerDBAdapter dbAdapter, String appPath, String dataPath) {
        this.context = context;
        this.appPath = appPath;
        this.dataPath = dataPath;
        this.dbAdapter = dbAdapter;

        random = new Random();

        return true;
    }

    private boolean unpackZip(InputStream srcZip, String destPath) {
        InputStream is;
        ZipInputStream zis;
        try
        {
            String filepath;
            zis = new ZipInputStream(new BufferedInputStream(srcZip));
            ZipEntry ze;
            byte[] buffer = new byte[1024];
            int count;

            while ((ze = zis.getNextEntry()) != null) {
                filepath = destPath + ze.getName();

                if (ze.isDirectory()) {
                    File fmd = new File(filepath);
                    fmd.mkdirs();
                }
                else {
                    File file = new File(filepath);
                    file.getParentFile().mkdirs();

                    FileOutputStream fout = new FileOutputStream(file);

                    // cteni zipu a zapis
                    while ((count = zis.read(buffer)) != -1) {
                        fout.write(buffer, 0, count);
                    }

                    fout.close();
                }
                zis.closeEntry();
            }

            zis.close();
        }
        catch(IOException e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }

    private boolean downloadDAppPackage(String url, String destFile) {
        try {
            BufferedInputStream in = new BufferedInputStream(new URL(url).openStream());
            FileOutputStream fileOutputStream = new FileOutputStream(destFile);
            byte dataBuffer[] = new byte[1024];
            int bytesRead;
            while ((bytesRead = in.read(dataBuffer, 0, 1024)) != -1) {
                fileOutputStream.write(dataBuffer, 0, bytesRead);
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    private void deleteDAppPackage(String packagePath) {
        if (packagePath != null && !packagePath.isEmpty()) {
            File file = new File(packagePath);
            file.delete();
        }
    }

    public AppInfo install(AppManager appManager, String url) {
        InputStream inputStream;
        AppInfo info = null;
        String downloadPkgPath = null;

        try {
            if (url.startsWith("assets://")) {
                AssetManager manager = context.getAssets();
                String substr = url.substring(9);
                inputStream = manager.open(substr);
            }
            else if (url.startsWith("content://")) {
                Uri uri = Uri.parse(url);
                inputStream = context.getContentResolver().openInputStream(uri);
            }
            else if (url.startsWith("http://") || url.startsWith("https://")) {
                downloadPkgPath = appPath + "tmp_" + random.nextInt() + ".epk";
                if (downloadDAppPackage(url, downloadPkgPath)) {
                    inputStream = new FileInputStream(downloadPkgPath);
                }
                else {
                    return null;
                }
            }
            else {
                if (url.startsWith("file://")) {
                    url = url.substring(7);
                }
                inputStream = new FileInputStream(url);
            }
        }
        catch (IOException e) {
            e.printStackTrace();
            return null;
        }

        String temp = "tmp_" + random.nextInt();
        String path = appPath + temp + "/";

        File fmd = new File(path);
        fmd.mkdirs();

        if (unpackZip(inputStream, path)) {
            String manifest = path + "manifest.json";
            InputStream file = null;
            try {
                file = new FileInputStream(manifest);
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            }
            info = parseManifest(file);
            File from = new File(appPath, temp);
            if (info == null || info.app_id == null || info.app_id.equals("launcher")
                    || appManager.getAppInfo(info.app_id) != null) {
                deleteAllFiles(from);
                deleteDAppPackage(downloadPkgPath);
                return null;
            }
            else {
                File to = new File(appPath, info.app_id);
                if (to.exists()) {
                    deleteAllFiles(to);
                    to = new File(appPath, info.app_id);
                }
                from.renameTo(to);
                info.built_in = 0;
                dbAdapter.addAppInfo(info);
                deleteDAppPackage(downloadPkgPath);
                return info;
            }
        }
        deleteDAppPackage(downloadPkgPath);
        return null;
    }

    private boolean deleteAllFiles(File root) {
        if (!root.exists()) {
            return false;
        }

        File files[] = root.listFiles();
        if (files != null) {
            for (File f : files) {
                if (f.isFile() && f.exists()) {
                    try {
                        f.delete();
                    } catch (Exception e) {
                        return false;
                    }
                }
                else {
                    deleteAllFiles(f);
                }
            }
        }

        try {
            root.delete();
        }
        catch (Exception e) {
            return false;
        }
        return true;
    }

    public boolean unInstall(AppInfo info) {
        if (info == null || info.built_in == 1) {
            return false;
        }
        int count = dbAdapter.removeAppInfo(info);
        if (count > 0) {
            File root = new File(appPath + info.app_id);
            deleteAllFiles(root);
            root = new File(dataPath + info.app_id);
            deleteAllFiles(root);
            return true;
        }
        return false;
    }

    private boolean isAllowPlugin(String name) {
        String pluginName = name.toLowerCase();
        for (String item : pluginWhitelist) {
            if (item.equals(pluginName)) {
                return true;
            }
        }
        return false;
    }

    private boolean isAllowUrl(String url) {
        url = url.toLowerCase();
        for (String item : urlWhitelist) {
            if (item.equals(url)) {
                return true;
            }
        }
        return false;
    }

    public AppInfo parseManifest(InputStream inputStream) {
        AppInfo appInfo = new AppInfo();
        try {
            InputStreamReader inputStreamReader = new InputStreamReader(inputStream,"UTF-8");
            BufferedReader bufReader = new BufferedReader(inputStreamReader);
            String line;
            StringBuilder builder = new StringBuilder();
            while((line = bufReader.readLine()) != null){
                builder.append(line);
            }
            bufReader.close();
            inputStreamReader.close();

            JSONObject json = new JSONObject(builder.toString());
            appInfo.app_id = json.getString("id");
            appInfo.version = json.getString(AppInfo.VERSION);
            appInfo.name = json.getString(AppInfo.NAME);
            appInfo.short_name = json.getString(AppInfo.SHORT_NAME);
            appInfo.description = json.getString(AppInfo.DESCRIPTION);
            appInfo.start_url = json.getString(AppInfo.START_URL);

            JSONArray array = json.getJSONArray("icons");
            for (int i = 0; i < array.length(); i++) {
                JSONObject icon = array.getJSONObject(i);
                String src = icon.getString(AppInfo.SRC);
                String sizes = icon.getString(AppInfo.SIZES);
                String type = icon.getString(AppInfo.TYPE);
                appInfo.addIcon(src, sizes, type);
            }

            appInfo.default_locale = json.getString(AppInfo.DEFAULT_LOCAL);
            JSONObject author = json.getJSONObject("author");
            appInfo.author_name = author.getString("name");
            appInfo.author_email = author.getString("email");

            array = json.getJSONArray("plugins");
            for (int i = 0; i < array.length(); i++) {
                String plugin = array.getString(i);
                int authority = AppInfo.AUTHORITY_NOINIT;
                if (isAllowPlugin(plugin)) {
                    authority = AppInfo.AUTHORITY_ALLOW;
                }
                appInfo.addPlugin(plugin, authority);
            }

            array = json.getJSONArray("urls");
            for (int i = 0; i < array.length(); i++) {
                String url = array.getString(i);
                int authority = AppInfo.AUTHORITY_NOINIT;
                if (isAllowUrl(url)) {
                    authority = AppInfo.AUTHORITY_ALLOW;
                }
                appInfo.addUrl(url, authority);
            }

            appInfo.background_color = json.getString(AppInfo.BACKGROUND_COLOR);
            appInfo.theme_display = json.getString(AppInfo.THEME_DISPLAY);
            appInfo.theme_color = json.getString(AppInfo.THEME_COLOR);

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

        return appInfo;
    }
}
