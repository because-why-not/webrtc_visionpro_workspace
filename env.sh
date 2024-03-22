if [ -z "$DEPOT_TOOLS" ]; then
    DEPOT_TOOLS=`realpath ./depot_tools`
fi
if [ -z "$XCODE_PATH" ]; then
    XCODE_PATH="/Applications/Xcode.app"
fi
PATH=${DEPOT_TOOLS}:$PATH