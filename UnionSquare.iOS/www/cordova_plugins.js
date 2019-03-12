cordova.define('cordova/plugin_list', function(require, exports, module) {
module.exports = [
  {
    "id": "ElaJava2JSBridge.Java2JSBridge",
    "file": "plugins/ElaJava2JSBridge/www/Java2JSBridge.js",
    "pluginId": "ElaJava2JSBridge",
    "clobbers": [
      "cordova.plugins.Java2JSBridge"
    ]
  },
  {
    "id": "ElaWallet.Wallet",
    "file": "plugins/ElaWallet/www/Wallet.js",
    "pluginId": "ElaWallet",
    "clobbers": [
      "cordova.plugins.Wallet"
    ]
  },
  {
    "id": "cordova-clipboard.Clipboard",
    "file": "plugins/cordova-clipboard/www/clipboard.js",
    "pluginId": "cordova-clipboard",
    "clobbers": [
      "cordova.plugins.clipboard"
    ]
  },
  {
    "id": "cordova-plugin-device.device",
    "file": "plugins/cordova-plugin-device/www/device.js",
    "pluginId": "cordova-plugin-device",
    "clobbers": [
      "device"
    ]
  },
  {
    "id": "cordova-plugin-filechooser.FileChooser",
    "file": "plugins/cordova-plugin-filechooser/www/fileChooser.js",
    "pluginId": "cordova-plugin-filechooser",
    "clobbers": [
      "fileChooser"
    ]
  },
  {
    "id": "cordova-plugin-ionic-keyboard.keyboard",
    "file": "plugins/cordova-plugin-ionic-keyboard/www/ios/keyboard.js",
    "pluginId": "cordova-plugin-ionic-keyboard",
    "clobbers": [
      "window.Keyboard"
    ]
  },
  {
    "id": "cordova-plugin-ionic-webview.ios-wkwebview-exec",
    "file": "plugins/cordova-plugin-ionic-webview/src/www/ios/ios-wkwebview-exec.js",
    "pluginId": "cordova-plugin-ionic-webview",
    "clobbers": [
      "cordova.exec"
    ]
  },
  {
    "id": "cordova-plugin-qrscanner.QRScanner",
    "file": "plugins/cordova-plugin-qrscanner/www/www.min.js",
    "pluginId": "cordova-plugin-qrscanner",
    "clobbers": [
      "QRScanner"
    ]
  },
  {
    "id": "cordova-plugin-splashscreen.SplashScreen",
    "file": "plugins/cordova-plugin-splashscreen/www/splashscreen.js",
    "pluginId": "cordova-plugin-splashscreen",
    "clobbers": [
      "navigator.splashscreen"
    ]
  },
  {
    "id": "cordova-sqlite-storage.SQLitePlugin",
    "file": "plugins/cordova-sqlite-storage/www/SQLitePlugin.js",
    "pluginId": "cordova-sqlite-storage",
    "clobbers": [
      "SQLitePlugin"
    ]
  }
];
module.exports.metadata = 
// TOP OF METADATA
{
  "ElaJava2JSBridge": "1",
  "ElaWallet": "1.0.0",
  "cordova-clipboard": "1.2.1",
  "cordova-plugin-add-swift-support": "1.7.2",
  "cordova-plugin-device": "2.0.2",
  "cordova-plugin-filechooser": "1.0.1",
  "cordova-plugin-ionic-keyboard": "2.0.5",
  "cordova-plugin-ionic-webview": "1.1.19",
  "cordova-plugin-qrscanner": "2.6.0",
  "cordova-plugin-splashscreen": "5.0.2",
  "cordova-plugin-whitelist": "1.3.3",
  "cordova-sqlite-storage": "2.3.1"
};
// BOTTOM OF METADATA
});
