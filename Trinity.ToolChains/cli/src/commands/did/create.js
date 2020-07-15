
const path = require("path")
require("colors")

const SystemHelper = require("../../helpers/system.helper")
const DIDHelper = require("../../helpers/did.helper")

exports.command = 'create'
exports.describe = 'Creates a new DID store with an initial DID (DID + keypair). Needed to publish your DApp'
exports.builder = {
}
exports.handler = function (argv) {
    launchCreateDID()
}

async function launchCreateDID() {
    var didHelper = new DIDHelper()

    console.log("")
    console.log("In order to be published to a DApps store, your DApp has to be signed with a DID.".green)
    console.log("This DID signature is the unique identity for your DApp and should never be lost.".green)
    console.log("After your DApp DID is created, you will use it during the publishing process.".green)
    console.log("Do NOT make the private key part of this DID public, keep it safe.".magenta)
    console.log("")
    console.log("DID files are created locally, but the base DID information has to be published on the DID sidechain.".green)
    console.log("For this, you will have to scan a QR code from Trinity and pay a very small fee.".green)
    console.log("You will need at least 0.01 ELA on the DID sidechain. Please manage this with the Trinity wallet DApp.".green)
    console.log("")

    if (!SystemHelper.checkPythonPresence()) {
        console.error("Error:".red, "Please first install Python on your computer.")
        return
    }

    didHelper.createDID().then((createdDidInfo)=>{
        didHelper.createDIDRequest(createdDidInfo.password, createdDidInfo.did).then((didRequest)=>{
            didHelper.generateCreateDIDDocumentTransactionURL(didRequest).then((schemeUrl)=>{
                didHelper.generatePayForTransactionQRCodeWebPage(schemeUrl).then((webpagePath)=>{
                    didHelper.promptAndOpenQRCodeWebPage(webpagePath).then(()=>{
                        didHelper.waitForSidechainTransactionCompleted(createdDidInfo.did).then(()=>{
                            console.log("DID creation is completed.".green)
                        })
                        .catch((err)=>{
                            console.error("Something wrong while checking DID operation on chain".red)
                            console.error("Error:", err)
                        })
                    })
                    .catch((err)=>{
                        console.error("Something wrong trying to launch the web page".red)
                        console.error("Error:", err)
                    })
                })
                .catch((err)=>{
                    console.error("Failed to create the QR code page to upload the DID on chain".red)
                    console.error("Error:", err)
                })
            })
            .catch((err)=>{
                console.error("Failed to create the DID document to upload the DID on chain".red)
                console.error("Error:", err)
            })
        })
        .catch((err)=>{
            console.error("Failed to create the DID request to upload the DID on chain".red)
            console.error("Error:", err)
        })
    })
    .catch((err)=>{
        console.error("Failed to create the DID".red)
        console.error("Error:", err)
    })
}