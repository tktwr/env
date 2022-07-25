#!/bin/bash

WINOPT="-O --no-g --no-p"
EXCLUDES="\
  --include 'build.gradle' \
  --exclude 'imgui.ini' \
  --exclude '*.blend?' \
  --exclude '*.BLEND?' \
  --exclude 'build*' \
  --exclude '_output' \
  --exclude '_local' \
  --exclude '__pycache__' \
  "

echo "=== [mymirrorfat.sh $@] ==="
eval "rsync -avRC --delete $WINOPT $EXCLUDES $@"

