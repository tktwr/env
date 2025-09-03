#!/bin/bash
#
# snap-tar.sh dst_dir/out_name dirs|files...

source common.sh

bin_name="snap-dir.sh"
dst_dir=$1-$(f_get_date)-$(f_get_time)
shift

if [ ! -d $dst_dir ]; then
  mkdir -p $dst_dir
fi

echo "$bin_name:output: $dst_dir"
cp -a --parents "$@" $dst_dir
