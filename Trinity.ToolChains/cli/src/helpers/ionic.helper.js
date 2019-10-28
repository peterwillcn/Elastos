const path = require("path")
const fs = require("fs-extra");

module.exports = class IonicHelper {
    /**
     * Run "npm install" to retrieve latest versions of npm dependencies
     */
    updateNpmDependencies() {
        return new Promise((resolve, reject) => {
            console.log("Updating NPM modules for the ionic application...")

            const spawn = require("child_process").spawn;
            const process = spawn('npm',["install"]);

            process.stdout.on('data', function (data) { console.log(''+data)});
            process.stderr.on('data', function (data) { console.log(''+data)});
            process.on('error', function(err) { reject(err)})

            process.on('exit', function (code) {
                if (code == 0) {
                    // Operation completed successfully
                    console.log("Successfully updated NPM dependencies for the ionic application")
                    resolve()
                }
                else {
                    console.log("Failed to update NPM dependencies for the ionic application")
                    console.log('ERROR - child process exited with code ' + code);
                    reject()
                }
            });
        })
    }

     /**
     * Project stucture is different between Angular and React templates
     */
    getConfig(packagename = '') {
        var config = JSON.parse(fs.readFileSync(path.join(process.cwd(), packagename, "ionic.config.json")))

        const options = {
            angular: {
                dist_path: 'www',
                assets_path: 'src'
            },
            react: {
                dist_path: 'build',
                assets_path: 'public'
            }
        }

        return options[config.type]
    }

    /**
     * Simply runs "ionic build" in order to generate the www/ folder before deployment.
     */
    runIonicBuildDev() {
        return new Promise((resolve, reject) => {
            console.log("Building the ionic app...")

            const spawn = require("child_process").spawn;
            const process = spawn('ionic',["build"]); // Build for development

            process.stdout.on('data', function (data) { console.log(''+data)});
            process.stderr.on('data', function (data) { console.log(''+data)});
            process.on('error', function(err) { console.log(err); reject(err)})

            process.on('exit', function (code) {
                if (code == 0) {
                    // Operation completed successfully
                    console.log("Ionic application has been built")
                    resolve()
                }
                else {
                    console.log('ERROR - child process exited with code ' + code);
                    reject()
                }
            });
        })
    }

    runIonicServe() {
        return new Promise((resolve, reject) => {
            console.log("Running ionic serve for hot reload...")

            const spawn = require("child_process").spawn;
            const process = spawn('ionic',["serve","--no-open","--address","0.0.0.0","--consolelogs"]);

            process.stdout.on('data', function (data) { console.log(''+data)});
            process.stderr.on('data', function (data) { console.log(''+data)});
            process.on('error', function(err) { reject(err)})

            process.on('exit', function (code) {
                if (code == 0) {
                    // Operation completed successfully
                    resolve()
                }
                else {
                    console.log('ERROR - child process exited with code ' + code);
                    reject()
                }
            });
        })
    }
}