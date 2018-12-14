#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

for file in ${SCRIPT_DIR}/patches/*.patch
do
    patch -sfp1 -F 0 --no-backup-if-mismatch -d platforms < "$file"
done

