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

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Random;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

public class AppInstaller {
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

        File destDir = new File(appPath);
        if (!destDir.exists()) {
            destDir.mkdirs();
        }
        destDir = new File(dataPath);
        if (!destDir.exists()) {
            destDir.mkdirs();
        }


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

    private String resetPath(String filePath, String original) {
        if (!original.startsWith("http://") && !original.startsWith("https://")
                && !original.startsWith("file:///")) {
            original = filePath + original;
        }
        return original;
    }
    private void resetPaths(AppInfo info) {
        String path = "file:///" + appPath + info.app_id + "/";
        info.big_icon = resetPath(path, info.big_icon);
        info.small_icon = resetPath(path, info.small_icon);
        info.launch_path = resetPath(path, info.launch_path);
    }

    public AppInfo install(AppManager appManager, String url)  {
        InputStream inputStream;
        AppInfo info = null;

        if (url.startsWith("assets://")) {
            AssetManager manager = context.getAssets();
            String substr = url.substring(9);
            try {
                inputStream = manager.open(substr);
            } catch (IOException e) {
                e.printStackTrace();
                return null;
            }
        }
        else {
            try {
                inputStream = new FileInputStream(url);
            } catch (FileNotFoundException e) {
                e.printStackTrace();
                return null;
            }
        }

        String temp = "tmp_" + random.nextInt();
        String path = appPath + temp + "/";

        File fmd = new File(path);
        fmd.mkdirs();

        if (unpackZip(inputStream, path)) {
            AppXmlParser parser = new AppXmlParser();
            info = parser.parse(path);
            File from = new File(appPath, temp);
            if (info == null || info.app_id == null || info.app_id.equals("launcher")
                    || appManager.getAppInfo(info.app_id) != null) {
                deleteAllFiles(from);
                return null;
            }
            else {
                File to = new File(appPath, info.app_id);
                if (to.exists()) {
                    deleteAllFiles(to);
                    to = new File(appPath, info.app_id);
                }
                from.renameTo(to);
                resetPaths(info);
                info.is_fixed = 0;
                dbAdapter.addAppInfo(info);
                return info;
            }
        }
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
        if (info == null || info.is_fixed == 1) {
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
}
