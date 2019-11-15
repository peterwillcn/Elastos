
const path = require("path")
require("colors")

const NewAppHelper = require("../helpers/newapp.helper")
const ManifestHelper = require("../helpers/manifest.helper")
const IonicHelper = require("../helpers/ionic.helper")

exports.command = 'new'
exports.describe = 'Creates a new default Trinity DApp in current folder using one of the default templates (angular / react)'
exports.builder = {
}
exports.handler = function (argv) {
    launchAppCreation()
}

function launchAppCreation() {
    var newAppHelper = new NewAppHelper()
    var manifestHelper = new ManifestHelper()
    var ionicHelper = new IonicHelper()

    manifestHelper.promptAppInformation().then((info)=>{

        newAppHelper.createFromDefaultAppTemplate(info.packagename, info.framework, info.template).then(()=>{

            var manifestPath = manifestHelper.getManifestPath(ionicHelper.getConfig(info.packagename).assets_path, info.packagename)

            manifestHelper.createManifestWithInfo(info, manifestPath).then(()=>{
                console.log("Congratulations! Your new Trinity DApp is ready. You can start coding now.".green)
                console.log("You can now enter your app folder (cd ".green+info.packagename+"), and call trinity-cli run to send your DApp on your device!".green)
            })
            .catch((err)=>{
                console.error("Failed to customize default template with your app information".red)
                console.error("Error:", err)
            })
        })
        .catch((err)=>{
            console.error("Failed to create your app using default template code".red)
            console.error("Error:", err)
        })
    })
    .catch((err)=>{
        console.error("Failed to collect information for your new application".red)
        console.error("Error:", err)
    })
}