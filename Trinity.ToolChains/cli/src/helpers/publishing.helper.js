const fs = require("fs-extra");
const path = require("path");
const os = require("os");
const axios = require("axios");
const FormData = require('form-data');
const Spinner = require('cli-spinner').Spinner;
const sharp = require("sharp");

const config = require("../config.js");
const ManifestHelper = require("../helpers/manifest.helper");
const DAppHelper = require("../helpers/dapp.helper");
const IonicHelper = require("../helpers/ionic.helper");

var dappHelper = new DAppHelper();
var manifestHelper = new ManifestHelper();
var ionicHelper = new IonicHelper();

module.exports = class PublishingHelper {
    /**
     * @param string didUrl A previously created DID using "trinity did create" and used to sign the EPK.
     */
    async publishToDAppStore(epkPath, didUrl, whatsNew) {
        return new Promise(async (resolve, reject) => {
            console.log("");
            console.log("Starting DApp publishing process...");

            if (!dappHelper.checkFolderIsDApp()) {
                reject(dappHelper.noManifestErrorMessage());
                return;
            }

            // EPK
            let epkStream = fs.createReadStream(epkPath);

            // Manifest
            var manifestPath = manifestHelper.getManifestPath(ionicHelper.getConfig().assets_path);
            let manifestStream = fs.createReadStream(manifestPath);

            // App icon
            let manifest = JSON.parse(fs.readFileSync(manifestPath));
            if (!manifest.icons || manifest.icons.length == 0 || !manifest.icons[0].src) {
                reject("No valid app icon in manifest (icons->0->src)");
                return;
            }

            let appIconPath = path.join(process.cwd(), ionicHelper.getConfig().assets_path, manifest.icons[0].src);
            if (!fs.existsSync(appIconPath)) {
                reject("No app icon found at location " + appIconPath + ". Please check your manifest.");
                return;
            }
            // TODO: make sure picture is a PNG file with the right dimensions

            // Banner image
            let storeConfigPath = path.join(process.cwd(), "dappstore.config.json");
            if (!fs.existsSync(storeConfigPath)) {
                reject("No dappstore.config.json file found in your project root. This file is required.");
                return;
            }

            let storeConfig = JSON.parse(fs.readFileSync(storeConfigPath));
            if (!storeConfig.banner || !storeConfig.banner.src) {
                reject("No entry found for app banner image (banner->src) in the dappstore.config.json");
                return;
            }

            let bannerImagePath = path.join(process.cwd(), storeConfig.banner.src);
            if (!fs.existsSync(bannerImagePath)) {
                reject("DApp store banner image file not found at location " + bannerImagePath);
                return;
            }

            // Upload only pictures with the right size
            let resizedBannerImagePath = await this.adjustBannerSize(bannerImagePath);

            let appIconStream = fs.createReadStream(appIconPath);
            let bannerImageStream = fs.createReadStream(resizedBannerImagePath);

            const data = new FormData();
            data.append("epk", epkStream);
            data.append("manifest", manifestStream);
            data.append("appicon", appIconStream);
            data.append("bannerimage", bannerImageStream);

            if (whatsNew && typeof whatsNew === "string") // Make sure what's new has the right format
                data.append("whatsnew", whatsNew);

            /*axios.interceptors.request.use(request => {
                console.log('Starting Request', request)
                return request
            })*/

            var spinner = new Spinner({
                text: 'Uploading data... %s',
                stream: process.stdout,
                onTick: function (msg) {
                    this.clearLine(this.stream);
                    this.stream.write(msg);
                }
            });
            spinner.start();

            try {
                let response = await axios({
                    method: "post",
                    url: config.dappstore.host + '/apps/publish',
                    data: data,
                    headers: {
                        'Content-Type': `multipart/form-data; boundary=${data._boundary}`
                    }
                });

                if (!response.data.published) {
                    reject(response.data.reason);
                } else {
                    resolve();
                }
            } catch (e) {
                console.log(e);
                reject(e);
            }

            spinner.stop();
            console.log("");
        });
    }

    /**
     * Send banners that are always 1024x500 and return the modified picture path
     */
    async adjustBannerSize(bannerPath) {
        console.log("Converting banner image to 1024x500, JPG format");
        let modifiedBannerPath = os.tmpdir() + "/trinitybanner.jpg";

        await sharp(bannerPath).resize(1024, 500).jpeg().toFile(modifiedBannerPath);

        return modifiedBannerPath;
    }
};