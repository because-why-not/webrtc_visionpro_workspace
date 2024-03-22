
HASH_FILE=.githash
set -e
source ./env.sh

sync_and_exit() {
    pushd ./src > /dev/null
    gclient sync
    #store hash for next execution
    git rev-parse HEAD > ../$HASH_FILE    
    popd > /dev/null
    exit 0
}

#no hash file -> never ran before
if [ ! -f "$HASH_FILE" ]; then
    echo "gclient sync never performed. Triggering gclient sync.";    
    sync_and_exit
fi



#git reports local changes -> we run every time to ensure no local changes are ignored
if [[ -n $(cd ./src && git status --porcelain) ]]; then 
    echo "WebRTC src folder is dirty. Triggering gclient sync.";    
    sync_and_exit
fi


GIT_REAL_HASH=$(cd ./src && git rev-parse HEAD)


GIT_STORED_HASH=$(cat $HASH_FILE)

#if the git hash changed we need to run again
if [ "$GIT_REAL_HASH" != "$GIT_STORED_HASH" ]; then
	echo "WebRTC checkout is different. Stored hash is $GIT_REAL_HASH and repository is $GIT_STORED_HASH. Triggering gclient sync."
    sync_and_exit
fi

echo "Skipping gclient sync. No changes detected"
