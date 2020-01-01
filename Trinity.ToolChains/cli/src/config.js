const fs = require("fs-extra")
const path = require("path")
const lodash = require("lodash")

// Prod config
let config = {
    "dappstore":{
        "host":"https://dapp-store.elastos.org"
        //"host":"http://localhost:5200"
    }
}

// During dev, we can use a custom configuration file that overwrites some of the prod configs
let customConfigPath = path.join(__dirname, "..", "src", "server.config.json")

if (fs.existsSync(customConfigPath)) {
    console.log("NOTE: Using custom local config file to overwrite default configuration")
    let customConfig = require(customConfigPath)

    lodash.merge(config, customConfig)
}

console.log("Using DApp store endpoint "+config.dappstore.host)

module.exports = config
