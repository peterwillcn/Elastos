#/bin/sh
dir=`dirname $0`
outdir=$dir/../dist
pluginsroot=$dir/../../../Elastos.Trinity/Plugins

echo "Copying AppManager types..."
cat $pluginsroot/AppManager/www/types.d.ts > $outdir/appmanager.d.ts
echo "Copying Carrier types..."
cat $pluginsroot/Carrier/www/types.d.ts > $outdir/carrier.d.ts

echo ""
echo "DONE - Don't forget to publish this new version on NPM!"