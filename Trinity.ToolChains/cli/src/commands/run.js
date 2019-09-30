const path = require("path")
require("colors")

const RunHelper = require("../helpers/run.helper")
const ManifestHelper = require("../helpers/manifest.helper")
const IonicHelper = require("../helpers/ionic.helper")
const DAppHelper = require("../helpers/dapp.helper")
const SystemHelper = require("../helpers/system.helper")

exports.command = 'run'
exports.describe = 'Deploys current DApp to your connected device'
exports.builder = {
  platform: {
    alias: "p",
    describe: "Platform to deploy to (android|ios)",
    require: true
  },
  nodebug: {
      // Let app be deployed without ionic serve. This way, manifest is not modified and will call
      // a local index.html (on device) instead of a remote IP served by ionic. This way, apps can be 
      // running on the device without computer dependency (but loose debugging capability).
      describe: "Deploy the DApp without remote url access, auto-reload or debugging capability",
      require: false,
      nargs: 0
  }
  /*idkeystore: {
    alias: "id",
    describe: "Identity keystore file to be used to sign DApp EPK",
    require: true
  }*/
}
exports.handler = function (argv) {
    var platform = argv.platform
    var idKeystorePath = argv.idkeystore
    var noDebug = argv.nodebug

    switch (platform) {
        case "android":
            deployAndroidDApp(idKeystorePath, noDebug)
            break;
        case "ios":
            console.log("Not yet implemented")
            break;
        default:
            console.log("ERROR - Not a valid platform")
    }
}

/**
 * The process to run one of our ionic-based DApps is as following:
 * - Retrieve user's computer IP (to be able to ionic serve / hot reload)
 * - Update the start_url in the trinity manifest
 * - npm install
 * - ionic build
 * - pack_epk
 * - sign_epk
 * - push and run the EPK on the device (adb push/shell am start, on android)
 * - ionic serve (for hot reload inside trinity, when user saves his files)
 */
function deployAndroidDApp(idKeystorePath, noDebug) {
    var runHelper = new RunHelper()
    var manifestHelper = new ManifestHelper()
    var ionicHelper = new IonicHelper()
    var dappHelper = new DAppHelper()

    if (!dappHelper.checkFolderIsDApp()) {
        console.error("ERROR".red + " - " + dappHelper.noManifestErrorMessage())
        return
    }

    // Make sure mandatory dependencies are available
    if (!SystemHelper.checkIonicPresence()) {
        console.error("Error:".red, "Please first install IONIC on your computer.")
        return
    }
    if (!SystemHelper.checkADBPresence()) {
        console.error("Error:".red, "Please first install Android tools (especially ADB) on your computer.")
        return
    }

    // Retrieve user's computer IP (to be able to ionic serve / hot reload)
    // Update the start_url in the trinity manifest
    var manifestPath = path.join(process.cwd(), "src", "assets", "manifest.json")
    if (noDebug)
        manifestHelper.updateManifestForLocalIndex(manifestPath)
    else
        manifestHelper.updateManifestForRemoteIndex(manifestPath)

    ionicHelper.updateNpmDependencies().then(() => {
        ionicHelper.runIonicBuildDev().then(() => {
            dappHelper.packEPK(manifestPath).then((outputEPKPath)=>{
                dappHelper.signEPK(outputEPKPath, idKeystorePath).then(()=>{
                    runHelper.androidUploadEPK(outputEPKPath).then(()=>{
                        runHelper.androidInstallTempEPK().then(()=>{
                            console.log("RUN OPERATION COMPLETED")

                            if (!noDebug) {
                                console.log("NOW RUNNING THE APP FOR DEVELOPMENT")
                                ionicHelper.runIonicServe()
                            }
                        })
                        .catch((err)=>{
                            console.error("Failed to install your DApp on your device")
                            console.error("Error:",err)
                        })
                    })
                    .catch((err)=>{
                        console.error("Failed to upload your DApp to your device")
                        console.error("Error:",err)
                    })
                })
                .catch((err)=>{
                    console.error("Failed to sign your EPK file")
                    console.error("Error:",err)
                })
            })
            .catch((err)=>{
                console.error("Failed to pack your DApp into a EPK file")
                console.error("Error:",err)
            })          
        })
        .catch((err)=>{
            console.error("Failed run ionic build")
            console.error("Error:",err)
        })          
    })
    .catch((err)=>{
        console.error("Failed to install ionic dependencies")
        console.error("Error:",err)
    }) 
}