#!/usr/bin/env node

// this plugin replaces arbitrary text in arbitrary files
//

// CONFIGURE HERE
// with the names of the files that contain tokens you want replaced.
// Replace files that have been copied via the prepare step.
var config_objs = [{
    files_to_replace: [
        "platforms/android/CordovaLib/src/org/apache/cordova/Whitelist.java"
    ],
    search_string: "private static class URLPattern {",
    replace_with:  "protected static class URLPattern {"
}, {
    files_to_replace: [
        "platforms/android/CordovaLib/src/org/apache/cordova/PluginEntry.java"
    ],
    search_string: "private PluginEntry\\(String service, String pluginClass, boolean onload, CordovaPlugin plugin\\) {",
    replace_with:  "public PluginEntry(String service, String pluginClass, boolean onload, CordovaPlugin plugin) {"
}, {
    files_to_replace: [
        "platforms/android/app/build.gradle",
        "platforms/android/build.gradle",
        "platforms/android/CordovaLib/build.gradle",
    ],
    search_string: "com.android.tools.build:gradle:3.0.1",
    replace_with:  "com.android.tools.build:gradle:3.2.1"
}, {
    files_to_replace: [
        "platforms/android/app/build.gradle",
        "platforms/android/build.gradle",
        "platforms/android/CordovaLib/build.gradle",
    ],
    search_string: "buildscript {\n" +
                   "    repositories {\n" +
                   "(        (?!google))",
    replace_with:  "buildscript {\n" +
                   "    repositories {\n" +
                   "        google()\n$1",
}, {
    files_to_replace: [
        "platforms/android/app/src/main/AndroidManifest.xml",
        "platforms/android/CordovaLib/AndroidManifest.xml"
    ],
    search_string: "    <uses-sdk android:minSdkVersion=\"19\".* />\n",
    replace_with:  "",
}, {
    files_to_replace: [
        "platforms/android/app/build.gradle",
    ],
    search_string: "        if \\(cdvMinSdkVersion != null\\) {\n" +
                   "            minSdkVersion cdvMinSdkVersion\n" +
                   "        }\n",
    replace_with:  "        if (cdvMinSdkVersion != null) {\n" +
                   "            minSdkVersion cdvMinSdkVersion\n" +
                   "        } else {\n" +
                   "            minSdkVersion 19\n" +
                   "        }\n",
}, {
    files_to_replace: [
        "platforms/android/app/build.gradle",
    ],
    search_string: "    // SUB-PROJECT DEPENDENCIES END\n}",
    replace_with:  "    // SUB-PROJECT DEPENDENCIES END\n" +
                   "    implementation 'com.android.support:support-v4:27.1.1'\n}"
}];
// no need to configure below

var fs = require('fs');
var path = require('path');

var rootdir = process.argv[2];

function replace_string_in_file(filename, to_replace, replace_with) {
    var data = fs.readFileSync(filename, 'utf8');

    var result = data.replace(new RegExp(to_replace, "g"), replace_with);
    fs.writeFileSync(filename, result, 'utf8');
}

if (rootdir) {
    config_objs.forEach(function(config, index, array) {
        var files_to_replace = config["files_to_replace"];
        var search_string    = config["search_string"];
        var replace_with     = config["replace_with"];
        // console.log("files to replace: " + files_to_replace);
        files_to_replace.forEach(function(val, index, array) {
            var fullfilename  = path.join(rootdir, val);
            if (fs.existsSync(fullfilename)) {
                // console.log("replacing in " + fullfilename);
                replace_string_in_file(fullfilename, search_string, replace_with);
            } else {
                // console.log("missing: " + fullfilename);
            }
        });
    });
}
