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

import android.util.Xml;

import org.apache.cordova.CordovaPreferences;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;

public class AppXmlParser{

    private static String TAG = "AppXmlParser";
    private AppInfo appInfo;

    private CordovaPreferences prefs = new CordovaPreferences();

    public void parse(XmlPullParser xml) {
        int eventType = -1;

        while (eventType != XmlPullParser.END_DOCUMENT) {
            try {
                if (eventType == XmlPullParser.START_TAG) {
                    handleStartTag(xml);
                } else if (eventType == XmlPullParser.END_TAG) {
                    handleEndTag(xml);
                }
                eventType = xml.next();
            } catch (XmlPullParserException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }



    public AppInfo parse(InputStream inputStream) {
        appInfo = new AppInfo();
        try {
            XmlPullParser xmlPullParser = Xml.newPullParser();
            xmlPullParser.setInput(inputStream, "utf-8");
            parse(xmlPullParser);
//            inputStream.close();
        } catch (XmlPullParserException e) {
            e.printStackTrace();
        }
        return appInfo;
    }

    public AppInfo parse(String path) {
        String manifest = path + "/manifest.xml";
        InputStream inputStream = null;
        try {
            inputStream = new FileInputStream(manifest);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        return parse(inputStream);
    }

    boolean pluginFeature = false;
    boolean urlFeature = false;
    boolean iconFeature = false;
    String plugin = "";
    String access = "";
    public void handleStartTag(XmlPullParser xml) throws IOException, XmlPullParserException {
        String strNode = xml.getName();
        if (strNode.equals("dapp")) {
            appInfo.app_id = xml.getAttributeValue(null, "id");
            appInfo.version = xml.getAttributeValue(null, "version");
        }
        else if (strNode.equals("plugins")) {
            pluginFeature = true;
        }
        else if (pluginFeature && strNode.equals("plugin")) {
            plugin = xml.getAttributeValue(null, "name");
            appInfo.addPlugin(plugin, AppInfo.AUTHORITY_NOINIT);
        }
        else if (strNode.equals("urls")) {
            urlFeature = true;
        }
        else if (urlFeature && strNode.equals("access")) {
            access = xml.getAttributeValue(null, "href");
            appInfo.addUrl(access, AppInfo.AUTHORITY_NOINIT);
        }
        else if (strNode.equals("icons")) {
            iconFeature = true;
        }
        else if (iconFeature && strNode.equals("big")) {
            appInfo.big_icon = xml.nextText();
        }
        else if (iconFeature && strNode.equals("small")) {
            appInfo.small_icon = xml.nextText();
        }
        else if (strNode.equals("name")) {
            appInfo.name = xml.nextText();
        }
        else if (strNode.equals("description")) {
            appInfo.description = xml.nextText();
        }
        else if (strNode.equals("launch_path")) {
            appInfo.launch_path = xml.nextText();
        }
        else if (strNode.equals("default_locale")) {
            appInfo.default_locale = xml.nextText();
        }
        else if (strNode.equals("author")) {
            appInfo.author_name = xml.getAttributeValue(null, "name");
            appInfo.author_email = xml.getAttributeValue(null, "email");
        }
    }

    public void handleEndTag(XmlPullParser xml) {
        String strNode = xml.getName();
        if (strNode.equals("plugins")) {
            plugin = "";
            pluginFeature = false;
        }
        else if (strNode.equals("urls")) {
            access = "";
            urlFeature = false;
        }
        else if (strNode.equals("icons")) {
            iconFeature = false;
        }
    }



//    private void setAppUrl(String src) {
//        Pattern schemeRegex = Pattern.compile("^[a-z-]+://");
//        Matcher matcher = schemeRegex.matcher(src);
//        if (matcher.find()) {
//            appUrl = src;
//        } else {
//            if (src.charAt(0) == '/') {
//                src = src.substring(1);
//            }
//            appUrl = "file:///android_asset/www/" + name + "/" + src;
//        }
//    }
}
