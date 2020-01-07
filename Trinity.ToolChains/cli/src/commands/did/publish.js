
const path = require("path")
require("colors")
const prompts = require("prompts");

const SystemHelper = require("../../helpers/system.helper")
const DIDHelper = require("../../helpers/did.helper")

exports.command = 'publish'
exports.describe = 'Publishes an existing DID to the DID sidechain (for example, in case it has not been published during the creation process).'
exports.builder = {
    didurl: {
        alias: "d",
        describe: "DID URL of the DID you want to publish. (ex: did:elastos:abcdef#primary).",
        require: true
    }
}
exports.handler = function (argv) {
    launchPublishDID(argv.didurl);
}

async function launchPublishDID(didUrlToPublish) {
    var didHelper = new DIDHelper();

    console.log("")
    console.log("You are about to publish your DID to the DID sidechain.".green)
    console.log("For this, you will have to scan a QR code from Trinity and pay a very small fee.".green)
    console.log("You will need at least 0.01 ELA on the DID sidechain. Please manage this with the Trinity wallet DApp.".green)
    console.log("")

    if (!SystemHelper.checkPythonPresence()) {
        console.error("Error:".red, "Please first install Python on your computer.")
        return
    }

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

    didHelper.createDIDRequest(didSignaturePassword, didUrlToPublish).then((didRequest)=>{
        didHelper.generateCreateDIDDocumentTransactionURL(didRequest).then((schemeUrl)=>{
            didHelper.generatePayForTransactionQRCodeWebPage(schemeUrl).then((webpagePath)=>{
                didHelper.promptAndOpenQRCodeWebPage(webpagePath).then(()=>{
                    didHelper.waitForSidechainTransactionCompleted(didUrlToPublish).then(()=>{
                        console.log("DID publication is completed.".green)
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
}