#/bin/sh
dir=`dirname $0`
outfile=$dir/../dist/index.d.ts
pluginsroot=$dir/../../../Elastos.Trinity/Plugins

# Empty the existing file, or create one
echo "" > $outfile

echo "Copying AppManager types..."
cat $pluginsroot/AppManager/www/types.d.ts >> $outfile

echo ""
echo "DONE - Don't forget to publish this new version on NPM!"