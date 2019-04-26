#!/bin/bash

# Exit immediately if a subsequent command exits with a non-zero status.
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $SCRIPT_DIR
mkdir -p _build
cd _build
cmake ..
cmake --build . --target install -- -j8
