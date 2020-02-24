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
      // Let the app be deployed without ionic serve. This way, manifest is not modified and will call
      // a local index.html (on device) instead of a remote IP served by ionic. This way, apps can be 
      // running on the device without computer dependency (but loose debugging capability).
      describe: "Deploy the DApp without remote url access, auto-reload or debugging capability",
      require: false,
      nargs: 0
  },
  prod: {
    // Build the app with ionic's --prod flag (production mode). Useful to totally test apps before
    // publishing as there maybe be some slight difference with dev mode.
    describe: "Build the app for production in order to fully test its behaviour before publishing it.",
    require: false,
    nargs: 0
  }
}
exports.handler = function (argv) {
    var platform = argv.platform
    var noDebug = argv.nodebug
    var forProd = argv.prod || false

    if (forProd)
        console.log("Building for production")

    switch (platform) {
        case "android":
            deployAndroidDApp(noDebug, forProd)
            break;
        case "ios":
            deployiOSDApp(noDebug, forProd)
            break;
        default:
            console.log("ERROR - Not a valid platform")
    }
}

/**
 * Shared steps between android and ios deployments.
 */
async function runSharedDeploymentPhase(noDebug, forProd) {
    var dappHelper = new DAppHelper()
    var manifestHelper = new ManifestHelper()
    var ionicHelper = new IonicHelper   ()

    if (!dappHelper.checkFolderIsDApp()) {
        console.error("ERROR".red + " - " + dappHelper.noManifestErrorMessage())
        return
    }

    // Retrieve user's computer IP (to be able to ionic serve / hot reload)
    // Update the start_url in the trinity manifest
    // 
    // Clone the original manifest into a temporary manifest so that we don't touch user's original manifest.
    var originalManifestPath = manifestHelper.getManifestPath(ionicHelper.getConfig().assets_path)
    var temporaryManifestPath = manifestHelper.cloneToTemporaryManifest(originalManifestPath)
    if (noDebug)
        manifestHelper.updateManifestForLocalIndex(temporaryManifestPath)
    else
        await manifestHelper.updateManifestForRemoteIndex(temporaryManifestPath)

    return new Promise((resolve, reject)=>{
        ionicHelper.updateNpmDependencies().then(() => {
            ionicHelper.runIonicBuild(forProd).then(() => {
                dappHelper.packEPK(temporaryManifestPath).then((outputEPKPath)=>{
                    resolve(outputEPKPath)
                })
                .catch((err)=>{
                    console.error("Failed to pack your DApp into a EPK file".red)
                    reject(err)
                })          
            })
            .catch((err)=>{
                console.error("Failed run ionic build".red)
                reject(err)
            })          
        })
        .catch((err)=>{
            console.error("Failed to install ionic dependencies".red)
            reject(err)
        }) 
    })
}

/**
 * The process to run one of our ionic-based DApps on android is as following:
 * 
 * - Retrieve user's computer IP (to be able to ionic serve / hot reload)
 * - Update the start_url in the trinity manifest
 * - npm install
 * - ionic build
 * - sign_epk
 * - push and run the EPK on the device (adb push/shell am start, on android)
 * - ionic serve (for hot reload inside trinity, when user saves his files)
 */
async function deployAndroidDApp(noDebug, forProd) {
    var runHelper = new RunHelper()
    var ionicHelper = new IonicHelper()

    // Make sure mandatory dependencies are available
    if (!SystemHelper.checkIonicPresence()) {
        console.error("Error:".red, "Please first install IONIC on your computer.")
        return
    }
    if (!SystemHelper.checkADBPresence()) {
        console.error("Error:".red, "Please first install Android tools (especially ADB) on your computer.")
        return
    }
    if (!SystemHelper.checkPythonPresence()) {
        console.error("Error:".red, "Please first install Python on your computer.")
        return
    }

    runSharedDeploymentPhase(noDebug, forProd).then((outputEPKPath)=>{
        runHelper.androidUploadEPK(outputEPKPath).then(()=>{
            runHelper.androidInstallTempEPK().then(()=>{
                console.log("RUN OPERATION COMPLETED".green)
    
                if (!noDebug) {
                    console.log("NOW RUNNING THE APP FOR DEVELOPMENT".green)
                    console.log("Please wait until the ionic server is started before launching your DApp on your device.".magenta)
                    ionicHelper.runIonicServe()
                }
            })
            .catch((err)=>{
                console.error("Failed to install your DApp on your device".red)
                console.error("Error:",err)
            })
        })
        .catch((err)=>{
            console.error("Failed to upload your DApp to your device".red)
            console.error("Error:",err)
        })   
    })
}

/**
 * The process to run one of our ionic-based DApps on the iOS SIMULATOR is as following:
 * 
 * - Retrieve user's computer IP (to be able to ionic serve / hot reload)
 * - Update the start_url in the trinity manifest
 * - npm install
 * - ionic build
 * - pack_epk
 * - sign_epk
 * - push and run the EPK on the device (adb push/shell am start, on android)
 * - ionic serve (for hot reload inside trinity, when user saves his files)
 */
async function deployiOSDApp(noDebug, forProd) {
    var runHelper = new RunHelper()
    var ionicHelper = new IonicHelper()

    // Make sure mandatory dependencies are available
    if (!SystemHelper.checkIonicPresence()) {
        console.error("Error:".red, "Please first install IONIC on your computer.")
        return
    }
    if (!SystemHelper.checkXCodePresence()) {
        console.error("Error:".red, "Please first install XCode on your computer.")
        return
    }
    if (!SystemHelper.checkPythonPresence()) {
        console.error("Error:".red, "Please first install Python on your computer.")
        return
    }

    //let outputEPKPath = "/var/folders/d2/nw213ddn1c7g6_zcp5940ckw0000gn/T/temp.epk"
    runSharedDeploymentPhase(noDebug, forProd).then((outputEPKPath)=>{
        runHelper.getRunningSimulatorInfo().then((iosDeviceInfo)=>{
            runHelper.iosUploadEPK(outputEPKPath).then(()=>{
                runHelper.iosInstallTempEPK().then(()=>{
                    console.log("RUN OPERATION COMPLETED".green)
        
                    if (!noDebug) {
                        console.log("NOW RUNNING THE APP FOR DEVELOPMENT".green)
                        console.log("Please wait until the ionic server is started before launching your DApp on your device.".magenta)
                        ionicHelper.runIonicServe()
                    }
                })
                .catch((err)=>{
                    console.error("Failed to install your DApp on your device".red)
                    console.error("Error:",err)
                })
            })
            .catch((err)=>{
                console.error("Failed to upload your DApp to your device".red)
                console.error("Error:",err)
            })   
        })
        .catch((err)=>{
            console.error("Failed launch a ios simulator".red)
            console.error("Error:",err)
        })   
    })
}