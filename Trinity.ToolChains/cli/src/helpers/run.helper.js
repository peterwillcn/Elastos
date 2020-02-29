const path = require("path")
const os = require("os")
const fs = require("fs")
const bonjour = require('bonjour')()
require("colors")

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

    /**
     * Tries to find a running ios simulator and returns its info (mostly, its udid).
     */
    getRunningSimulatorInfo() {
        return new Promise((resolve, reject)=>{
            console.log("Retrieving information about the currently running ios simulator.")

            const spawn = require("child_process").spawn;
            const process = spawn('xcrun',["simctl","list","devices","booted","--json"]);

            let output = ""

            process.stdout.on('data', function (data) { output += data });
            process.stderr.on('data', function (data) { console.log(''+data)});
            process.on('error', function(err) { reject(err)})

            process.on('exit', function (code) {
                if (code == 0) {
                    try {
                        // Parse returned json and try to find a started iOS simulator
                        let infoJson = JSON.parse(output)
                        if (!infoJson || !infoJson.devices) {
                            reject("No device information foudn in simctl")
                        }
                        else {
                            // Try to find a "ios" device in the list of returned devices
                            // Looking for something like "com.apple.CoreSimulator.SimRuntime.iOS-13-3"
                            let iosDevice = null
                            for (let deviceKey of Object.keys(infoJson.devices)) {
                                if (deviceKey.indexOf("iOS") > 0) {
                                    // Found the ios device - now check if an instance is running
                                    if (infoJson.devices[deviceKey].length > 0) {
                                        iosDevice = infoJson.devices[deviceKey][0]
                                        console.log("Found a running ios simulator: "+deviceKey)
                                        console.log(iosDevice)
                                        break
                                    }
                                    else {
                                        // Found the device ID, but no instance is running - keep searching
                                    }
                                }
                            }

                            if (iosDevice)
                                resolve(iosDevice)
                            else 
                                reject("No running iOS simulator found")
                        }
                    }
                    catch (e) {
                        console.log('ERROR - Failed to get a readable response from simctl')
                        reject(e)
                    }
                }
                else {
                    console.log('ERROR - child process exited with code ' + code);
                    reject()
                }
            });
        })
    }

    /**
     * Uploads a EPK file from the computer to the internal trinity app folder on simulator, at a location
     * that trinity will be able to read to install the EPK.
     */
    iosUploadEPK(epkPath) {
        return new Promise((resolve, reject)=>{
            console.log("Uploading computer EPK to simulator.")

            // First, find the trinity folder location
            const spawn = require("child_process").spawn;
            const process = spawn('xcrun',["simctl","get_app_container","booted","org.elastos.trinity.browser","data"]);

            let output = ""

            process.stdout.on('data', function (data) { output += data });
            process.stderr.on('data', function (data) { console.log(''+data)});
            process.on('error', function(err) { reject(err)})

            process.on('exit', function (code) {
                if (code == 0) {
                    // Make sure the output is a full path that exists
                    let appDataPath = output.replace("\n","").replace("\r","").trim()
                    if (fs.existsSync(appDataPath)) {
                        // Copy the epk inside the simulator folder
                        let epkDestPath = appDataPath+"/temp.epk"
                        fs.copyFileSync(epkPath, epkDestPath)
                        resolve()
                    }
                    else {
                        reject("Simulator path to the trinity app looks invalid. Is Trinity installed in the simulator?")
                    }
                }
                else {
                    console.log('ERROR - child process exited with code ' + code);
                    reject()
                }
            });
        })
    }

    /**
     * Sends a command to the ios simulator's installed trinity app, in order to let it install our epk
     */
    iosInstallTempEPK() {
        return new Promise((resolve, reject)=>{
            console.log("Requesting EPK installation to the simulator.")

            let urlToOpen = "elastos://installepk"

            const spawn = require("child_process").spawn;
            const process = spawn('xcrun',["simctl","openurl","booted",urlToOpen]);

            process.stdout.on('data', function (data) { console.log(''+data) });
            process.stderr.on('data', function (data) { console.log(''+data) });
            process.on('error', function(err) { reject(err)})

            process.on('exit', function (code) {
                if (code == 0) {
                    resolve()
                }
                else {
                    console.log('ERROR - child process exited with code ' + code);
                    reject()
                }
            });
        })
    }

    runDownloadService(epkPath) {
        return new Promise((resolve, reject)=>{
            var server;
            let port = 3000

            // Run a temporary http server
            var express = require('express')
            var app = express()
    
            app.get('/downloadepk', (req, res) => {
                res.sendFile(epkPath, {}, (err)=>{
                    if (err) {
                        console.log("There was an error while delivering the EPK to the elastOS mobile app.".red)
                        reject(err)
                        return
                    }
                    else 
                        console.log("The EPK file was downloaded by the elastOS mobile app.".green)

                    // Stop the servers right after the download is completed, and resolve.
                    server.close()
                    bonjour.unpublishAll()

                    resolve()
                })
            })
            var server = app.listen(port)
    
            // Advertise a trinitycli HTTP server
            bonjour.publish({ name: 'trinitycli', type: 'trinitycli', port: port })

            console.log("Waiting for the mobile app to download the dApp.".blue)
        })
    }
}