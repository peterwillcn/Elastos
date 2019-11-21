const hasbin = require("hasbin");
const os = require("os");

module.exports = class SystemHelper {
    static checkIonicPresence() {
        console.log("Checking ionic presence")
        return hasbin.sync("ionic")
    }

    static checkADBPresence() {
        console.log("Checking adb presence")
        return hasbin.sync("adb")
    }

    static checkPythonPresence() {
        console.log("Checking python presence")
        return hasbin.sync("python")
    }

    static isWindowsHost() {
        return os.platform() === 'win32'
    }
}