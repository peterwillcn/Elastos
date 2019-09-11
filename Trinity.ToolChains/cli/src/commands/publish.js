
const path = require("path")
const colors = require('colors')

const PublishingHelper = require("../helpers/publishing.helper")
const ManifestHelper = require("../helpers/manifest.helper")
const DAppHelper = require("../helpers/dapp.helper")
const IonicHelper = require("../helpers/ionic.helper")

exports.command = 'publish'
exports.describe = 'Publishes the DApp on the DApp store'
exports.builder = {
}
exports.handler = function (argv) {
    var idKeystorePath = argv.idkeystore
    launchAppCreation(idKeystorePath)
}

function launchAppCreation(idKeystorePath) {
    var publishingHelper = new PublishingHelper()
    var manifestHelper = new ManifestHelper()
    var dappHelper = new DAppHelper()
    var ionicHelper = new IonicHelper()

    if (!dappHelper.checkFolderIsDApp()) {
        console.error("ERROR".red + " - " + manifestHelper.noManifestErrorMessage())
        return
    }
    // Update manifest with local url in case it had been configured for debugging earlier (ionic serve with remote url)
    var manifestPath = path.join(process.cwd(), "src", "assets", "manifest.json")
    manifestHelper.updateManifestForProduction(manifestPath)

    ionicHelper.updatedNpmDependencies().then(() => {
        ionicHelper.runIonicBuildDev().then(() => {
            dappHelper.packEPK(manifestPath).then((outputEPKPath)=>{
                dappHelper.signEPK(outputEPKPath, idKeystorePath).then(()=>{
                    publishingHelper.publishToDAppStore(outputEPKPath, idKeystorePath).then((info)=>{
                        console.log("Congratulations! Your app has been submitted for review!".green)
                    })
                    .catch((err)=>{
                        console.error("Failed to publish your DApp...".red)
                        console.error("Error:".red, err)
                    })
                })
                .catch((err)=>{
                    console.error("Failed to publish your DApp (signing EPK)...".red)
                    console.error("Error:".red, err)
                })
            })
            .catch((err)=>{
                console.error("Failed to publish your DApp (packaging EPK)...".red)
                console.error("Error:".red, err)
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