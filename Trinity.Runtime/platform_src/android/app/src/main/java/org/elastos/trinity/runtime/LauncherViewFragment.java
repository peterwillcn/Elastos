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

import android.media.AudioManager;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import org.apache.cordova.ConfigXmlParser;
import org.apache.cordova.LOG;
import org.apache.cordova.PluginEntry;

import java.util.ArrayList;
import java.util.Locale;

 public class LauncherViewFragment extends WebViewFragment {
    public static String TAG = "LauncherViewFragment";

    static ArrayList<PluginEntry> allPluginEntries;

    @Override
    protected void loadConfig() {
        ConfigXmlParser parser = new ConfigXmlParser();
        parser.parse(getActivity());
        preferences = parser.getPreferences();
        preferences.setPreferencesBundle(getActivity().getIntent().getExtras());

        launchUrl = AppManager.getShareInstance().getStartPath(appInfo);

        ArrayList<PluginEntry> entries = parser.getPluginEntries();
        cfgPreferences = preferences;
        cfgPluginEntries = new ArrayList<PluginEntry>();
        pluginEntries = new ArrayList<PluginEntry>();

        for(PluginEntry entry:entries) {
            if (entry.service.equals("AppManager")) {
                basePlugin = new AppBasePlugin();
                pluginEntries.add(new PluginEntry(entry.service, entry.pluginClass, true, basePlugin));
            }
            else {
                pluginEntries.add(entry);
            }
            cfgPluginEntries.add(entry);
        }

        String logLevel = preferences.getString("loglevel", "ERROR");
        LOG.setLogLevel(logLevel);

        // Wire the hardware volume controls to control media if desired.
        String volumePref = preferences.getString("DefaultVolumeStream", "");
        if ("media".equals(volumePref.toLowerCase(Locale.ENGLISH))) {
            getActivity().setVolumeControlStream(AudioManager.STREAM_MUSIC);
        }

        if (LauncherViewFragment.allPluginEntries == null) {
            LauncherViewFragment.allPluginEntries = pluginEntries;
        }

//        Config.parser = parser;
    }

     @Override
     public boolean isLauncher() {
         return true;
     }

    @Override
    public Object onMessage(String id, Object data) {
        super.onMessage(id, data);

        if ("exit".equals(id)) {
            getActivity().finish();
        }
        return null;
    }
}
