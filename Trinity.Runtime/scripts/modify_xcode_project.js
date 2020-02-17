"use strict";

module.exports = function(ctx) {
  // console.log(JSON.stringify(ctx, null, 2));

  // make sure ios platform is part of platform add
  if (!ctx.opts.platforms.some((val) => val.startsWith("ios"))) {
    return;
  }

  const fs = require('fs'),
        path = require('path'),
        xcode = require('xcode');

  let runtimeProjPath = 'platforms/ios/elastOS.xcodeproj/project.pbxproj',
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

    let options = { customFramework: true, embed: embed, sign: true };
    runtimeProj.addFramework('libz.tbd');


    //
    // Add build settings
    //
    runtimeProj.addToBuildSettings("SWIFT_VERSION", "4.2");
    runtimeProj.addToBuildSettings("PRODUCT_BUNDLE_IDENTIFIER", "org.elastos.trinity.runtime");
    runtimeProj.addToBuildSettings("CLANG_CXX_LANGUAGE_STANDARD", "\"c++0x\"");


    //
    // Add and remove source files in the Classes group
    //
    let classesGroupKey = runtimeProj.findPBXGroupKeyAndType({ name: 'Classes' }, 'PBXGroup');

    runtimeProj.removeSourceFile("AppDelegate.h",        {}, classesGroupKey);
    runtimeProj.removeSourceFile("AppDelegate.m",        {}, classesGroupKey);
    runtimeProj.removeSourceFile("MainViewController.h", {}, classesGroupKey);
    runtimeProj.removeSourceFile("MainViewController.m", {}, classesGroupKey);

    let classesPath = "../../../../platform_src/ios/elastOS/Classes/";
    runtimeProj.addSourceFile(classesPath + "AdvancedButton.swift",         {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "AdvancedButton.xib",           {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "AppDelegate.h",                {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "AppDelegate.m",                {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "AppBasePlugin.swift",          {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "AppInfo.swift",                {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "AppInstaller.swift",           {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "AppManager.swift",             {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "AppViewController.swift",      {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "AppWhitelist.swift",           {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "CDVPlugin.swift",              {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "ConfigManager.swift",          {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "IntentManager.swift",          {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "LauncherViewController.swift", {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "MainViewController.swift",     {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "ManagerDBAdapter.swift",       {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "NullPlugin.swift",             {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "PermissionManager.swift",      {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "TitleBarView.swift",           {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "TitleBarView.xib",             {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "TrinityPlugin.h",              {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "TrinityPlugin.m",              {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "TrinityURLProtocol.swift",     {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "TrinityViewController.swift",  {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "TrinityViewController.xib",    {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "Utility.swift",                {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "WhitelistFilter.swift",        {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "WrapSwift.h",                  {}, classesGroupKey);
    runtimeProj.addSourceFile(classesPath + "WrapSwift.m",                  {}, classesGroupKey);

    //
    // Add header and source files for "SSZipArchive"
    //
    let sourceDirectory = "platforms/ios/SSZipArchive";
    let customTemplate = runtimeProj.findPBXGroupKeyAndType({ name: 'CustomTemplate' }, 'PBXGroup');

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

    function fromDirCallback(startPath,filename){
      let filepath = path.join(startPath,filename);
      let relativePath = startPath.replace(/platforms\/ios\//g, '');

      let parentGroupName = path.basename(relativePath);
      let parentGroupKey = runtimeProj.findPBXGroupKeyAndType({ name: parentGroupName }, 'PBXGroup');
      if (!parentGroupKey) {
        let parentGroupPath = '"' +parentGroupName + '"';
        let newGroup = runtimeProj.addPbxGroup([], parentGroupName, parentGroupPath, 'SOURCE_ROOT');
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
    }

    fromDir(sourceDirectory,/(\.h$|\.m$|\.c$)/,fromDirCallback);

    //
    // Add files for "SQLite.xcodeproj"
    //
    runtimeProj.addSourceFile("SQLite.swift-0.11.5/SQLite.xcodeproj", {}, customTemplate);

    options = {
      sourceTree: 'BUILT_PRODUCTS_DIR',
      customFramework: true,
      embed: embed,
      sign: true
    };
    runtimeProj.addFramework('SQLite.framework', options);

    //
    // Write back the new XCode project
    //
    console.log("Writing to " + runtimeProjPath);
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
    console.log("Writing to " + cordovaProjPath);
    fs.writeFileSync(cordovaProjPath, cordovaProj.writeSync());
  });
}
