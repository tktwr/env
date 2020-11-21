#!/bin/bash

echo "=== [mymirrorfat.sh $@] ==="
rsync -avRC --delete --size-only -O --no-g --no-p --exclude 'imgui.ini' "$@"

