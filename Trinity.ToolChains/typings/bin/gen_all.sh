#/bin/sh
dir=`dirname $0`
outdir=$dir/../dist
pluginsroot=$dir/../../../Elastos.Trinity/Plugins

echo "Copying AppManager types..."
cat $pluginsroot/AppManager/www/types.d.ts > $outdir/appmanager.d.ts
echo "Copying Carrier types..."
cat $pluginsroot/Carrier/www/types.d.ts > $outdir/carrier.d.ts
echo "Copying Wallet types..."
cat $pluginsroot/Wallet/www/types.d.ts > $outdir/wallet.d.ts
echo "Copying DID types..."
cat $pluginsroot/DID/www/types.d.ts > $outdir/did.d.ts
echo "Copying Hive types..."
cat $pluginsroot/Hive/www/types.d.ts > $outdir/hive.d.ts

echo ""
echo "DONE - Don't forget to publish this new version on NPM!"