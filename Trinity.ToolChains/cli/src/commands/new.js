
const NewAppHelper = require("../helpers/newapp.helper")
const ManifestHelper = require("../helpers/manifest.helper")

exports.command = 'new'
exports.describe = 'Creates a new default Trinity DApp in current folder'
exports.builder = {
}
exports.handler = function (argv) {
    launchAppCreation()
}

function launchAppCreation() {
    var newAppHelper = new NewAppHelper()
    var manifestHelper = new ManifestHelper()

    manifestHelper.promptAppInformation().then((info)=>{
        newAppHelper.createFromDefaultAppTemplate(info.packagename).then(()=>{
            // Location at which to create the new manifest file
            var manifestDestinationPath = path.join(process.cwd(), "manifest.json")

            manifestHelper.customizeNewUserAppWithInfo(info, manifestDestinationPath).then(()=>{
                console.log("Congratulations! Your new Trinity DApp is ready. You can start coding now.")
                console.log("You can now enter your app folder (cd "+info.packagename+"), and call trinity-cli run to send your DApp on your device!")
            })
            .catch((err)=>{
                console.error("Failed to customize default template with your app information")
                console.error("Error:", err)
            })
        })
        .catch((err)=>{
            console.error("Failed to create your app using default template code")
            console.error("Error:", err)
        })
    })
    .catch((err)=>{
        console.error("Failed to collect information for your new application")
        console.error("Error:", err)
    })
}