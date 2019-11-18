
const path = require("path")
require('colors')
const prompts = require("prompts")

const PublishingHelper = require("../helpers/publishing.helper")
const ManifestHelper = require("../helpers/manifest.helper")
const DAppHelper = require("../helpers/dapp.helper")
const IonicHelper = require("../helpers/ionic.helper")
const SystemHelper = require("../helpers/system.helper")

exports.command = 'publish'
exports.describe = 'Publishes the DApp on the DApp store'
exports.builder = {
    did: {
        alias: "d",
        describe: "DID string to be used to sign the application package (ex: did:ela:abcd#primary). Use the createdid command to create a DID if you don't have one yet.",
        require: true
    }
}
exports.handler = function (argv) {
    launchAppPublication(argv.did)
}

async function launchAppPublication(didURL) {
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

    // Prompt DID signature password
    console.log("")
    const questions = [
        {
            type: 'password',
            name: 'didPassword',
            message: 'DID Signature password (provided when you created your DID):',
            validate: value => {
                return value != ""
            }
        }
    ];
    let typedInfo = await prompts(questions);
    let didSignaturePassword = typedInfo.didPassword;

    // Update manifest with local url in case it had been configured for debugging earlier (ionic serve with remote url)
    var manifestPath = manifestHelper.getManifestPath(ionicHelper.getConfig().assets_path)
    manifestHelper.updateManifestForProduction(manifestPath)

    ionicHelper.updateNpmDependencies().then(() => {
        ionicHelper.runIonicBuild(true).then(() => {
            dappHelper.packEPK(manifestPath).then((outputEPKPath)=>{
                dappHelper.signEPK(outputEPKPath, didURL, didSignaturePassword).then((signedEPKPath)=>{
                    publishingHelper.publishToDAppStore(signedEPKPath).then((info)=>{
                        console.log("Congratulations! Your app has been submitted for review!".green)
                    })
                    .catch((err)=>{
                        console.error("Failed to publish your DApp...".red)
                        console.error("Error:".red, err)
                    })
                })
                .catch((err)=>{
                    console.error("Failed to publish your DApp (signing EPK - Invalid password?)...".red)
                    console.error("Error:".red, err)
                })
            })
            .catch((err)=>{
                console.error("Failed to publish your DApp (packaging EPK)...".red)
                console.error("Error:".red, err)
            })
        })
        .catch((err)=>{
            console.error("Failed run ionic build".red)
            console.error("Error:",err)
        })   
    })  
    .catch((err)=>{
        console.error("Failed to install ionic dependencies".red)
        console.error("Error:",err)
    })  
}