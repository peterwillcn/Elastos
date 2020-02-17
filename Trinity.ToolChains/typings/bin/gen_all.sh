#/bin/sh
dir=`pwd`/`dirname $0`
outdir=$dir/../dist
pluginsroot=$dir/../../../Plugins
runtimeroot=$dir/../../../Runtime
runtimepluginsroot=$runtimeroot/plugins

if [ ! -d $pluginsroot ] 
then
    echo "Directory $pluginsroot does not exist." 
    exit -1
fi

if [ ! -d $runtimepluginsroot ] 
then
    echo "Directory $runtimepluginsroot does not exist." 
    exit -1
fi

echo ""
echo -e "\033[32m#########################\033[0m"
echo -e "\033[32m#### ELASTOS PLUGINS ####\033[0m"
echo -e "\033[32m#########################\033[0m"
echo "Copying AppManager types..."
cat $runtimeroot/plugins_src/AppManager/www/types.d.ts > $outdir/appmanager.d.ts
echo "Copying Carrier types..."
cat $pluginsroot/Carrier/www/types.d.ts > $outdir/carrier.d.ts
echo "Copying Wallet types..."
cat $pluginsroot/Wallet/www/types.d.ts > $outdir/wallet.d.ts
echo "Copying DID types..."
cat $pluginsroot/DID/www/types.d.ts > $outdir/did.d.ts
echo "Copying Hive types..."
cat $pluginsroot/Hive/www/types.d.ts > $outdir/hive.d.ts
echo "Copying Fingerprint types..."
cat $pluginsroot/Fingerprint/www/types.d.ts > $outdir/fingerprint.d.ts

echo ""
echo -e "\033[32m#########################\033[0m"
echo -e "\033[32m#### CORDOVA PLUGINS ####\033[0m"
echo -e "\033[32m#########################\033[0m"
# cordova-clipboard
echo "Copying Clipboard types..."
echo -e "\033[31mNO TS TYPES YET !\033[0m"
# cordova-plugin-battery-status
echo "Copying Battery status types..."
cat $runtimepluginsroot/cordova-plugin-battery-status/types/index.d.ts > $outdir/cordova-plugin-battery-status.d.ts
# cordova-plugin-camera
echo "Copying Camera types..."
cat $runtimepluginsroot/cordova-plugin-camera/types/index.d.ts > $outdir/cordova-plugin-camera.d.ts
# cordova-plugin-device
echo "Copying Device types..."
cat $runtimepluginsroot/cordova-plugin-device/types/index.d.ts > $outdir/cordova-plugin-device.d.ts
# cordova-plugin-device-motion
echo "Copying Device Motion types..."
cat $runtimepluginsroot/cordova-plugin-device-motion/types/index.d.ts > $outdir/cordova-plugin-device-motion.d.ts
# cordova-plugin-dialogs
echo "Copying Dialogs types..."
cat $runtimepluginsroot/cordova-plugin-dialogs/types/index.d.ts > $outdir/cordova-plugin-dialogs.d.ts
# cordova-plugin-file
echo "Copying File types..."
cat $runtimepluginsroot/cordova-plugin-file/types/index.d.ts > $outdir/cordova-plugin-file.d.ts
# cordova-plugin-flashlight
echo "Copying Flashlight types..."
echo -e "\033[31mNO TS TYPES YET !\033[0m"
# cordova-plugin-geolocation
echo "Copying Geolocation types..."
echo -e "\033[31mNO TS TYPES YET !\033[0m"
# cordova-plugin-ionic-keyboard
echo "Copying Ionic Keyboard types..."
echo -e "\033[31mNO TS TYPES YET !\033[0m"
# cordova-plugin-media-capture
echo "Copying Media capture types..."
cat $runtimepluginsroot/cordova-plugin-media-capture/types/index.d.ts > $outdir/cordova-plugin-media-capture.d.ts
# cordova-plugin-network-information
echo "Copying Network information types..."
cat $runtimepluginsroot/cordova-plugin-network-information/types/index.d.ts > $outdir/cordova-plugin-network-information.d.ts
# cordova-plugin-screen-orientation
echo "Copying Screen orientation types..."
echo -e "\033[31mNO TS TYPES YET !\033[0m"
# cordova-plugin-splashscreen
echo "Copying Splashscreen types..."
cat $runtimepluginsroot/cordova-plugin-splashscreen/types/index.d.ts > $outdir/cordova-plugin-splashscreen.d.ts
# cordova-plugin-statusbar
echo "Copying Statusbar types..."
cat $runtimepluginsroot/cordova-plugin-statusbar/types/index.d.ts > $outdir/cordova-plugin-statusbar.d.ts
# cordova-plugin-vibration
echo "Copying Vibration types..."
cat $runtimepluginsroot/cordova-plugin-vibration/types/index.d.ts > $outdir/cordova-plugin-vibration.d.ts
# elastos-trinity-plugins-media
echo "Copying Media types..."
cat $runtimepluginsroot/elastos-trinity-plugins-media/types/index.d.ts > $outdir/elastos-trinity-plugins-media.d.ts
# elastos-trinity-plugins-qrscanner
echo "Copying QRScanner types..."
echo -e "\033[31mNO TS TYPES YET !\033[0m"

echo ""
echo -e "\033[35mDONE - Don't forget to publish this new version on NPM!\033[0m"