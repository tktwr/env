#!/bin/bash

dpi=300
#dpi=150

f_pdf2imgdir() {
  pdf_file="$1"
  img_dir=${pdf_file%.*}

  if [ -f "$pdf_file" -a ! -d "$img_dir" ]; then
    echo "[$img_dir]"
    mkdir -p "$img_dir"
    cd "$img_dir"
    pdftocairo -jpeg -r $dpi ../"$pdf_file" img
    cd ..
  fi
}

if [ $# -eq 0 ]; then
  for i in *; do
    f_pdf2imgdir "$i"
  done
else
  for i in "$@"; do
    f_pdf2imgdir "$i"
  done
fi
