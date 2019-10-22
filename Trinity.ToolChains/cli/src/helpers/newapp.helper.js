const fs = require("fs-extra");
const path = require("path");

module.exports = class NewAppHelper {
    /**
     * Creates a new folder by copying our template empty DApp to current user folder.
     * Folder name is the package name given by the user.
     */
    createFromDefaultAppTemplate(packageName, framework, template) {
        return new Promise((resolve, reject) => {
            var targetAppFolderPath = path.join(process.cwd(), packageName)

            var rootScriptDirectory = path.dirname(require.main.filename)
            var templateAppFolderPath = path.join(rootScriptDirectory, "assets/dapptemplate/" + framework + "/" + template)

            // Make sure the fodler we want to create does not exist yet.
            if (fs.existsSync(targetAppFolderPath)) {
                reject("It seems like you already have a folder named "+packageName+". We wouldn't want to break any existing thing...")
                return
            }
            // Create new app folder
            fs.mkdirSync(targetAppFolderPath)

            // Copy template app content into that folder
            fs.copySync(templateAppFolderPath, targetAppFolderPath)

            resolve()
        })
    }
}
