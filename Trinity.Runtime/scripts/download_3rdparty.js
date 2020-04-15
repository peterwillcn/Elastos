"use strict";

// CONFIGURE HERE
const files_to_download  = [
  {
    "url": "https://github.com/elastos/Elastos.NET.Carrier.Swift.SDK/releases/download/release-v5.5.0/ElastosCarrier-framework.zip",
    "filename": "ElastosCarrier-framework.zip",
    "sourceDirs": [
      "ElastosCarrier-framework/ElastosCarrierSDK.framework"
    ],
    "targetDir": "../Plugins/Carrier/src/ios/libs",
    "md5": "fe88bb42d8dc66beb480698f52c0cfa3"
  },{
    "url": "https://github.com/elastos/Elastos.NET.Hive.Swift.SDK/releases/download/release-v1.0.0/ElastosHiveSDK-framework-for-trinity.zip",
    "filename": "ElastosHiveSDK-framework-for-trinity.zip",
    "sourceDirs": [
      "ElastosHiveSDK-framework-for-trinity/Alamofire.framework",
      "ElastosHiveSDK-framework-for-trinity/ElastosHiveSDK.framework",
      "ElastosHiveSDK-framework-for-trinity/PromiseKit.framework",
      "ElastosHiveSDK-framework-for-trinity/Swifter.framework"
    ],
    "targetDir": "../Plugins/Hive/src/ios/libs",
    "md5": "36063ddf4fe5973e91e36477749cdc21"
  },{
    "url": "https://github.com/elastos/Elastos.Trinity.Plugins.Wallet/releases/download/spvsdk-V0.5.0/libspvsdk.zip",
    "filename": "libspvsdk.zip",
    "sourceDirs": [
      "libspvsdk"
    ],
    "targetDir": "../Plugins/Wallet/src/ios",
    "md5": "e5f32bd9be63883284ce67d5d756ae6e"
  },{
    "url": "https://github.com/elastos/Elastos.DID.Swift.SDK/releases/download/internal_experimental_v0.0.9/ElastosDIDSDK.framework.zip",
    "filename": "ElastosDIDSDK.framework.zip",
    "sourceDirs": [
      "ElastosDIDSDK.framework"
    ],
    "targetDir": "../Plugins/DID/src/ios/libs",
    "md5": "825f1dd7ea5f30a0360a54d778a4bb15"
  },
  {
    "url": "https://github.com/elastos/Elastos.DID.Swift.SDK/releases/download/internal_experimental_v0.0.9/Antlr4.framework.zip",
    "filename": "Antlr4.framework.zip",
    "sourceDirs": [
      "Antlr4.framework"
    ],
    "targetDir": "../Plugins/DID/src/ios/libs",
    "md5": "9818efcfb6585250f958674bb0bd0bd5"
  },
  {
    "url": "https://github.com/elastos/Elastos.DID.Swift.SDK/releases/download/internal_experimental_v0.0.9/PromiseKit.framework.zip",
    "filename": "PromiseKit.framework.zip",
    "sourceDirs": [
      "PromiseKit.framework"
    ],
    "targetDir": "../Plugins/DID/src/ios/libs",
    "md5": "48ec30e3b0ac8da366f54d47e1ad336d"
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
  // console.log("download_3rdparty ", JSON.stringify(ctx, null, 2));

  // make sure ios platform is part of platform add
  if (!ctx.opts.platforms.some((val) => val.startsWith("ios"))) {
    return;
  }

  const wget = require('node-wget-promise'),
        readline = require('readline'),
        md5File = require('md5-file/promise'),
        yauzl = require("yauzl"),
        mkdirp = require("mkdirp");

  let cachePath = path.join(path.dirname(ctx.scriptLocation), 'cache');
  mkdirp.sync(cachePath);

  let promise = new Promise(function(resolve, reject) {
    (async () => {
      let zip_file_count = 0;
      let downloaded_all_files = false;
      for (const obj of files_to_download) {
        let zipFilePath = path.join(cachePath, obj.filename)

        //
        // Check the md5 of the downloaded file
        //
        let fileMatched = fs.existsSync(zipFilePath)
                          && fs.lstatSync(zipFilePath).isFile()
                          && await md5File(zipFilePath) == obj.md5

        const max_attempt = 3;
        let attempt = 0;
        let files_need_to_update = false;
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
          console.log("Download finished.");

          fileMatched = fs.existsSync(zipFilePath)
                        && fs.lstatSync(zipFilePath).isFile()
                        && await md5File(zipFilePath) == obj.md5
           files_need_to_update = true;
        }

        if (!fileMatched) {
          reject('Failed to download ' + obj.filename);
        }

        // Zip file matched md5
        console.log("File %s is ready!", obj.filename);
        if (fs.existsSync(ctx.opts.projectRoot) && fs.lstatSync(ctx.opts.projectRoot).isDirectory()) {
          let targetPath = path.join(ctx.opts.projectRoot, obj.targetDir);
          mkdirp.sync(targetPath);
          if (files_need_to_update) {// delete the old files
            for (const srcDir of obj.sourceDirs) {
              let baseName = path.basename(srcDir);
              let frameworkDir = path.join(targetPath, baseName);
              console.log("    DeleteDirectory:", frameworkDir);
              DeleteDirectory(frameworkDir);
            }
          }
          if (fs.existsSync(targetPath) && fs.lstatSync(targetPath).isDirectory()) {
            console.log("Unziping file %s", obj.filename);
            yauzl.open(zipFilePath, {lazyEntries: true}, function(err, zipfile) {
              if (err) reject(err);
              zip_file_count++;
              zipfile.readEntry();
              zipfile.on("entry", async (entry) => {
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
                      await zipfile.openReadStream(entry, function(err, readStream) {
                        if (err) reject(err);
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
              zipfile.on("end", () => {
                zip_file_count--;
                if (zip_file_count == 0 && downloaded_all_files) {
                  console.log("Finish download and unzip 3rdparties.");
                  resolve();
                }
              });
            });
          }
          else {
            reject("targetDir not exist");
          }
        }
      }
      downloaded_all_files = true;
      if (zip_file_count == 0) {
        resolve();
      }
    })();
  });

  return promise;
};
