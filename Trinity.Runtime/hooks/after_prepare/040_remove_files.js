#!/usr/bin/env node
"use strict";

// CONFIGURE HERE
var files_to_remove = [
    "platforms/android/app/src/main/java/org/elastos/trinity/runtime/MainActivity.java",
    "platforms/ios/Runtime/Classes/AppDelegate.h",
    "platforms/ios/Runtime/Classes/AppDelegate.m",
    "platforms/ios/Runtime/Classes/MainViewController.h",
    "platforms/ios/Runtime/Classes/MainViewController.m"
]
// no need to configure below

const fs = require('fs'),
      path = require('path');

let rootdir = process.argv[2];

for (const file of files_to_remove) {
    let filePath = path.join(rootdir, file);
    if (fs.existsSync(filePath) && fs.lstatSync(filePath).isFile()) {
        console.log("Removing " + file);
        fs.unlinkSync(filePath);
    }
}