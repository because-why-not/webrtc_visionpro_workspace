if [ -z "$_ENV_ME_ONCE" ]; then
    export _ENV_ME_ONCE=1
    if [ -z "$DEPOT_TOOLS" ]; then
        export DEPOT_TOOLS=`realpath ./depot_tools`
    fi
    echo "Using depot tools form ${DEPOT_TOOLS}"
    if [ -z "$XCODE_PATH" ]; then
        export XCODE_PATH="/Applications/Xcode.app"
    fi
    echo "Using xcode form ${XCODE_PATH}"
    PATH=${DEPOT_TOOLS}:$PATH

fi