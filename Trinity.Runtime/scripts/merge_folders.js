"use strict";

//
// This hook copies various resource files/folders
// from our version control system directories
// into the appropriate platform specific location
//

// CONFIGURE HERE
// configure all the files/directories to copy/merge.
// Key of object is the source file/directory,
// value is the destination location.
const android_folders_to_copy = [{
  "platform_res/android":
  "platforms/android"
}]
const android_files_to_copy = [{
  "platform_src/android/gradle.properties":
  "platforms/android/gradle.properties"
}]
const ios_folders_to_copy = [{
  "platform_res/ios":
  "platforms/ios"
}]
// no need to configure below

const fs = require('fs'),
      path = require('path');

function copyFileSync(source, target) {
  let targetFile = target;

  //if target is a directory a new file with the same name will be created
  if (fs.existsSync(target)) {
    if (fs.lstatSync(target).isDirectory()) {
      targetFile = path.join(target, path.basename(source));
    }
  }

  // console.log("copyFileSync: Copying " + source + " to " + targetFile);
  fs.copyFileSync(source, targetFile);
}

function copyFolderRecursiveSync(source, target) {
  let files = [];

  //check if folder needs to be created or integrated
  let targetFolder = path.join(target, path.basename(source));
  if (!fs.existsSync(targetFolder)) {
    // console.log("copyFolderRecursiveSync: Making " + targetFolder);
    fs.mkdirSync(targetFolder);
  }

  //copy
  if (fs.lstatSync(source).isDirectory()) {
    files = fs.readdirSync(source);
    files.forEach(function(file) {
      let curSource = path.join(source, file);
      if ( fs.lstatSync(curSource).isDirectory() ) {
        copyFolderRecursiveSync(curSource, targetFolder);
      } else {
        copyFileSync(curSource, targetFolder);
      }
    });
  }
}

module.exports = function(ctx) {
  // console.log(JSON.stringify(ctx, null, 2));

  let folders_to_copy = []
  let files_to_copy = []
  if (ctx.opts.platforms.some((val) => val.startsWith("ios"))) {
    folders_to_copy = folders_to_copy.concat(ios_folders_to_copy);
  }
  if (ctx.opts.platforms.some((val) => val.startsWith("android"))) {
    folders_to_copy = folders_to_copy.concat(android_folders_to_copy);
    files_to_copy = files_to_copy.concat(android_files_to_copy);
  }

  folders_to_copy.forEach(function(obj) {
    Object.keys(obj).forEach(function(key) {
      let val = obj[key];

      let srcfile = path.join(ctx.opts.projectRoot, key);
      let destfile = path.join(ctx.opts.projectRoot, val);

      console.log("Merging folder " + key + " to " + val);
      let destdir = path.dirname(destfile);

      copyFolderRecursiveSync(srcfile, destdir);
    });
  });

  files_to_copy.forEach(function(obj) {
    Object.keys(obj).forEach(function(key) {
      let val = obj[key];

      let srcfile = path.join(ctx.opts.projectRoot, key);
      let destfile = path.join(ctx.opts.projectRoot, val);

      console.log("Merging file " + key + " to " + val);
      copyFileSync(srcfile, destfile);
    });
  });
};
