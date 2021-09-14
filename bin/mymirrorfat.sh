#!/bin/bash

EXCLUDES="\
  -C \
  --include 'build.gradle'  \
  --exclude 'imgui.ini' \
  --exclude '*.blend1'  \
  --exclude 'build*'  \
  --exclude 'output*'  \
  "

echo "=== [mymirrorfat.sh $@] ==="
eval "rsync -avR --delete --size-only -O --no-g --no-p $EXCLUDES $@"

