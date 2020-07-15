exports.command = 'did <command>'
exports.desc = 'Manage DID for signing dApps'
exports.builder = function (yargs) {
  return yargs.commandDir('did')
}
exports.handler = function (argv) {}