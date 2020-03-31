"use strict";

// CONFIGURE HERE
var files_to_remove = [
  {
    "hook": "after_platform_add",
    "platform": "android",
    "files": [
      "platforms/android/app/src/main/java/org/elastos/trinity/runtime/MainActivity.java",
    ]
  },
  {
    "hook": "after_platform_add",
    "platform": "ios",
    "files": [
      "platforms/ios/elastOS/Classes/AppDelegate.h",
      "platforms/ios/elastOS/Classes/AppDelegate.m",
      "platforms/ios/elastOS/Classes/MainViewController.h",
      "platforms/ios/elastOS/Classes/MainViewController.m",
      "platforms/ios/SQLite.swift-0.11.5/SQLite.xcodeproj/xcshareddata/xcschemes/SQLite Mac.xcscheme",
      "platforms/ios/SQLite.swift-0.11.5/SQLite.xcodeproj/xcshareddata/xcschemes/SQLite iOS.xcscheme",
      "platforms/ios/SQLite.swift-0.11.5/SQLite.xcodeproj/xcshareddata/xcschemes/SQLite watchOS.xcscheme",
      "platforms/ios/SQLite.swift-0.11.5/SQLite.xcodeproj/xcshareddata/xcschemes/SQLite tvOS.xcscheme"
    ]
  },
]

// TODO:why cordova generate xxxxdpi-v26?
var folders_to_remove = [
  {
    "hook": "after_prepare",
    "platform": "android",
    "folders": [
      "platforms/android/app/src/main/res/mipmap-hdpi-v26",
      "platforms/android/app/src/main/res/mipmap-ldpi-v26",
      "platforms/android/app/src/main/res/mipmap-mdpi-v26",
      "platforms/android/app/src/main/res/mipmap-xhdpi-v26",
      "platforms/android/app/src/main/res/mipmap-xxhdpi-v26",
      "platforms/android/app/src/main/res/mipmap-xxxhdpi-v26",
    ]
  }
]
// no need to configure below

const fs = require('fs'),
      path = require('path');

function DeleteDirectory(dir) {
  if (fs.existsSync(dir) == true) {
    var files = fs.readdirSync(dir);
    files.forEach(function(item){
      var item_path = path.join(dir, item);
      if (fs.statSync(item_path).isDirectory()) {
        DeleteDirectory(item_path);
      }
      else {
        fs.unlinkSync(item_path);
      }
    });
    fs.rmdirSync(dir);
  }
}

module.exports = function(ctx) {
  // console.log(JSON.stringify(ctx, null, 2));

  files_to_remove.forEach((obj) => {
    if (obj.hook !== ctx.hook) {
      return;
    }
    if (ctx.opts.platforms && obj.platform &&
        !ctx.opts.platforms.some((val) => val.startsWith(obj.platform))) {
      return;
    }
    if (obj.plugin_id && ctx.opts.cordova && ctx.opts.cordova.platforms && obj.platform &&
        !ctx.opts.cordova.platforms.includes(obj.platform)) {
      return;
    }
    if (obj.plugin_id && ctx.opts.plugin && ctx.opts.plugin.id &&
        obj.plugin_id !== ctx.opts.plugin.id) {
      return;
    }

    obj.files.forEach((file) => {
      let filePath = path.join(ctx.opts.projectRoot, file);
      if (fs.existsSync(filePath) && fs.lstatSync(filePath).isFile()) {
        console.log("Removing file", file);
        fs.unlinkSync(filePath);
      }
    });
  });

  folders_to_remove.forEach((obj) => {
    if (obj.hook !== ctx.hook) {
      return;
    }
    if (ctx.opts.platforms && obj.platform &&
        !ctx.opts.platforms.some((val) => val.startsWith(obj.platform))) {
      return;
    }
    if (obj.plugin_id && ctx.opts.cordova && ctx.opts.cordova.platforms && obj.platform &&
        !ctx.opts.cordova.platforms.includes(obj.platform)) {
      return;
    }
    if (obj.plugin_id && ctx.opts.plugin && ctx.opts.plugin.id &&
        obj.plugin_id !== ctx.opts.plugin.id) {
      return;
    }

    obj.folders.forEach((folder) => {
      let filePath = path.join(ctx.opts.projectRoot, folder);
      console.log("Removing folder", folder);
      DeleteDirectory(folder);
    });
  });
}


// const fs = require('fs'),
//       path = require('path');
//
// let rootdir = process.argv[2];
//
// for (const file of files_to_remove) {
//     let filePath = path.join(rootdir, file);
//     if (process.env.CORDOVA_PLATFORMS
//         && !process.env.CORDOVA_PLATFORMS.includes('ios')
//         && file.startsWith("platforms/ios")) {
//         console.log("Skipped IOS platform file removing.");
//         return;
//       }
//     if (fs.existsSync(filePath) && fs.lstatSync(filePath).isFile()) {
//         console.log("Removing " + file);
//         fs.unlinkSync(filePath);
//     }
//     else {
//         console.log("File %s not existed.", file);
//         process.exit(1);
//     }
// }
