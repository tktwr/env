#!/bin/bash

echo "=== [mymirrorfat.sh $@] ==="
rsync -avRC --delete -O --no-g --no-p --include='build.gradle' --exclude-from=$HOME/.rsync_exclude "$@"
