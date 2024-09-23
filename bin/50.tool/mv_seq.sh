#!/bin/bash
#
# USAGE:
#   mv_seq.sh img_ *.png
#
# OUTPUT:
#   img_00001.png ...

source common.sh

prefix=$1
shift
nr=1

for i in "$@"; do
  ext=$(f_get_ext "$i")
  dst_fname=$(printf '%s%05d%s' $prefix $nr $ext)
  echo "mv \"$i\" \"$dst_fname\""
  cp "$i" "$dst_fname"
  nr=$((nr + 1))
done
