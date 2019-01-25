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

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import org.apache.cordova.ConfigXmlParser;
import org.apache.cordova.CordovaInterfaceImpl;
import org.apache.cordova.PluginEntry;
import org.elastos.trinity.plugins.appmanager.AppManagerPlugin;

import java.util.ArrayList;

public class LauncherViewFragment extends WebViewFragment {
    static ArrayList<PluginEntry> allPluginEntries;

    public static WebViewFragment newInstance() {
        LauncherViewFragment fragment = new LauncherViewFragment();
        return fragment;
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
//        View view = super.onCreateView(inflater, container, savedInstanceState);

        cordovaInterface =  new CordovaInterfaceImpl(getActivity());
        if(savedInstanceState != null) {
            cordovaInterface.restoreInstanceState(savedInstanceState);
        }

        id = "launcher";

//        super.onActivityCreated(savedInstanceState);
//        // Restore State Here
//        if (!restoreStateFromArguments()) {
//            // First Time running, Initialize something here
//        }

        loadConfig();

        init();

        // If keepRunning
        this.keepRunning = preferences.getBoolean("KeepRunning", true);

        appView.loadUrlIntoView(launchUrl, true);

        LauncherViewFragment.allPluginEntries = pluginEntries;
        return appView.getView();
    }

    protected void loadConfig() {
        ConfigXmlParser parser = new ConfigXmlParser();
        parser.parse(getActivity());
        preferences = parser.getPreferences();
        preferences.setPreferencesBundle(getActivity().getIntent().getExtras());
        launchUrl = parser.getLaunchUrl();
        ArrayList<PluginEntry> entries = parser.getPluginEntries();
        cfgPreferences = preferences;
//        cfgPluginEntries = pluginEntries;
        cfgPluginEntries = new ArrayList<PluginEntry>();
        pluginEntries = new ArrayList<PluginEntry>();

        for(PluginEntry entry:entries) {
            if (entry.service.equals("AppManager")) {
                basePlugin = new AppManagerPlugin();
                pluginEntries.add(new PluginEntry(entry.service, entry.pluginClass, true, basePlugin));
            }
            else if (entry.service.equals("AppService")) {
                cfgPluginEntries.add(entry);
            }
            else {
                pluginEntries.add(entry);
                cfgPluginEntries.add(entry);
            }
        }
//        Config.parser = parser;
    }

    @Override
    public Object onMessage(String id, Object data) {
        if ("exit".equals(id)) {
            getActivity().finish();
        }
        return null;
    }
}
