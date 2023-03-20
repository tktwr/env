#!/bin/bash

source common.sh

dst_dir=$1-$(f_get_date)-$(f_get_time)
shift

if [ ! -d $dst_dir ]; then
  mkdir -p $dst_dir
fi

echo $dst_dir
cp -a --parents "$@" $dst_dir
