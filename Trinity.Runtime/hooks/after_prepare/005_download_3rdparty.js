#!/usr/bin/env node
"use strict";

// CONFIGURE HERE
var files_to_download  = [{
  "url": "https://github.com/ZipArchive/ZipArchive/archive/v2.1.4.zip",
  "filename": "ZipArchive-2.1.4.zip",
  "sourceDirs": [
    "ZipArchive-2.1.4/SSZipArchive"
  ],
  "targetDir": "platforms/ios",
  "md5": "2ab5ae7e5eb096b1a807d17e4bd83a16"
},{
  "url": "https://github.com/realm/realm-cocoa/releases/download/v3.13.0/realm-swift-3.13.0.zip",
  "filename": "realm-swift-3.13.0.zip",
  "sourceDirs": [
    "realm-swift-3.13.0/ios/swift-4.2.1/RealmSwift.framework",
    "realm-swift-3.13.0/ios/swift-4.2.1/Realm.framework"
  ],
  "targetDir": "platforms/ios",
  "md5": "c91b3ec712d9014ae935255dae59d571"
}]
// no need to configure below

const fs = require('fs'),
      path = require('path'),
      wget = require('node-wget-promise'),
      readline = require('readline'),
      md5File = require('md5-file/promise'),
      yauzl = require("yauzl"),
      mkdirp = require("mkdirp");

const rootdir = process.argv[2];

(async () => {
  for (const obj of files_to_download) {
    let zipFilePath = path.join(__dirname, "cache", obj.filename)

    //
    // Check the md5 of the downloaded file
    //
    let fileMatched = fs.existsSync(zipFilePath)
                      && fs.lstatSync(zipFilePath).isFile()
                      && await md5File(zipFilePath) == obj.md5

    const max_attempt = 3;
    let attempt = 0;
    while (!fileMatched && attempt < max_attempt) {
      attempt++;

      console.log("Start to download file " + obj.filename);
      let unit = "bytes"
      await wget(obj.url, {
        onProgress: (status) => {
          let downloadedSizeInUnit = status.downloadedSize
          switch (unit) {
            case "bytes":
              if (status.downloadedSize > (1 << 10)) {
                  downloadedSizeInUnit /= (1 << 10)
                  unit = "KB"
              }
              break;
            case "KB":
              downloadedSizeInUnit /= (1 << 10)
              if (status.downloadedSize > (1 << 20)) {
                  downloadedSizeInUnit /= (1 << 10)
                  unit = "MB"
              }
              break;
            case "MB":
              downloadedSizeInUnit /= (1 << 20)
              if (status.downloadedSize > (1 << 30)) {
                  downloadedSizeInUnit /= (1 << 10)
                  unit = "GB"
              }
              break;
            default:
              downloadedSizeInUnit /= (1 << 30)
              break;
          }
          readline.clearLine(process.stdout, 0);
          process.stdout.write("Downloading " + downloadedSizeInUnit.toFixed(1)
                              + " " + unit);
          if (status.percentage) {
            process.stdout.write(" (" + (status.percentage * 100).toFixed(1) + "%)\r");
          }
          else {
            process.stdout.write("\r");
          }
        },
        output: zipFilePath
      });
      readline.clearLine(process.stdout, 0);
      console.log("Done");

      fileMatched = fs.existsSync(zipFilePath)
                    && fs.lstatSync(zipFilePath).isFile()
                    && await md5File(zipFilePath) == obj.md5
    }
    if (!fileMatched) {
      process.exit(1);
    }
    // Zip file matched md5
    console.log("File %s is ready!", obj.filename);
    if (fs.existsSync(rootdir) && fs.lstatSync(rootdir).isDirectory()) {
      let targetPath = path.join(rootdir, obj.targetDir);
      mkdirp.sync(targetPath);
      if (fs.existsSync(targetPath) && fs.lstatSync(targetPath).isDirectory()) {
        console.log("Unziping file %s", obj.filename);
        yauzl.open(zipFilePath, {lazyEntries: true}, function(err, zipfile) {
          if (err) throw err;
          zipfile.readEntry();
          zipfile.on("entry", function(entry) {
            if (/\/$/.test(entry.fileName)) {
              // Directory file names end with '/'.
              // Note that entires for directories themselves are optional.
              // An entry's fileName implicitly requires its parent directories to exist.
              zipfile.readEntry();
            } else {
              // file entry
              let openedReadStream = false;
              for (const srcDir of obj.sourceDirs) {
                let relativePath = path.relative(srcDir, entry.fileName);
                if (!relativePath.startsWith("..")) {
                  let baseName = path.basename(srcDir);
                  relativePath = path.join(baseName, relativePath);
                  let relativeDir = path.dirname(relativePath);
                  let outputDir = path.join(targetPath, relativeDir);
                  let outputPath = path.join(targetPath, relativePath);
                  mkdirp.sync(outputDir);
                  openedReadStream = true;
                  zipfile.openReadStream(entry, function(err, readStream) {
                    if (err) throw err;
                    readStream.on("end", function() {
                      zipfile.readEntry();
                    });
                    let writeStream = fs.createWriteStream(outputPath);
                    readStream.pipe(writeStream);
                  });
                }
              }

              if (!openedReadStream) {
                zipfile.readEntry();
              }
            }
          });
        });
        console.log("Done");
      }
      else {
        console.log("targetDir not exist");
        process.exit(1);
      }
    }
  }
})();