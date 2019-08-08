const prompts = require('prompts');
const emailValidator = require("email-validator");
const fs = require("fs-extra");
const path = require("path");
const editJsonFile = require("edit-json-file");

module.exports = class NewAppHelper {
    /**
     * Prompts some information to user about his new application (app name, etc).
     * That will be used to customize the default DApp with a few basic information.
     */
    async promptAppInformation() {
        return new Promise(async (resolve, reject) => {
            const questions = [
                {
                    type: 'text',
                    name: 'appname',
                    message: 'Application title',
                    validate: value => {
                        return value != ""
                    }
                },
                {
                    type: 'text',
                    name: 'packagename',
                    message: 'Package name (ex: org.company.yourapp)',
                    validate: value => {
                        return value != "" && value.indexOf(".") >= 0
                    }
                },
                {
                    type: 'text',
                    name: 'description',
                    message: 'Short desription'
                },
                {
                    type: 'text',
                    name: 'author',
                    message: 'Author',
                    validate: value => {
                        return value != ""
                    }
                },
                {
                    type: 'text',
                    name: 'email',
                    message: "Author's email",
                    validate: value => {
                        return value != "" && emailValidator.validate(value)
                    }
                }
            ];
            
            const info = await prompts(questions);
            // => info => { username, age, about }

            resolve(info)
        })
    }

    /**
     * Creates a new folder by copying our template empty DApp to current user folder.
     * Folder name is the package name given by the user.
     */
    createFromDefaultAppTemplate(packageName) {
        return new Promise((resolve, reject) => {
            var targetAppFolderPath = path.join(process.cwd(), packageName)

            var rootScriptDirectory = path.dirname(require.main.filename)
            var templateAppFolderPath = path.join(rootScriptDirectory, "assets", "dapptemplate")

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

    /**
     * Customize a few things from our default template, to match user information
     */
    customizeNewUserAppWithInfo(info) {
        return new Promise((resolve, reject) => {
            var targetAppFolderPath = path.join(process.cwd(), info.packagename)
            var manifestFilePath = path.join(targetAppFolderPath, "manifest.json")
            var manifestJson = editJsonFile(manifestFilePath);
            
            manifestJson.set("id", info.packagename);
            manifestJson.set("name", info.appname);
            manifestJson.set("short_name", info.appname); // TODO: request both long name and short name from user?
            manifestJson.set("description", info.description);
            manifestJson.set("author.name", info.author);
            manifestJson.set("author.email", info.email);
            
            manifestJson.save(); // synchronous

            resolve()
        })
    }
}
