#!/usr/bin/env node
"use strict";

const fs = require('fs'),
      path = require('path'),
      diff = require("diff");

const patchDir = __dirname;
const rootdir = path.join(patchDir, "..", "..");

// CONFIGURE HERE
const patches_to_update  = [
  "after_platform_add_android",
  "after_platform_add_ios",
]

const configure_patches = {
  "after_platform_add_android": [
    {
      "patch_file": "prepare.patch",
      "source_files": [
        "platforms/android/cordova/lib/prepare.js",
      ]
    },
    {
      "patch_file": "cordova_builder.patch",
      "source_files": [
        "platforms/android/cordova/lib/builders/GradleBuilder.js",
        "platforms/android/cordova/lib/builders/StudioBuilder.js",
      ]
    },
// Some plugins may change the origin file after the "after_platform_add" hook.
// So you may want to remove all of the plugins before run this script to
// update the following patch files.
//    {
//      "patch_file": "build_gradle.patch",
//      "source_files": [
//        "platforms/android/CordovaLib/build.gradle",
//        "platforms/android/app/build.gradle",
//        "platforms/android/build.gradle",
//      ]
//    },
//    {
//      "patch_file": "manifest.patch",
//      "source_files": [
//        "platforms/android/CordovaLib/AndroidManifest.xml",
//        "platforms/android/app/src/main/AndroidManifest.xml",
//      ]
//    },
    {
      "patch_file": "java_files.patch",
      "source_files": [
        "platforms/android/CordovaLib/src/org/apache/cordova/PluginEntry.java",
        "platforms/android/CordovaLib/src/org/apache/cordova/Whitelist.java",
        "platforms/android/CordovaLib/src/org/apache/cordova/CordovaPlugin.java",
      ]
    }
  ],
  "after_platform_add_ios": [
// Some plugins may change the origin file after the "after_platform_add" hook.
// So you may want to remove all of the plugins before run this script to
// update the following patch files.
//    {
//      "patch_file": "info_plist.patch",
//      "source_files": [
//        "platforms/ios/Elastos/Elastos-Info.plist",
//      ]
//    },
    {
      "patch_file": "objc_files.patch",
      "source_files": [
        "platforms/ios/CordovaLib/Classes/Private/Plugins/CDVIntentAndNavigationFilter/CDVIntentAndNavigationFilter.h",
        "platforms/ios/CordovaLib/Classes/Private/Plugins/CDVIntentAndNavigationFilter/CDVIntentAndNavigationFilter.m",
        "platforms/ios/CordovaLib/Classes/Public/CDV.h",
        "platforms/ios/CordovaLib/Classes/Public/CDVCommandQueue.m",
        "platforms/ios/CordovaLib/Classes/Public/CDVViewController.h",
        "platforms/ios/CordovaLib/Classes/Public/CDVViewController.m",
        "platforms/ios/CordovaLib/Classes/Public/CDVWhitelist.h",
        "platforms/ios/CordovaLib/Classes/Public/CDVWhitelist.m",
        "platforms/ios/Elastos/Bridging-Header.h",
      ]
    }
  ]
}
// no need to configure below

patches_to_update.forEach(function(config_obj) {
  configure_patches[config_obj].forEach(function(obj) {
    let patchPath = path.join(patchDir, config_obj, obj.patch_file);
    let patchStr = "";
    for (const srcFile of obj.source_files) {
      let oldFileName = "origin_" + srcFile;
      let newFileName = srcFile;
      let oldFilePath = path.join(rootdir, oldFileName.split('/').join(path.sep));
      if (!fs.existsSync(oldFilePath) || !fs.lstatSync(oldFilePath).isFile()) {
        console.log("Failed to open file " + oldFilePath);
        process.exit(1)
      }
      let newFilePath = path.join(rootdir, newFileName.split('/').join(path.sep));
      if (!fs.existsSync(newFilePath) || !fs.lstatSync(newFilePath).isFile()) {
        console.log("Failed to open file " + newFilePath);
        process.exit(1)
      }
      let oldStr = fs.readFileSync(oldFilePath, "utf8");
      let newStr = fs.readFileSync(newFilePath, "utf8");
      patchStr += diff.createTwoFilesPatch(oldFileName, newFileName, oldStr, newStr, null, null, { context: 3 });
    }
    fs.writeFileSync(patchPath, patchStr);
    console.log("Updated patch file " + config_obj + "/" + obj.patch_file);
  });
});
