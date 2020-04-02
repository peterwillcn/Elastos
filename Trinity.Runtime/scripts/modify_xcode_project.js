var fs = require('fs');
var join = require('path').join;

"use strict";

module.exports = function(ctx) {
  // console.log(JSON.stringify(ctx, null, 2));
  console.log("Running modify_xcode_project.js");

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
    // Build phase to strip invalid framework files ARCHs for itunes publication
    //
    let stripBuildPhaseCommand = "APP_PATH=\"${TARGET_BUILD_DIR}/${WRAPPER_NAME}\"\n\n# This script loops through the frameworks embedded in the application and\n# removes unused architectures.\nfind \"$APP_PATH\" -name '*.framework' -type d | while read -r FRAMEWORK\ndo\n    FRAMEWORK_EXECUTABLE_NAME=$(defaults read \"$FRAMEWORK/Info.plist\" CFBundleExecutable)\n    FRAMEWORK_EXECUTABLE_PATH=\"$FRAMEWORK/$FRAMEWORK_EXECUTABLE_NAME\"\n    echo \"Executable is $FRAMEWORK_EXECUTABLE_PATH\"\n\n    EXTRACTED_ARCHS=()\n\n    for ARCH in $ARCHS\n    do\n        echo \"Extracting $ARCH from $FRAMEWORK_EXECUTABLE_NAME\"\n        if lipo -extract \"$ARCH\" \"$FRAMEWORK_EXECUTABLE_PATH\" -o \"$FRAMEWORK_EXECUTABLE_PATH-$ARCH\"\n        then\n            EXTRACTED_ARCHS+=(\"$FRAMEWORK_EXECUTABLE_PATH-$ARCH\")\n        else\n            EXTRACTED_ARCHS+=(\"$FRAMEWORK_EXECUTABLE_PATH\")\n        fi\n    done\n\n    echo \"Merging extracted architectures: ${ARCHS}\"\n    lipo -o \"$FRAMEWORK_EXECUTABLE_PATH-merged\" -create \"${EXTRACTED_ARCHS[@]}\"\n    rm \"${EXTRACTED_ARCHS[@]}\"\n\n    echo \"Replacing original executable with thinned version\"\n    rm \"$FRAMEWORK_EXECUTABLE_PATH\"\n    mv \"$FRAMEWORK_EXECUTABLE_PATH-merged\" \"$FRAMEWORK_EXECUTABLE_PATH\"\n\ndone\n";
    var stripOptions = {
      shellPath: '/bin/sh',
      shellScript: stripBuildPhaseCommand
    };
    runtimeProj.addBuildPhase([], 'PBXShellScriptBuildPhase', 'Strip non-target ARCHS from fat frameworks for publishing', null, stripOptions);

    //
    // Add build settings
    //
    runtimeProj.addToBuildSettings("SWIFT_VERSION", "4.2");
    runtimeProj.addToBuildSettings("PRODUCT_BUNDLE_IDENTIFIER", "org.elastos.trinity.runtime");
    runtimeProj.addToBuildSettings("CLANG_CXX_LANGUAGE_STANDARD", "\"c++0x\"");

    //
    // Set SWIFT_OPTIMIZATION_LEVEL -Onone for Debug
    //
    runtimeProj.updateBuildProperty('SWIFT_OPTIMIZATION_LEVEL', '"-Onone"', 'Debug');

    //
    // Add and remove source files in the Classes group
    //
    let classesGroupKey = runtimeProj.findPBXGroupKeyAndType({ name: 'Classes' }, 'PBXGroup');

    runtimeProj.removeSourceFile("AppDelegate.h",        {}, classesGroupKey);
    runtimeProj.removeSourceFile("AppDelegate.m",        {}, classesGroupKey);
    runtimeProj.removeSourceFile("MainViewController.h", {}, classesGroupKey);
    runtimeProj.removeSourceFile("MainViewController.m", {}, classesGroupKey);
    runtimeProj.removeSourceFile("MainViewController.xib", {}, classesGroupKey);

    // let classesPath = "../../../../platform_src/ios/elastOS/Classes/";
    let classesPath = process.cwd() + "/platform_src/ios/elastOS/Classes/";

    let files = fs.readdirSync(classesPath);
    // var paths = [];
    files.forEach((filename, index) => {
        if (filename[0] != ".") {
            let pathname = path.join(classesPath, filename)
            let stat = fs.statSync(pathname);
            if (stat.isFile() === true) {
                // console.log(pathname);
                // paths.push(pathname);
                runtimeProj.addSourceFile(pathname, {}, classesGroupKey);
            }
        }
    });
    // runtimeProj.addPbxGroup(paths, process.cwd() + "/platforms/ios/elastOS/Classes/abc", "abc");

    // runtimeProj.addSourceFile(classesPath + "AppDelegate.h",                {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "AppDelegate.m",                {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "AdvancedButton.swift",         {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "AdvancedButton.xib",           {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "ApiAuthorityManager.swift",   {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "AppBasePlugin.swift",          {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "AppInfo.swift",                {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "AppInstaller.swift",           {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "AppManager.swift",             {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "AppViewController.swift",      {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "AppWhitelist.swift",           {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "CDVPlugin.swift",              {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "CLIService.swift",             {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "ConfigManager.swift",          {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "DIDVerifier.swift",            {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "IntentActionChooserController.swift",  {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "IntentActionChooserController.xib",    {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "IntentActionChooserItemView.swift",    {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "IntentActionChooserItemView.xib",      {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "IntentManager.swift",          {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "LauncherViewController.swift", {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "Log.swift",                    {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "MainViewController.swift",     {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "ManagerDBAdapter.swift",       {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "NullPlugin.swift",             {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "PermissionManager.swift",      {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "PreferenceManager.swift",      {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "TitleBarPlugin.swift",         {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "TitleBarView.swift",           {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "TitleBarView.xib",             {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "TitleBarMenuItemView.swift",   {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "TitleBarMenuItemView.xib",     {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "TitleBarMenuView.swift",       {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "TitleBarMenuView.xib",         {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "TrinityPlugin.h",              {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "TrinityPlugin.m",              {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "TrinityURLProtocol.swift",     {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "TrinityViewController.swift",  {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "TrinityViewController.xib",    {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "Utility.swift",                {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "WhitelistFilter.swift",        {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "WrapSwift.h",                  {}, classesGroupKey);
    // runtimeProj.addSourceFile(classesPath + "WrapSwift.m",                  {}, classesGroupKey);


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
