
const path = require("path");
require("colors")

const ManifestHelper = require("../helpers/manifest.helper")
const IonicHelper = require("../helpers/ionic.helper")

exports.command = 'manifest'
exports.describe = 'Creates or update a Trinity manifest.json inside the ionic app project. Use this only if you want to enable an existing ionic app as a Trinity DApp'
exports.builder = {
}
exports.handler = function (argv) {
    launchManifestCreation()
}

function launchManifestCreation() {
    var manifestHelper = new ManifestHelper()
    var ionicHelper = new IonicHelper()

    manifestHelper.promptAppInformation().then((info)=>{
        // Manifest is created in the src/assets subfolder of current root folder
        var manifestDestinationPath =  manifestHelper.getManifestPath(ionicHelper.getConfig().assets_path)
        
        manifestHelper.createManifestWithInfo(info, manifestDestinationPath).then(()=>{
            console.log("OK - manifest.json has been created/updated.".green)
        })
        .catch((err)=>{
            console.error("Failed to save your information in the manifest".red)
            console.error("Error:", err)
        })
    })
    .catch((err)=>{
        console.error("Failed to collect information to generate the manifest".red)
        console.error("Error:", err)
    })
}