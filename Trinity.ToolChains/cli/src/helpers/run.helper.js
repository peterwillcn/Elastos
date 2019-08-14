const path = require("path")
const os = require("os")
const fs = require("fs")

module.exports = class RunHelper {
    getTempEPKPath() {
        return os.tmpdir()+"/temp.epk"
    }

    /**
     * Make sure current folder is a DApp, to not try to package some invalid content.
     */
    _checkFolderIsDApp() {
        var manifestPath = path.join(process.cwd(), "manifest.json")

        if (!fs.existsSync(manifestPath)) {
            return false;
        }

        // TODO: more advanced checks

        return true; // All checks passed - we are in a trinity DApp folder.
    }

    /**
     * Packs DApp located in current folder as a EPK file.
     */
    packEPK(manifestPath) {
        return new Promise((resolve, reject) => {
            console.log("Packaging current folder into a Elastos package (EPK) file...")

            if (!this._checkFolderIsDApp()) {
                reject("ERROR - Current folder is not a trinity dapp.");
                return;
            }

            var rootScriptDirectory = path.dirname(require.main.filename)
            var outputEPKPath = this.getTempEPKPath()

            console.log("Output EPK will generated at: "+outputEPKPath)

            const spawn = require("child_process").spawn;
            const pythonProcess = spawn('python',[rootScriptDirectory+"/toolchain/pack_epk", outputEPKPath, "-r",".","--root-dir","www","-m",manifestPath]);

            pythonProcess.stdout.on('data', function (data) { console.log(''+data)});
            pythonProcess.stderr.on('data', function (data) { console.log(''+data)});
            pythonProcess.on('error', function(err) { reject(err)})

            pythonProcess.on('exit', function (code) {
                if (code ==0) {
                    // Packed the EPK successfully
                    console.log("EPK packaged successfully")
                    resolve(outputEPKPath)
                }
                else {
                    console.log('ERROR - child process exited with code ' + code);
                    reject()
                }
            });
        })
    }

    /**
     * Signs a given EPK using a test signature file.
     */
    signEPK(EPKPath) {
        return new Promise((resolve, reject) => {
            console.log("Signing the generated EPK with your identity...")

            var rootScriptDirectory = path.dirname(require.main.filename)
            var idKeystorePath = path.join(rootScriptDirectory, "assets", "web-keystore.aes.json");

            const spawn = require("child_process").spawn;
            const pythonProcess = spawn('python',[rootScriptDirectory+"/toolchain/sign_epk", "-k", idKeystorePath, "-p", "elastos2018", EPKPath]);

            pythonProcess.stdout.on('data', function (data) { console.log(''+data)});
            pythonProcess.stderr.on('data', function (data) { console.log(''+data)});
            pythonProcess.on('error', function(err) { console.log(err); reject(err)})

            pythonProcess.on('exit', function (code) {
                if (code == 0) {
                    // Operation completed successfully
                    console.log("EPK file successfully signed with your identity")
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