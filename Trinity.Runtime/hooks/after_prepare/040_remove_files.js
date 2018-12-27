#!/usr/bin/env node
"use strict";

// CONFIGURE HERE
var files_to_remove = [
    "platforms/android/app/src/main/java/org/elastos/trinity/runtime/MainActivity.java",
    "platforms/ios/Elastos/Classes/AppDelegate.h",
    "platforms/ios/Elastos/Classes/AppDelegate.m",
    "platforms/ios/Elastos/Classes/MainViewController.h",
    "platforms/ios/Elastos/Classes/MainViewController.m"
]
// no need to configure below

const fs = require('fs'),
      path = require('path');

let rootdir = process.argv[2];

for (const file of files_to_remove) {
    let filePath = path.join(rootdir, file);
    if (process.env.CORDOVA_PLATFORMS
        && !process.env.CORDOVA_PLATFORMS.includes('ios')
        && file.startsWith("platforms/ios")) {
        console.log("Skipped IOS platform file removing.");
        return;
      }
    if (fs.existsSync(filePath) && fs.lstatSync(filePath).isFile()) {
        console.log("Removing " + file);
        fs.unlinkSync(filePath);
    }
    else {
        console.log("File %s not existed.", file);
        process.exit(1);
    }
}