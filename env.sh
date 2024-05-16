#!/bin/bash -e
if [ -z "$DEPOT_TOOLS" ]; then
    export DEPOT_TOOLS=`realpath ./depot_tools`
fi
echo "Using depot tools form ${DEPOT_TOOLS}"
if [ -z "$XCODE_PATH" ]; then
    export XCODE_PATH="/Applications/Xcode.app"
fi
echo "Using xcode form ${XCODE_PATH}"
if [[ ":$PATH:" != *":${DEPOT_TOOLS}:"* ]]; then
    export PATH=${DEPOT_TOOLS}:$PATH
    echo "Included depot tools into PATH"
fi