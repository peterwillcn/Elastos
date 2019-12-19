
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
    // TODO: Create root private key from given mnemonic + password
    // TODO: Sync from the DID sidechain to retrieve previously published DIDs

    console.log("This feature is not implemented yet.");
}