const fs = require("fs-extra");
const path = require("path");
const axios = require("axios");
const FormData = require('form-data');
const Spinner = require('cli-spinner').Spinner;

const config = require("../config.js")
const ManifestHelper = require("../helpers/manifest.helper")
const DAppHelper = require("../helpers/dapp.helper")

var dappHelper = new DAppHelper()

module.exports = class PublishingHelper {
    publishToDAppStore(epkPath, signaturePath) {
        return new Promise(async (resolve, reject) => {

            console.log("")
            console.log("Starting DApp publishing process...")
            
            if (!dappHelper.checkFolderIsDApp()) {
                reject(dappHelper.noManifestErrorMessage())
                return
            }

            //const json = JSON.stringify(obj);

            // EPK
            let epkStream = fs.createReadStream(epkPath)

            // Manifest
            var manifestPath = path.join(process.cwd(), "src", "assets", "manifest.json")
            let manifestStream = fs.createReadStream(manifestPath)

            // App icon
            let manifest = JSON.parse(fs.readFileSync(manifestPath))
            if (!manifest.icons || manifest.icons.length == 0 || !manifest.icons[0].src) {
                reject("No valid app icon in manifest (icons->0->src)")
                return
            }

            let appIconPath = path.join(process.cwd(), "src", manifest.icons[0].src)
            if (!fs.existsSync(appIconPath)) {
                reject("No app icon found at location "+appIconPath+". Please check your manifest.")
                return
            }

            // TODO: make sure picture is a PNG file with the right dimensions

            let appIconStream = fs.createReadStream(appIconPath)

            // Developer signature
            // TODO - How to get the developer's public key?
            
            const data = new FormData();
            //data.append("jsondata", json);
            data.append("epk", epkStream);
            data.append("manifest", manifestStream);
            data.append("appicon", appIconStream)

            /*axios.interceptors.request.use(request => {
                console.log('Starting Request', request)
                return request
            })*/

            var spinner = new Spinner({
                text: 'Uploading data... %s',
                stream: process.stdout,
                onTick: function(msg){
                    this.clearLine(this.stream);
                    this.stream.write(msg);
                }
            })
            spinner.start();

            try {
                let response = await axios({
                    method:"post",
                    url: config.dappstore.host+'/apps/publish', 
                    data: data,
                    headers: {
                        'Content-Type': `multipart/form-data; boundary=${data._boundary}`
                    }
                })
                
                if (!response.data.published) {
                    reject(response.data.reason)
                }
                else {
                    resolve()
                }
            }
            catch (e) {
                console.log(e)
                reject(e)
            }

            spinner.stop()
            console.log("")
        })
    }
}
