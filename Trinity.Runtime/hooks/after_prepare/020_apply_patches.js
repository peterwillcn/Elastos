#!/usr/bin/env node
"use strict";

const fs = require('fs');
const path = require('path');

const patchDir = path.join(__dirname, "patches");
const diff = require("diff");

const base_dir = "platforms";
const patch_strip_num = 1;

if (fs.existsSync(patchDir) && fs.lstatSync(patchDir).isDirectory()) {
  let files = fs.readdirSync(patchDir);
  files.forEach(function(file) {
    let patchFile = path.join(patchDir, file);
    if (fs.existsSync(patchFile) && fs.lstatSync(patchFile).isFile()
        && path.extname(patchFile) == ".patch") {
      console.log("Applying patch " + file);
      let patchStr = fs.readFileSync(patchFile, "utf8");

      // Remove the diff header for each chunks
      patchStr = patchStr.replace(/^diff .*\n(--- .*\n\+\+\+ .*\n@@[^@]+@@)/gm, "Index: \n$1");

      let uniDiffArray = diff.parsePatch(patchStr)
      diff.applyPatches(uniDiffArray, {
        loadFile: (uniDiff, callback) => {
          let pathComponents = uniDiff.oldFileName.split('/');
          let originFilePath = base_dir;
          for (let i = patch_strip_num; i < pathComponents.length; i++) {
            originFilePath = path.join(originFilePath, pathComponents[i]);
          }
          if (fs.existsSync(originFilePath)
              && fs.lstatSync(originFilePath).isFile()) {
            let originStr = fs.readFileSync(originFilePath, "utf8");
            callback(null, originStr);
          }
          else {
            console.log("Failed to open file " + originFilePath);
          }
        },
        patched: (uniDiff, patchedStr, callback) => {
          let pathComponents = uniDiff.oldFileName.split('/');
          let originFilePath = base_dir;
          for (let i = patch_strip_num; i < pathComponents.length; i++) {
            originFilePath = path.join(originFilePath, pathComponents[i]);
          }
          if (fs.existsSync(originFilePath) && fs.lstatSync(patchFile).isFile()) {
            if (patchedStr) {
              console.log("Patched file " + originFilePath);
              fs.writeFileSync(originFilePath, patchedStr);
            }
            else {
              console.log("Failed to patch file " + originFilePath);
            }
            // Ignore any patch error, continue to proceed the next patch.
            callback();
          }
          else {
            callback("Failed to open file " + originFilePath);
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
