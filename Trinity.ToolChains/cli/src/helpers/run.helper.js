const path = require("path")
const os = require("os")

module.exports = class RunHelper {
    getTempEPKPath() {
        return os.tmpdir()+"/temp.epk"
    }

    /**
     * Packs DApp located in current folder as a EPK file.
     */
    packEPK() {
        return new Promise((resolve, reject) => {
            console.log("Packaging current folder into a Elastos package (EPK) file...")

            var rootScriptDirectory = path.dirname(require.main.filename)
            var outputEPKPath = this.getTempEPKPath()

            console.log("Output EPK will generated at: "+outputEPKPath)

            const spawn = require("child_process").spawn;
            const pythonProcess = spawn('python',[rootScriptDirectory+"/toolchain/pack_epk", outputEPKPath, "-r","."]);

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
     * Uploads a given EPK file to a connected android device, to a temporary location.
     */
    androidUploadEPK(EPKPath) {
        return new Promise((resolve, reject) => {
            console.log("Trying to upload the EPK file to a connected android device...")

            var destinationPath = "/storage/emulated/0/temp.epk";

            const spawn = require("child_process").spawn;
            const pythonProcess = spawn('adb',["push", EPKPath, destinationPath]);

            pythonProcess.stdout.on('data', function (data) { console.log(''+data)});
            pythonProcess.stderr.on('data', function (data) { console.log(''+data)});
            pythonProcess.on('error', function(err) { reject(err)})

            pythonProcess.on('exit', function (code) {
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

            var destinationPath = "/storage/emulated/0/temp.epk";

            // Sample command: adb shell am start -a android.intent.action.VIEW -d file:///storage/emulated/0/temp.epk -t *.epk
            const spawn = require("child_process").spawn;
            const pythonProcess = spawn('adb',["shell","am","start","-a","android.intent.action.VIEW","-d","file:///storage/emulated/0/temp.epk","-t","*.epk"]);

            pythonProcess.stdout.on('data', function (data) { console.log(''+data)});
            pythonProcess.stderr.on('data', function (data) { console.log(''+data)});
            pythonProcess.on('error', function(err) { reject(err)})

            pythonProcess.on('exit', function (code) {
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