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
      "platforms/ios/Trinity/Classes/AppDelegate.h",
      "platforms/ios/Trinity/Classes/AppDelegate.m",
      "platforms/ios/Trinity/Classes/MainViewController.h",
      "platforms/ios/Trinity/Classes/MainViewController.m",
      "platforms/ios/SQLite.swift-0.11.5/SQLite.xcodeproj/xcshareddata/xcschemes/SQLite Mac.xcscheme",
      "platforms/ios/SQLite.swift-0.11.5/SQLite.xcodeproj/xcshareddata/xcschemes/SQLite iOS.xcscheme",
      "platforms/ios/SQLite.swift-0.11.5/SQLite.xcodeproj/xcshareddata/xcschemes/SQLite watchOS.xcscheme",
      "platforms/ios/SQLite.swift-0.11.5/SQLite.xcodeproj/xcshareddata/xcschemes/SQLite tvOS.xcscheme"
    ]
  },
]
// no need to configure below

module.exports = function(ctx) {
  // console.log(JSON.stringify(ctx, null, 2));

  const fs = require('fs'),
        path = require('path');

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
