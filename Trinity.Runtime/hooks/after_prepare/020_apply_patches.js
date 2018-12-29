#!/usr/bin/env node
"use strict";

const fs = require('fs');
const path = require('path');

const patchDir = path.join(__dirname, "patches");
const diff = require("diff");

const rootdir = process.argv[2];

if (fs.existsSync(patchDir) && fs.lstatSync(patchDir).isDirectory()) {
  let files = fs.readdirSync(patchDir);
  files.forEach(function(file) {
    let patchFile = path.join(patchDir, file);
    if (fs.existsSync(patchFile) && fs.lstatSync(patchFile).isFile()
        && path.extname(patchFile) == ".patch") {
      let relativePatchFile = path.relative(rootdir, patchFile);
      console.log("Applying patch " + relativePatchFile);
      let patchStr = fs.readFileSync(patchFile, "utf8");

      // Remove the diff header for each chunks
      patchStr = patchStr.replace(/^diff .*\n(--- .*\n\+\+\+ .*\n@@[^@]+@@)/gm, "Index: \n$1");

      let uniDiffArray = diff.parsePatch(patchStr)
      diff.applyPatches(uniDiffArray, {
        loadFile: (uniDiff, callback) => {
          if (process.env.CORDOVA_PLATFORMS
            && !process.env.CORDOVA_PLATFORMS.includes('ios')
            && uniDiff.newFileName.startsWith("platforms/ios")) {
            console.log("Skipped IOS platform file patching.");
            return;
          }

          let oldFilePath = uniDiff.oldFileName.split('/').join(path.sep);
          let newFilePath = uniDiff.newFileName.split('/').join(path.sep);
          if (!fs.existsSync(oldFilePath)) {
            if (fs.existsSync(newFilePath)
                && fs.lstatSync(newFilePath).isFile()) {
              console.log("Backup origin file to " + oldFilePath);
              fs.copyFileSync(newFilePath, oldFilePath);
            }
            else {
              callback("Failed to open file " + newFilePath);
            }
          }

          if (fs.existsSync(oldFilePath)
              && fs.lstatSync(oldFilePath).isFile()) {
            console.log("Patching file from " + oldFilePath);
            let originStr = fs.readFileSync(oldFilePath, "utf8");
            callback(null, originStr);
          }
          else {
            callback("Failed to open file " + oldFilePath);
          }
        },
        patched: (uniDiff, patchedStr, callback) => {
          let newFilePath = uniDiff.newFileName.split('/').join(path.sep);
          if (patchedStr) {
            console.log("Patched file " + newFilePath);
            fs.writeFileSync(newFilePath, patchedStr);
            callback();
          }
          else {
            callback("Failed to patch file " + newFilePath);
          }
        },
        complete: (err) => {
          if (err) {
            console.log(err);
            process.exit(1);
          }
        }
      })
    }
  });
}
