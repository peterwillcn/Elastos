
const path = require("path")
require('colors')
const prompts = require("prompts")

const PublishingHelper = require("../helpers/publishing.helper")
const ManifestHelper = require("../helpers/manifest.helper")
const DAppHelper = require("../helpers/dapp.helper")
const IonicHelper = require("../helpers/ionic.helper")
const SystemHelper = require("../helpers/system.helper")
const DIDHelper = require("../helpers/did.helper");

exports.command = 'publish'
exports.describe = 'Publishes the DApp on the DApp store'
exports.builder = {
    did: {
        alias: "d",
        describe: "DID string to be used to sign the application package (ex: did:ela:abcd#primary). Use the createdid command to create a DID if you don't have one yet.",
        require: true
    },
    didstore: {
        alias: "s",
        describe: "Optional path to the DID store. Will default to ./"+DIDHelper.DEFAULT_DID_STORE_FOLDER_NAME+".",
        require: false
    },
    password: {
        alias: "p",
        describe: "Optional DID store password. If not provided, it will be prompted.",
        require: false
    },
    news: {
        alias: "n",
        describe: "Short sentence about what's new in this application version.",
        require: true
    },
}
exports.handler = function (argv) {
    launchAppPublication(argv.did, argv.didstore, argv.password, argv.news);
}

async function launchAppPublication(didURL, didStorePath, password, whatsNew) {
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
    let didSignaturePassword = null;
    if (password) {
        // Password provided, not need to prompt.
        didSignaturePassword = password;
    }
    else {
        // No password provided: prompt user.
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
        didSignaturePassword = typedInfo.didPassword;
    }

    // Update manifest with local url in case it had been configured for debugging earlier (ionic serve with remote url)
    var originalManifestPath = manifestHelper.getManifestPath(ionicHelper.getConfig().assets_path)
    // Clone the original manifest into a temporary manifest so that we don't touch user's original manifest.
    var temporaryManifestPath = manifestHelper.cloneToTemporaryManifest(originalManifestPath)
    manifestHelper.updateManifestForProduction(temporaryManifestPath)

    ionicHelper.updateNpmDependencies().then(() => {
        ionicHelper.runIonicBuild(true).then(() => {
            dappHelper.packEPK(temporaryManifestPath).then((outputEPKPath)=>{
                dappHelper.signEPK(outputEPKPath, didURL, didSignaturePassword, didStorePath).then((signedEPKPath)=>{
                    publishingHelper.publishToDAppStore(signedEPKPath, didURL, whatsNew).then((info)=>{
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