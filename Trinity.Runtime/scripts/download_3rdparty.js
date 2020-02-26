"use strict";

// CONFIGURE HERE
const files_to_download  = [
  {
    "url": "https://github.com/elastos/Elastos.NET.Carrier.Swift.SDK/releases/download/release-v5.4.4/ElastosCarrier-framework.zip",
    "filename": "ElastosCarrier-framework.zip",
    "sourceDirs": [
      "ElastosCarrier-framework/ElastosCarrierSDK.framework"
    ],
    "targetDir": "../Plugins/Carrier/src/ios/libs",
    "md5": "cd4cdc9eda5c0e6a8a2b0e50879f2f3f"
  },{
    "url": "https://github.com/elastos/Elastos.NET.Hive.Swift.SDK/releases/download/release-v0.5.2/ElastosHiveSDK-framework-for-trinity.zip",
    "filename": "ElastosHiveSDK-framework-for-trinity.zip",
    "sourceDirs": [
      "ElastosHiveSDK-framework-for-trinity/Alamofire.framework",
      "ElastosHiveSDK-framework-for-trinity/ElastosHiveSDK.framework",
      "ElastosHiveSDK-framework-for-trinity/PromiseKit.framework",
      "ElastosHiveSDK-framework-for-trinity/Swifter.framework"
    ],
    "targetDir": "../Plugins/Hive/src/ios/libs",
    "md5": "f5a94cd84874fa841bc8beadaabc2a73"
  },{
    "url": "https://github.com/elastos/Elastos.Trinity.Plugins.Wallet/releases/download/spvsdk-V0.5.0/libspvsdk.zip",
    "filename": "libspvsdk.zip",
    "sourceDirs": [
      "libspvsdk"
    ],
    "targetDir": "../Plugins/Wallet/src/ios",
    "md5": "e5f32bd9be63883284ce67d5d756ae6e"
  },{
    "url": "https://github.com/elastos/Elastos.DID.Swift.SDK/releases/download/internal_experimental_v0.0.3/ElastosDIDSDK.framework.zip",
    "filename": "ElastosDIDSDK-framework-for-trinity.zip",
    "sourceDirs": [
      "ElastosDIDSDK.framework"
    ],
    "targetDir": "../Plugins/DID/src/ios/libs",
    "md5": "c3de358de6f47d5fd91ad09f5f38d870"
  },
  {
    "url": "https://github.com/elastos/Elastos.DID.Swift.SDK/releases/download/internal_experimental_v0.0.3/Antlr4.framework.zip",
    "filename": "Antlr4.framework.zip",
    "sourceDirs": [
      "Antlr4.framework"
    ],
    "targetDir": "../Plugins/DID/src/ios/libs",
    "md5": "f758a88ea2fd7bbec1706506292af620"
  }
]
// no need to configure below

module.exports = function(ctx) {
  // console.log(JSON.stringify(ctx, null, 2));

  // make sure ios platform is part of platform add
  if (!ctx.opts.platforms.some((val) => val.startsWith("ios"))) {
    return;
  }

  const fs = require('fs'),
        path = require('path'),
        wget = require('node-wget-promise'),
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
        }

        if (!fileMatched) {
          reject('Failed to download ' + obj.filename);
        }

        // Zip file matched md5
        console.log("File %s is ready!", obj.filename);
        if (fs.existsSync(ctx.opts.projectRoot) && fs.lstatSync(ctx.opts.projectRoot).isDirectory()) {
          let targetPath = path.join(ctx.opts.projectRoot, obj.targetDir);
          mkdirp.sync(targetPath);
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
