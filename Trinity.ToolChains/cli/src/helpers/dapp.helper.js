const path = require("path");
const fs = require("fs");
const os = require("os");
require("colors");

const ManifestHelper = require("./manifest.helper");
const IonicHelper = require("./ionic.helper");
const DIDHelper = require("./did.helper");

module.exports = class DAppHelper {
    /**
     * Make sure current folder is a DApp, to not try to package some invalid content.
     */
    checkFolderIsDApp() {
        let manifestHelper = new ManifestHelper();
        let ionicHelper = new IonicHelper();

        // Older dapps csanity check. Warn user to not use a manifest.json in the root folder because
        // we will use the one from the src/assets folder
        var rootManifestPath = path.join(process.cwd(), "manifest.json");
        if (fs.existsSync(rootManifestPath)) {
            console.log("WARNING".yellow + ": You should not have manifest.json in your root folder. It has to be in src/assts instead.");
        }

        // Check manifest.json  manifestHelper.getManifestPath(info.framework)
        var ionicConfig = ionicHelper.getConfig();
        if (!ionicConfig) {
            return false;
        }

        var manifestPath = manifestHelper.getManifestPath(ionicConfig.assets_path);
        if (!fs.existsSync(manifestPath)) {
            return false;
        }

        // TODO: more advanced checks

        return true; // All checks passed - we are in a trinity DApp folder.
    }

    noManifestErrorMessage() {
        return "Current folder is not a trinity dapp. Make sure there is a manifest.json in src/assets, or create one using the *manifest* CLI command.";
    }

    getTempEPKPath() {
        return os.tmpdir() + "/temp.epk";
    }

    /**
     * Packs DApp located in current folder as a EPK file.
     */
    packEPK(manifestPath) {
        return new Promise((resolve, reject) => {
            console.log("Packaging current folder into a Elastos package (EPK) file...");

            let dappHelper = new DAppHelper();
            let manifestHelper = new ManifestHelper();
            let ionicHelper = new IonicHelper();

            if (!dappHelper.checkFolderIsDApp()) {
                reject(manifestHelper.noManifestErrorMessage());
                return;
            }

            var rootScriptDirectory = path.dirname(require.main.filename);
            var outputEPKPath = this.getTempEPKPath();

            console.log("Output EPK will generated at: " + outputEPKPath);

            const spawn = require("child_process").spawn;
            const pythonProcess = spawn('python3', [rootScriptDirectory + "/toolchain/pack_epk", outputEPKPath, "-r", ".", "--root-dir", ionicHelper.getConfig().dist_path, "-m", manifestPath]);

            pythonProcess.stdout.on('data', function (data) {
                console.log('' + data);
            });
            pythonProcess.stderr.on('data', function (data) {
                console.log('' + data);
            });
            pythonProcess.on('error', function (err) {
                reject(err);
            });

            pythonProcess.on('exit', function (code) {
                if (code == 0) {
                    // Packed the EPK successfully
                    console.log("EPK packaged successfully");
                    resolve(outputEPKPath);
                } else {
                    reject('Child process exited with code ' + code);
                }
            });
        });
    }

    /**
     * Signs a given EPK using a provided app DID.
     */
    signEPK(EPKPath, didURL, didSignaturePassword, didStorePath = DIDHelper.DEFAULT_DID_STORE_FOLDER_NAME) {
        return new Promise((resolve, reject) => {
            console.log("Signing the generated EPK with your identity...");

            // TMP DEV: did:elastos:ikFN4BuFYYvR9ERNTiWH1jAdBztE3J691m#primary
            // TMP DEV: did:elastos:ikFN4BuFYYvR9ERNTiWH1jAdBztE3J691m#primary

            var rootScriptDirectory = path.dirname(require.main.filename);
            //var idKeystorePath = nupath.join(process.cwd(), "appdid");
            var signedEPKPath = EPKPath + "_signed";

            //console.log("path",idKeystorePath)

            const spawn = require("child_process").spawn;
            const pythonProcess = spawn('python3', [rootScriptDirectory + "/toolchain/did_sign", "-r", didStorePath, "-u", didURL, "-s", didSignaturePassword, "-o", signedEPKPath, EPKPath]);

            pythonProcess.stdout.on('data', function (data) {
                console.log('' + data);
            });
            pythonProcess.stderr.on('data', function (data) {
                console.log('' + data);
            });
            pythonProcess.on('error', function (err) {
                console.log(err);reject(err);
            });

            pythonProcess.on('exit', function (code) {
                if (code == 0) {
                    // Operation completed successfully
                    console.log("EPK file successfully signed with your identity");
                    console.log("Signed EPK file is there: " + signedEPKPath);
                    resolve(signedEPKPath);
                } else {
                    reject('Child process exited with code ' + code);
                }
            });
        });
    }
};