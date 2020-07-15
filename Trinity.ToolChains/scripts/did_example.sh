#!/bin/bash

# Exit immediately if a subsequent command exits with a non-zero status.
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $SCRIPT_DIR
if [ ! -f "../lib/libeladid.so.1" ] && [ ! -f "../lib/libeladid.1.dylib" ]; then
    echo "Please build the DID SDK first."
    echo "    1. Checkout the DID SDK into Elastos.Trinity/Dependency/Elastos.DID.Native.SDK"
    echo "    2. And then run the build script: Elastos.Trinity/ToolChains/scripts/build_ela_did.sh"
    exit 1
fi

tmp_dir=$(mktemp -d /tmp/eladid.XXXXXX) || exit 1
echo "Created a tempporary directory: $tmp_dir"

echo -e "\nCreate DID"
output=$(../bin/create_did --root $tmp_dir/my_did_store_root --mnemonic "cloth always junk crash fun exist stumble shift over benefit fun toe" --passphrase mypassphrase --storepass mystorepass)

# Extract the DID URL from the output of the create_did script
DIDURL=$(echo "$output" | sed -n 's/.*"\(did:elastos:.*\)".*/\1/p')
echo "The newly created DID URL: $DIDURL"

echo -e "\nDID Sign"
../bin/did_sign --root $tmp_dir/my_did_store_root --didurl "$DIDURL" --storepass mystorepass ../tests/epks/fortest1.epk -o $tmp_dir/fortest1_signed.epk

echo -e "\nDID Verify"
../bin/did_verify --root $tmp_dir/my_did_store_root $tmp_dir/fortest1_signed.epk

echo -e "\nCleanup..."
if [[ $tmp_dir == /tmp/eladid.* ]]; then
    echo "Remove the tempporary directory: $tmp_dir"
    rm -rf $tmp_dir
fi
echo "Done"
