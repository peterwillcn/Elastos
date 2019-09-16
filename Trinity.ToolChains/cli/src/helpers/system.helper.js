const hasbin = require("hasbin")

module.exports = class SystemHelper {
    static checkIonicPresence() {
        console.log("Checking ionic presence")
        return hasbin.sync("ionic")
    }

    static checkADBPresence() {
        console.log("Checking adb presence")
        return hasbin.sync("adb")
    }
}