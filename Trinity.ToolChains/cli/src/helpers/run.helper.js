const path = require("path")
const os = require("os")
const fs = require("fs")

const DAppHelper = require("./dapp.helper")

module.exports = class RunHelper {
    /**
     * Uploads a given EPK file to a connected android device, to a temporary location.
     */
    androidUploadEPK(EPKPath) {
        return new Promise((resolve, reject) => {
            console.log("Trying to upload the EPK file to a connected android device...")

            var destinationPath = "/sdcard/temp.epk";

            const spawn = require("child_process").spawn;
            const adbProcess = spawn('adb',["push", EPKPath, destinationPath]);

            adbProcess.stdout.on('data', function (data) { console.log(''+data)});
            adbProcess.stderr.on('data', function (data) { console.log(''+data)});
            adbProcess.on('error', function(err) { reject(err)})

            adbProcess.on('exit', function (code) {
                if (code == 0) {
                    // Operation completed successfully
                    console.log("EPK file successfully pushed on your android device at "+destinationPath)
                    resolve()
                }
                else {
                    console.log('ERROR - child process exited with code ' + code);
                    reject()
                }
            });
        })
    }

    /**
     * Request the trinity application to open a EPK file that was previously pushed to the device.
     * That may install that EPK inside trinity.
     */
    androidInstallTempEPK() {
        return new Promise((resolve, reject) => {
            console.log("Requesting your trinity application to install your DApp...")

            // Sample command: adb shell am start -a android.intent.action.VIEW -d file:///storage/emulated/0/temp.epk -t *.epk
            const spawn = require("child_process").spawn;
            // -c android.intent.category.TEST is used to automatically uninstall existing app from trinity
            const adbProcess = spawn('adb',["shell","am","start","-a","android.intent.action.VIEW","-d","file:///storage/emulated/0/temp.epk","-t","*.epk","-c","android.intent.category.TEST"]);

            adbProcess.stdout.on('data', function (data) { console.log(''+data)});
            adbProcess.stderr.on('data', function (data) { console.log(''+data)});
            adbProcess.on('error', function(err) { reject(err)})

            adbProcess.on('exit', function (code) {
                if (code == 0) {
                    // Operation completed successfully
                    console.log("Trinity has received your DApp. Please check your device for further instruction")
                    resolve()
                }
                else {
                    console.log('ERROR - child process exited with code ' + code);
                    reject()
                }
            });
        })
    }
}