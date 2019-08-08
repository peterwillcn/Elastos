#!/usr/bin/env node
var yargs = require('yargs');

/*
// To build subcommands: https://github.com/cubyn/ghm-cli/commit/3f354cf65e2784827acffe134a1593623a5ec703
*/
var argv = yargs.commandDir('commands')
  .demandCommand()
  .help()
  .argv
