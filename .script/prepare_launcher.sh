#!/bin/bash

BACKUP_DIRNAME=`pwd`
SCRIPT_PATH="$(cd "$(dirname "$0")/.." && pwd -P )"
PROJECT_DIRNAME="$(dirname "${SCRIPT_PATH}")"

if [ ! -d $PROJECT_DIRNAME"/Elastos.Trinity.DApps.Launcher" ];then
    git clone --depth=50 --branch=feat_launcher https://github.com/elastos/Elastos.Trinity.DApps.Launcher.git $PROJECT_DIRNAME/Elastos.Trinity.DApps.Launcher
fi

cd $PROJECT_DIRNAME/Elastos.Trinity.DApps.Launcher
echo "update Elastos.Trinity.DApps.Launcher..."
git pull

npm install

echo "ionic build --prod"
ionic build --prod

echo "copy launcher & demos..."
cp -rf demos/* ../Elastos.Trinity.Runtime/www/built-in/
cp -rf www/* ../Elastos.Trinity.Runtime/www/launcher_demo/

cd $BACKUP_DIRNAME
