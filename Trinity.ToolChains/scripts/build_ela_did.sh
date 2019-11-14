#!/bin/bash

# Exit immediately if a subsequent command exits with a non-zero status.
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ "$1" == "-v" ]; then
  VERBOSE=1
else
  VERBOSE=
fi

echo "#################### Building Elastos DID SDK ####################"
cd $SCRIPT_DIR
mkdir -p _build
cd _build
cmake -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=install \
      -DENABLE_SPVADAPTER=OFF \
      -DENABLE_TESTS=OFF \
      ../../../Dependency/Elastos.DID.Native.SDK/
cmake --build . --target install -- -j8 VERBOSE=${VERBOSE}

cd $SCRIPT_DIR
mkdir -p ../lib
cp -RP _build/install/lib/libeladid.*{dylib,so}* ../lib 2>/dev/null || true
