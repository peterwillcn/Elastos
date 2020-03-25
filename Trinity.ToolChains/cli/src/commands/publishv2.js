
const path = require("path")
require('colors')
const prompts = require("prompts")

const PublishingHelper = require("../helpers/publishing.helper")
const ManifestHelper = require("../helpers/manifest.helper")
const DAppHelper = require("../helpers/dapp.helper")
const IonicHelper = require("../helpers/ionic.helper")
const SystemHelper = require("../helpers/system.helper")
const DIDHelper = require("../helpers/did.helper");

exports.command = 'publishv2'
exports.describe = 'Publishes the DApp on the DApp store'
exports.builder = {
    news: {
        alias: "n",
        describe: "Short sentence about what's new in this application version.",
        require: true
    },
}
exports.handler = function (argv) {
    launchAppPublication(argv.news);
}

async function launchAppPublication(whatsNew) {
    var publishingHelper = new PublishingHelper()
    var manifestHelper = new ManifestHelper()
    var dappHelper = new DAppHelper()

    if (!dappHelper.checkFolderIsDApp()) {
        console.error("ERROR".red + " - " + dappHelper.noManifestErrorMessage())
        return
    }

    var ionicHelper = new IonicHelper()

    // Make sure mandatory dependencies are available
    if (!SystemHelper.checkIonicPresence()) {
        console.error("Error:".red, "Please first install IONIC on your computer.")
        return
    }
    if (!SystemHelper.checkPythonPresence()) {
        console.error("Error:".red, "Please first install Python on your computer.")
        return
    }

    // Update manifest with local url in case it had been configured for debugging earlier (ionic serve with remote url)
    var originalManifestPath = manifestHelper.getManifestPath(ionicHelper.getConfig().assets_path)
    // Clone the original manifest into a temporary manifest so that we don't touch user's original manifest.
    var temporaryManifestPath = manifestHelper.cloneToTemporaryManifest(originalManifestPath)
    manifestHelper.updateManifestForProduction(temporaryManifestPath)

    //ionicHelper.updateNpmDependencies().then(() => {
    //    ionicHelper.runIonicBuild(true).then(() => {
        publishingHelper.startDeveloperDAppToolServer(temporaryManifestPath, whatsNew).then(()=>{
            console.log("Congratulations, the publishing process was completed successfully.".green)
        })
        /*.catch((err)=>{
            console.error("Failed run ionic build".red)
            console.error("Error:",err)
        })   
    })  
    .catch((err)=>{
        console.error("Failed to install ionic dependencies".red)
        console.error("Error:",err)
    })  */
}