
const path = require("path")
require("colors")

const SystemHelper = require("../../helpers/system.helper")
const DIDHelper = require("../../helpers/did.helper")

exports.command = 'import'
exports.describe = 'Imports a saved mnemonic to re-create a root private signature and restore DIDs from the DID sidechain'
exports.builder = {
}
exports.handler = function (argv) {
    importAll()
}

async function importAll() {
    var didHelper = new DIDHelper()

    if (!SystemHelper.checkPythonPresence()) {
        console.error("Error:".red, "Please first install Python on your computer.")
        return
    }

    console.log("");
    console.log("Please provide information below so your DID can be imported.");
    console.log("IMPORTANT - Your password must be the same as the one you used to create the DID, as it is also used as a passphrase.".magenta);
    console.log("");

    didHelper.promptMnemonicWithPassword().then(({mnemonic, password})=>{
        console.log("");
        didHelper.importDID(mnemonic, password, password).then((createdDidInfo)=>{
            console.log("");
            console.log("Reminder of your DID information:")
            console.log("")
            console.log("YOUR DID: ".green+createdDidInfo.did)
            console.log("YOUR MNEMONIC: ".green+createdDidInfo.mnemonic)
            console.log("")
        })
        .catch((err)=>{
            console.error("Failed to create the DID".red)
            console.error("Error:", err)
        });
    })
    .catch((err)=>{
        console.error("Failed to create retrieve information to import your DID".red)
        console.error("Error:", err)
    });
}