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
const types_folders_to_copy = [{
  "scripts/types/cordova-clipboard":
  "plugins/cordova-clipboard"
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

  types_folders_to_copy.forEach(function(obj) {
    Object.keys(obj).forEach(function(key) {
      let val = obj[key];

      let srcfile = path.join(ctx.opts.projectRoot, key);
      let destfile = path.join(ctx.opts.projectRoot, val);

      console.log("Merging folder " + key + " to " + val);
      let destdir = path.dirname(destfile);

      copyFolderRecursiveSync(srcfile, destdir);
    });
  });
};
