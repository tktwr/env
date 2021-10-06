#!/bin/bash

WINOPT="\
  --size-only -O --no-g --no-p \
  "
EXCLUDES="\
  --include 'build.gradle' \
  --exclude 'imgui.ini' \
  --exclude '*.blend1' \
  --exclude '*.BLEND1' \
  --exclude 'build*' \
  --exclude '_output' \
  --exclude '_local' \
  "

echo "=== [mymirrorfat.sh $@] ==="
eval "rsync -avRC --delete $WINOPT $EXCLUDES $@"

