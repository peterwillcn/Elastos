const os = require("os")
const path = require("path")
const fs = require("fs-extra")
const jwt = require("jsonwebtoken")
const QRCode = require('qrcode')
const open = require('open')
const Spinner = require('cli-spinner').Spinner
const axios = require("axios")
const sleep = require("await-sleep")
const prompts = require("prompts")

module.exports = class DIDHelper {    
    static get DEFAULT_DID_STORE_FOLDER_NAME() {
        return "appdid";
    } 

    /**
     * Creates a new DID in current folder.
     */
    createDID() {
        return new Promise(async (resolve, reject) => {
            console.log("Creating a new DID...")

            var rootScriptDirectory = path.dirname(require.main.filename)

            // Prompt password to create the DID
            console.log("Please set a password to protect your DID signature. Don't forget it, it can't be retrieved.")

            let typedInfo;
            do {
                const questions = [
                    {
                        type: 'password',
                        name: 'password',
                        message: 'DID signature private key password. 8 characters min:',
                        validate: value => {
                            return value != "" && value.length >= 8
                        }
                    },
                    {
                        type: 'password',
                        name: 'passwordRepeat',
                        message: 'Please type your password again:',
                        validate: value => {
                            return value != "" && value.length >= 8
                        }
                    },
                ];
                typedInfo = await prompts(questions);

                if (typedInfo.password != typedInfo.passwordRepeat) {
                    console.log("Sorry, password don't match, please try again.".red)
                }
            }
            while (typedInfo.password != typedInfo.passwordRepeat)
            console.log("")

            const spawn = require("child_process").spawn;
            const pythonProcess = spawn('python',[rootScriptDirectory+"/toolchain/create_did","-r",DIDHelper.DEFAULT_DID_STORE_FOLDER_NAME,"-p",typedInfo.password,"-s",typedInfo.password]);

            var output = ""

            pythonProcess.stdout.on('data', function (data) { output += data });
            pythonProcess.stderr.on('data', function (data) { console.log(''+data)});
            pythonProcess.on('error', function(err) { reject(err)})

            pythonProcess.on('exit', function (code) {
                if (code == 0) {
                    // Successfully created the DID
                    // Try to parse the output as JSON
                    try {
                        let jsonOutput = JSON.parse(output)
                        console.log("DID created successfully locally on your computer".green)
                        console.log("Please save the following information safely and permanently:".magenta)
                        console.log("")
                        console.log("YOUR DID: ".green+jsonOutput.id)
                        console.log("YOUR MNEMONIC: ".green+jsonOutput.mnemonic)
                        console.log("")
                        resolve({
                            password: typedInfo.password, 
                            did: jsonOutput.id
                        })
                    }
                    catch(e) {
                        reject('Invalid JSON output from create_did' + output)
                        return
                    }
                }
                else {
                    reject('Child process exited with code ' + code)
                }
            });
        })
    }

    /**
     * Imports a DID from a mnemonic
     */
    importDID(mnemonic) {
        return new Promise(async (resolve, reject) => {
            console.log("Importing the DID...")

            var rootScriptDirectory = path.dirname(require.main.filename)

            let password = "TempPassword";

            const spawn = require("child_process").spawn;
            const pythonProcess = spawn('python',[rootScriptDirectory+"/toolchain/create_did","-r",DIDHelper.DEFAULT_DID_STORE_FOLDER_NAME,"-s",password,"-m",mnemonic]);

            var output = ""

            pythonProcess.stdout.on('data', function (data) { output += data });
            pythonProcess.stderr.on('data', function (data) { console.log(''+data)});
            pythonProcess.on('error', function(err) { reject(err)})

            pythonProcess.on('exit', function (code) {
                if (code == 0) {
                    // Successfully created the DID
                    // Try to parse the output as JSON
                    try {
                        let jsonOutput = JSON.parse(output)
                        console.log("DID imported successfully locally on your computer".green)
                        console.log("YOUR DID: ".green+jsonOutput.id)
                        resolve({
                            password: password, 
                            did: jsonOutput.id,
                            mnemonic: jsonOutput.mnemonic
                        })
                    }
                    catch(e) {
                        reject('Invalid JSON output from create_did' + output)
                        return
                    }
                }
                else {
                    reject('Child process exited with code ' + code)
                }
            });
        })
    }

    /**
     * After a DID is created, a DID request JSON structure has to be created. That request packages
     * the signed and base58 (?) encoded DID document of the created DID, into a CREATE DID request that 
     * can be stored on chain.
     */
    createDIDRequest(password, didString) {
        return new Promise((resolve, reject)=>{
            var rootScriptDirectory = path.dirname(require.main.filename)

            const spawn = require("child_process").spawn;
            const pythonProcess = spawn('python',[rootScriptDirectory+"/toolchain/did_create_publish_didrequest","-r",DIDHelper.DEFAULT_DID_STORE_FOLDER_NAME,"-p",password,"-d",didString]);

            var output = "";

            pythonProcess.stdout.on('data', function (data) { output += data });
            pythonProcess.stderr.on('data', function (data) { console.log(''+data)});
            pythonProcess.on('error', function(err) { reject(err)})

            pythonProcess.on('exit', function (code) {
                if (code == 0) {
                    // Successfully created the DID request
                    // Try to parse the output as JSON
                    try {
                        let jsonOutput = JSON.parse(output)
                        console.log("DID request created successfully")
                        console.log("")
                        resolve({
                            didrequest:jsonOutput.request
                        })
                    }
                    catch(e) {
                        reject('Invalid JSON output from did_create_publish_didrequest' + output)
                        return
                    }
                }
                else {
                    console.log(output);
                    reject('Child process exited with code ' + code)
                }
            }); 
        });
    }

    /**
     * Generates a intent url that can be opened in trinity, to let the wallet application pay for 
     * a DID document creation transaction. This transaction payload is signed locally by the DID.
     */
    generateCreateDIDDocumentTransactionURL(didRequest) {
        return new Promise((resolve, reject)=>{
            jwt.sign(didRequest, "nosecretkey", { algorithm: 'none' }, (err, encodedJWT)=>{
                let url = "elastos://didtransaction/"+encodedJWT
                resolve(url)
            })
        })
    }

    /**
     * Generates a temporary local web page that can be opened on the computer in order to display
     * a QR code. This QR code should be scanned from the Trinity application in order to run the 
     * wallet app to pay DID transaction fees. 
     */
    generatePayForTransactionQRCodeWebPage(schemeUrl) {
        console.log("Creating a temporary web page to display a QR code...")
        return new Promise((resolve, reject)=>{
            let webpagePath = os.tmpdir() + "/publishdid.html"
            QRCode.toDataURL(schemeUrl,  async (err, imageDataUrl) => {
                let htmlData = "<html><body style='font-family:verdana'><center>";
                htmlData += "<h2>Please scan this QR code using elastOS from your mobile phone</h2>";
                htmlData += "<h3>You will be prompted to confirm publication of your DID on the DID sidechain</h3>";
                htmlData += "<img src='"+imageDataUrl+"' height='600'/>";
                htmlData += "</center></body></html>"

                fs.writeFileSync(webpagePath, htmlData)
    
                resolve(webpagePath)
            })
        })
    }

    promptAndOpenQRCodeWebPage(webpagePath) {
        return new Promise(async (resolve, reject) => {
            const questions = [
                {
                    type: 'text',
                    name: 'next',
                    message: 'Please press enter to launch the web page:'
                }
            ];
            await prompts(questions);

            console.log("Launching your browser to display a QR code.");
            console.log("If this doesn't open automatically, please manually open ["+webpagePath+"].");

            await open("file://"+webpagePath);

            resolve()
        })
    }

    /**
     * Infinite polling to check when the DID transaction has been written on the sidechain.
     * A DApp cannot be published on the DApp store without a valid DID on the sidechain so after
     * the DID is uploaded, we check the sidechain until we can see it appear. At that time we can
     * publish.
     */
    async waitForSidechainTransactionCompleted(didString) {
        console.log("")
        console.log("Waiting for your DID to be ready on the DID sidechain. This could take several minutes.")
        console.log("Please now scan the QR code and validate the transaction from your trinity application.".magenta)
        console.log("")

        this.createdDIDFoundOnSidechain = false;
        // Debug: valid ID already on sidechain: iVPadJq56wSRDvtD5HKvCPNryHMk3qVSU4
        // Debug: valid ID not yet on sidechain: ihQrudV8ya5MfZRZW98dbiet1n1QCVAWPL
        this.targetDIDUrl = didString;
        this.didCreationCheckRetryCount = 0
        this.didCreationSpinnerMessage = "Starting"

        let self = this
        this.checkDIDCreationSpinner = new Spinner({
            text: '%s',
            stream: process.stdout,
            onTick: function(msg){
                this.clearLine(this.stream);
                this.stream.write(self.didCreationSpinnerMessage + " " + msg);
            }
        })
        this.checkDIDCreationSpinner.start();

        do {
            await this._checkDIDPresenceOnSidechain()
            await sleep(3000)
        }
        while (!this.createdDIDFoundOnSidechain)

        await sleep(1000)
        console.log("");
        console.log("");
        console.log("DONE! Your DID is now available on the DID sidechain.".green)
    }

    _stopCheckingDIDCreated() {
        this.checkDIDCreationSpinner.stop()
    }

    /**
     * Checks that a given DID exists on the DID sidechain using a centralized RPC API
     */
    async _checkDIDPresenceOnSidechain() {
        return new Promise((resolve, reject)=>{
            var rootScriptDirectory = path.dirname(require.main.filename)

            this.didCreationCheckRetryCount++
            this.didCreationSpinnerMessage = "Querying DID sidechain... (Retry "+this.didCreationCheckRetryCount+") - Not found yet."

            const spawn = require("child_process").spawn;
            const pythonProcess = spawn('python3',[rootScriptDirectory+"/toolchain/did_resolve","-r",DIDHelper.DEFAULT_DID_STORE_FOLDER_NAME,"-d",this.targetDIDUrl]);

            var output = "";

            pythonProcess.stdout.on('data', function (data) { output += data });
            pythonProcess.stderr.on('data', function (data) { console.log(''+data)});
            pythonProcess.on('error', function(err) { reject(err)})

            pythonProcess.on('exit', (code) => {
                if (code == 0) {
                    // Successfully queried the DID sidechain. Now check the returned document
                    try {
                        let jsonOutput = JSON.parse(output)
                        
                        let status = jsonOutput.status;
                        if (status == "empty") {
                            // Nothing to do, keep retrying
                        }
                        else if (status == "error") {
                            console.error("Error while checking DID status...");
                            // Nothing else to do, keep retrying
                        }
                        else if (status == "success") {
                            this.createdDIDFoundOnSidechain = true;    
                            this._stopCheckingDIDCreated();
                        }

                        resolve()
                    }
                    catch(e) {
                        console.error(e);
                        reject('Invalid JSON output from did_resolve' + output)
                        return
                    }
                }
                else {
                    console.log(output);
                    reject('Child process exited with code ' + code)
                }
            }); 
        });
    }
}
