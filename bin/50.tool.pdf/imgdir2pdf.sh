#!/bin/bash

dpi=300dpix300dpi
#dpi=150dpix150dpi

f_imgdir2pdf() {
  img_dir="$1"
  pdf_file="$1".pdf

  if [ -d "$img_dir" -a ! -f "$pdf_file" ]; then
    echo "[$img_dir]"
    img2pdf -o "$pdf_file" --imgsize $dpi $(fdfind --type=f . "$img_dir")
  fi
}

if [ $# -eq 0 ]; then
  for i in *; do
    f_imgdir2pdf "$i"
  done
else
  for i in "$@"; do
    f_imgdir2pdf "$i"
  done
fi
