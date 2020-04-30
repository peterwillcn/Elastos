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

 import android.graphics.drawable.Icon;

 import java.util.ArrayList;

 public class AppInfo {

     public static final String TID = "tid";
     public static final String APP_TID = "app_tid";
     public static final String APP_ID = "app_id";
     public static final String VERSION = "version";
     public static final String VERSION_CODE = "version_code";
     public static final String NAME = "name";
     public static final String SHORT_NAME = "short_name";
     public static final String DESCRIPTION = "description";
     public static final String START_URL = "start_url";
     public static final String AUTHOR_NAME = "author_name";
     public static final String AUTHOR_EMAIL = "author_email";
     public static final String DEFAULT_LOCAL = "default_locale";
     public static final String BACKGROUND_COLOR = "background_color";
     public static final String THEME_DISPLAY = "theme_display";
     public static final String THEME_COLOR = "theme_color";
     public static final String THEME_FONT_NAME = "theme_font_name";
     public static final String THEME_FONT_COLOR = "theme_font_color";
     public static final String INSTALL_TIME = "install_time";
     public static final String BUILT_IN = "built_in";
     public static final String REMOTE = "remote";
     public static final String CATEGORY = "category";
     public static final String KEY_WORDS = "key_words";
     public static final String LAUNCHER = "launcher";
     public static final String LANGUAGE = "language";
     public static final String ACTION = "act";
     public static final String START_VISIBLE = "start_visible";

     public static final String SRC = "src";
     public static final String SIZES = "sizes";
     public static final String TYPE = "type";


     public static final String PLUGIN = "plugin";
     public static final String URL = "url";
     public static final String API = "api";
     public static final String AUTHORITY = "authority";


     public static final int MSG_PARAMS = 0;
     public static final int MSG_RETURN = 1;
     public static final int MSG_URL_AUTHORITY = 2;
     public static final int MSG_PLUGIN_AUTHORITY = 3;

     public long tid;
     public String app_id;
     public String version;
     public int    version_code;
     public String name;
     public String short_name;
     public String description;
     public String start_url;
     public String type;
     public String author_name;
     public String author_email;
     public String default_locale;
     public String background_color;
     public String theme_display;
     public String theme_color;
     public String theme_font_name;
     public String theme_font_color;
     public long   install_time;
     public int    built_in;
     public int    remote;
     public int    launcher;
     public String category;
     public String key_words;
     public String start_visible;

     public static final int AUTHORITY_NOEXIST = -1;
     public static final int AUTHORITY_NOINIT = 0;
     public static final int AUTHORITY_ASK = 1;
     public static final int AUTHORITY_ALLOW = 2;
     public static final int AUTHORITY_DENY = 3;

     public class Locale {
         public String language = "";
         public String name = "";
         public String short_name = "";
         public String description = "";
         public String author_name = "";

         Locale(String language, String name, String short_name, String description, String author_name) {
             this.language = language;
             this.name = name;
             this.short_name = short_name;
             this.description = description;
             this.author_name = author_name;
         }
     }

     public class Icon {
         public String src = "";
         public String sizes = "";
         public String type = "";

         Icon(String src, String sizes, String type) {
             this.src = src;
             this.sizes = sizes;
             this.type = type;
         }
     }

     public class PluginAuth {
         public String plugin = "";
         public int authority = AUTHORITY_NOINIT;

         PluginAuth(String plugin, int authority) {
             this.plugin = plugin;
             this.authority = authority;
         }
     }

     public class UrlAuth {
         public String url;
         public int authority = AUTHORITY_NOINIT;

         UrlAuth(String url, int authority) {
             this.url = url;
             this.authority = authority;
         }
     }

     public class Framework {
         public String name;
         public String version;

         Framework(String name, String version) {
             this.name = name;
             this.version = version;
         }
     }
     public class Platform {
         public String name;
         public String version;

         Platform(String name, String version) {
             this.name = name;
             this.version = version;
         }
     }
     public class IntentFilter {
         public String action;

         IntentFilter(String action) {
             this.action = action;
         }
     }

     public ArrayList<Locale> locales = new ArrayList<Locale>(4);
     public ArrayList<Icon> icons = new ArrayList<Icon>(4);
     public ArrayList<PluginAuth> plugins = new ArrayList<PluginAuth>(4);
     public ArrayList<UrlAuth> urls = new ArrayList<UrlAuth>(4);
     public ArrayList<UrlAuth> intents = new ArrayList<UrlAuth>(4);
     public ArrayList<IntentFilter> intentFilters = new ArrayList<IntentFilter>(4);
     public ArrayList<Framework> frameworks = new ArrayList<Framework>(2);
     public ArrayList<Platform> platforms = new ArrayList<Platform>(2);


     public void addIcon(String src, String sizes, String type) {
         icons.add(new Icon(src, sizes, type));
     }

     public void addPlugin(String plugin, int authority) {
         plugins.add(new PluginAuth(plugin, authority));
     }

     public void addUrl(String url, int authority) {
         urls.add(new UrlAuth(url, authority));
     }

     public void addIntent(String url, int authority) {
         intents.add(new UrlAuth(url, authority));
     }

     public void addLocale(String language, String name, String short_name, String description, String author_name) {
         locales.add(new Locale(language, name, short_name, description, author_name));
     }

     public void addFramework(String name, String version) {
         frameworks.add(new Framework(name, version));
     }

     public void addPlatform(String name, String version) {
         platforms.add(new Platform(name, version));
     }

     public void addIntentFilter(String action) {
         intentFilters.add(new IntentFilter(action));
     }

     public Framework getFramework(String name) {
         for (Framework item: frameworks) {
             if (item.name.equals(name)) {
                 return item;
             }
         }
         return null;
     }

     public Platform getPlatform(String name) {
         for (Platform item: platforms) {
             if (item.name.equals(name)) {
                 return item;
             }
         }
         return null;
     }
 }
