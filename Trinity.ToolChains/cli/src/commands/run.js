
const RunHelper = require("../helpers/run.helper")

exports.command = 'run'
exports.describe = 'Deploy current DApp to your connected device'
exports.builder = {
  platform: {
    alias: "p",
    describe: "Platform to deploy to (android|ios)",
    require: true
  },
  idkeystore: {
    alias: "id",
    describe: "Identity keystore file to be used to sign DApp EPK",
    require: true
  }
}
exports.handler = function (argv) {
    var platform = argv.platform
    var idKeystorePath = argv.idkeystore
    switch (platform) {
        case "android":
            deployAndroidDApp(idKeystorePath)
            break;
        case "ios":
            console.log("Not yet implemented")
            break;
        default:
            console.log("ERROR - Not a valid platform")
    }
}

function deployAndroidDApp(idKeystorePath) {
    var runHelper = new RunHelper()

    runHelper.packEPK().then((outputEPKPath)=>{
        runHelper.signEPK(outputEPKPath, idKeystorePath).then((outputEPKPath)=>{
            runHelper.androidUploadEPK(outputEPKPath).then(()=>{
                runHelper.androidInstallTempEPK().then(()=>{
                    console.log("RUN OPERATION COMPLETED")
                })
                .catch((err)=>{
                    console.error("Failre to install your DApp on your device")
                    console.error("Error:",err)
                })
            })
            .catch((err)=>{
                console.error("Failed to upload your DApp to your device")
                console.error("Error:",err)
            })
        })
        .catch((err)=>{
            console.error("Failed to sign your EPK file")
            console.error("Error:",err)
        })
    })
    .catch((err)=>{
        console.error("Failed to pack your DApp into a EPK file")
        console.error("Error:",err)
    })
}