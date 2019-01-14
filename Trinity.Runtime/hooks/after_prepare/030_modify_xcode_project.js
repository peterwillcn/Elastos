#!/usr/bin/env node
"use strict";

if (process.env.CORDOVA_PLATFORMS
    && !process.env.CORDOVA_PLATFORMS.includes('ios')) {
    console.log("Skipped modify XCode project for non-IOS platform.")
    process.exit(0)
}

let xcode = require('xcode'),
    fs = require('fs'),
    path = require('path'),
    runtimeProjPath = 'platforms/ios/Elastos.xcodeproj/project.pbxproj',
    runtimeProj = xcode.project(runtimeProjPath),
    cordovaProjPath = 'platforms/ios/CordovaLib/CordovaLib.xcodeproj/project.pbxproj',
    cordovaProj = xcode.project(cordovaProjPath);

runtimeProj.parse(function (err) {
    //
    // Embed frameworks and binaries
    //
    let embed = true;
    let existsEmbedFrameworks = runtimeProj.buildPhaseObject('PBXCopyFilesBuildPhase', 'Embed Frameworks');
    if (!existsEmbedFrameworks && embed) {
        // "Embed Frameworks" Build Phase (Embedded Binaries) does not exist, creating it.
        runtimeProj.addBuildPhase([], 'PBXCopyFilesBuildPhase', 'Embed Frameworks', null, 'frameworks');
    }

    let options = { customFramework: true, embed: embed };
    runtimeProj.addFramework('RealmSwift.framework', options);
    runtimeProj.addFramework('Realm.framework', options);
    runtimeProj.addFramework('libz.tbd');


    //
    // Add build settings
    //
    runtimeProj.addToBuildSettings("SWIFT_VERSION", "4.2");
    runtimeProj.addToBuildSettings("PRODUCT_BUNDLE_IDENTIFIER", "org.elastos.trinity.runtime");


    //
    // Add and remove source files in the Classes group
    //
    let classesGroupKey = runtimeProj.findPBXGroupKeyAndType({ name: 'Classes' }, 'PBXGroup');

    runtimeProj.removeSourceFile("AppDelegate.h",        {}, classesGroupKey);
    runtimeProj.removeSourceFile("AppDelegate.m",        {}, classesGroupKey);
    runtimeProj.removeSourceFile("MainViewController.h", {}, classesGroupKey);
    runtimeProj.removeSourceFile("MainViewController.m", {}, classesGroupKey);

    let classesPath = "../../../../platform_src/ios/Elastos/Classes/";
    runtimeProj.addSourceFile(classesPath + "AppDelegate.h",                {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "AppDelegate.m",                {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "AppBasePlugin.swift",          {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "AppInfo.swift",                {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "AppInstaller.swift",           {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "AppManager.swift",             {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "AppViewController.swift",      {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "AppWhitelist.swift",           {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "LauncherViewController.swift", {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "MainViewController.swift",     {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "ManagerDBAdapter.swift",       {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "NullPlugin.swift",             {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "TrinityPlugin.h",              {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "TrinityPlugin.m",              {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "TrinityURLProtocol.swift",     {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "TrinityViewController.swift",  {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "Utility.swift",                {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "WhitelistFilter.swift",        {}, classesGroupKey);

    //
    // Add header and source files for "SSZipArchive"
    //
    let sourceDirectory = "platforms/ios/SSZipArchive";

    function fromDir(startPath,filter,callback){
        if (!fs.existsSync(startPath)){
            console.log("no dir ",startPath);
            return;
        }

        let files=fs.readdirSync(startPath);
        for(let i=0;i<files.length;i++){
            let filename = files[i];
            let filepath = path.join(startPath,filename);
            let stat = fs.lstatSync(filepath);
            if (stat.isDirectory()){
                callback(startPath, filename);
                fromDir(filepath,filter,callback); //recurse
            }
            else if (filter.test(filepath)) callback(startPath, filename);
        };
    };

    fromDir(sourceDirectory,/(\.h$|\.m$|\.c$)/,function(startPath,filename){
        let filepath = path.join(startPath,filename);
        let relativePath = startPath.replace(/platforms\/ios\//g, '');

        let parentGroupName = path.basename(relativePath);
        let parentGroupKey = runtimeProj.findPBXGroupKeyAndType({ name: parentGroupName }, 'PBXGroup');
        if (!parentGroupKey) {
            let parentGroupPath = '"' +parentGroupName + '"';
            let newGroup = runtimeProj.addPbxGroup([], parentGroupName, parentGroupPath, 'SOURCE_ROOT');
            let customTemplate = runtimeProj.findPBXGroupKeyAndType({ name: 'CustomTemplate' }, 'PBXGroup');
            runtimeProj.addToPbxGroup(newGroup.uuid, customTemplate, 'PBXGroup');
            parentGroupKey = newGroup.uuid;
        }

        let stat = fs.lstatSync(filepath);
        if (stat.isDirectory()){
            let groupName = filename;
            let groupPath = '"' + path.join(relativePath, groupName) + '"';
            let newGroup = runtimeProj.addPbxGroup([], groupName, groupPath, 'SOURCE_ROOT');
            runtimeProj.addToPbxGroup(newGroup.uuid, parentGroupKey, 'PBXGroup');
            return;
        } else {
            let groupName = path.basename(startPath);
            let groupKey = runtimeProj.findPBXGroupKeyAndType({ name: groupName }, 'PBXGroup');
            if (groupKey) {
                runtimeProj.addSourceFile(filename, {}, groupKey);
            }
        }
    });


    //
    // Add a "Run Script" build phase
    //
    options = {
        shellPath: '/bin/sh',
        shellScript: 'bash "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/Realm.framework/strip-frameworks.sh"'
    };
    runtimeProj.addBuildPhase([], 'PBXShellScriptBuildPhase', 'Run Script', runtimeProj.getFirstTarget().uuid, options).buildPhase;


    //
    // Write back the new XCode project
    //
    fs.writeFileSync(runtimeProjPath, runtimeProj.writeSync());
});

cordovaProj.parse(function (err) {
    //
    // Make the "CDVIntentAndNavigationFilter.h" file public
    //
    let uuid;
    for (uuid in cordovaProj.pbxBuildFileSection()) {
        if (cordovaProj.pbxBuildFileSection()[uuid].fileRef_comment == 'CDVIntentAndNavigationFilter.h') {
            let file = cordovaProj.pbxBuildFileSection()[uuid];
            file.settings =  { ATTRIBUTES: [ 'Public' ] };
        }
    }


    //
    // Write back the new XCode project
    //
    fs.writeFileSync(cordovaProjPath, cordovaProj.writeSync());
});
