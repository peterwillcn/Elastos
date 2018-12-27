#!/usr/bin/env node
"use strict";

//
// This hook copies various resource files/folders
// from our version control system directories
// into the appropriate platform specific location
//

// CONFIGURE HERE
// configure all the files/directories to copy/merge.
// Key of object is the source file/directory,
// value is the destination location.
var folders_to_copy = [{
    "platform_res/android":
    "platforms/android"
},{
    "platform_res/ios":
    "platforms/ios"
}]
// no need to configure below

var fs = require('fs');
var path = require('path');

var rootdir = process.argv[2];

function copyFileSync( source, target ) {
    var targetFile = target;

    //if target is a directory a new file with the same name will be created
    if ( fs.existsSync( target ) ) {
        if ( fs.lstatSync( target ).isDirectory() ) {
            targetFile = path.join( target, path.basename( source ) );
        }
    }

    // console.log("copyFileSync: Copying " + source + " to " + targetFile);
    fs.createReadStream(source).pipe(
        fs.createWriteStream(targetFile));
}

function copyFolderRecursiveSync( source, target ) {
    var files = [];

    //check if folder needs to be created or integrated
    var targetFolder = path.join( target, path.basename( source ) );
    if ( !fs.existsSync( targetFolder ) ) {
        // console.log("copyFolderRecursiveSync: Making " + targetFolder);
        fs.mkdirSync( targetFolder );
    }

    //copy
    if ( fs.lstatSync( source ).isDirectory() ) {
        files = fs.readdirSync( source );
        files.forEach( function ( file ) {
            var curSource = path.join( source, file );
            if ( fs.lstatSync( curSource ).isDirectory() ) {
                copyFolderRecursiveSync( curSource, targetFolder );
            } else {
                copyFileSync( curSource, targetFolder );
            }
        } );
    }
}

folders_to_copy.forEach(function(obj) {
    Object.keys(obj).forEach(function(key) {
        var val = obj[key];

        if (process.env.CORDOVA_PLATFORMS
            && !process.env.CORDOVA_PLATFORMS.includes('ios')
            && val.startsWith("platforms/ios")) {
            console.log("Skipped IOS platform folder merging.");
            return;
        }

        var srcfile = path.join(rootdir, key);
        var destfile = path.join(rootdir, val);
        // console.log("Copying " + srcfile + " to " + destfile);
        var destdir = path.dirname(destfile);

        copyFolderRecursiveSync(srcfile, destdir);
    });
});
