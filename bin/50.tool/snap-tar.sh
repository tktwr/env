#!/bin/bash
#
# snap-tar.sh dst_dir out_name dirs|files...

source common.sh

bin_name="snap-tar.sh"
dst_dir="$1"  ; shift
out_name="$1" ; shift

out_tar=$(f_get_snapfname ${out_name}.tar.gz)
tar czf $out_tar "$@"

echo "$bin_name:output: $out_tar"
if [ -f $out_tar -a -d "$dst_dir" ]; then
  echo "$bin_name:mv $out_tar $dst_dir"
  mv $out_tar "$dst_dir"
fi

