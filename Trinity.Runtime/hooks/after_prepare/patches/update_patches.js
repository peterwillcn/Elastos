#!/usr/bin/env node
"use strict";

const fs = require('fs');
const path = require('path');
const diff = require("diff");

const patchDir = __dirname;
const rootdir = path.join(patchDir, "..", "..", "..");

// CONFIGURE HERE
var patches_to_update  = [
{
  "patch_file": "001_android_build_gradle.patch",
  "source_files": [
    "platforms/android/CordovaLib/build.gradle",
    "platforms/android/app/build.gradle",
    "platforms/android/elastos-trinity-plugins-qrscanner/runtime-qrscanner.gradle",
    "platforms/android/build.gradle",
  ]
},
{
  "patch_file": "002_android_manifest.patch",
  "source_files": [
    "platforms/android/CordovaLib/AndroidManifest.xml",
    "platforms/android/app/src/main/AndroidManifest.xml",
  ]
},
{
  "patch_file": "003_android_sources.patch",
  "source_files": [
    "platforms/android/CordovaLib/src/org/apache/cordova/PluginEntry.java",
    "platforms/android/CordovaLib/src/org/apache/cordova/Whitelist.java",
    "platforms/android/CordovaLib/src/org/apache/cordova/CordovaPlugin.java",
  ]
},
{
  "patch_file": "010_ios_cordova_lib.patch",
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
},
{
  "patch_file": "011_ios_info_plist.patch",
  "source_files": [
    "platforms/ios/Elastos/Elastos-Info.plist",
  ]
},
{
  "patch_file": "012_ios_qrscanner.patch",
  "source_files": [
    "platforms/ios/Elastos/Plugins/elastos-trinity-plugins-qrscanner/QRScanner.swift",
  ]
}]
// no need to configure below

patches_to_update.forEach(function(obj) {
  let patchPath = path.join(patchDir, obj.patch_file);
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
  console.log("Updated patch file " + obj.patch_file);
});
