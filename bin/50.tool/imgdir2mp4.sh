#!/bin/bash

f_imgdir2mp4() {
  img_dir="$1"
  ffmpeg -framerate 25 -pattern_type glob -i "$img_dir/*.png" -r 25 -crf 0 -c:v libx264 -pix_fmt yuv420p $img_dir.mp4
}

if [ $# -eq 0 ]; then
  for i in *; do
    f_imgdir2mp4 "$i"
  done
else
  for i in "$@"; do
    f_imgdir2mp4 "$i"
  done
fi
