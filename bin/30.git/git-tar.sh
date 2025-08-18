#!/bin/bash

source common.sh

#output_dir=${1:-"."}
output_dir=.

dirname=$(basename $(pwd))
fname=$output_dir/$(f_get_git_snapfname $dirname).tar.gz

git.sh archive HEAD --prefix=$dirname/ --output=$fname
echo "output: $fname"

if [ -f $fname ]; then
  echo "mv $fname $1"
  mv $fname $1
fi

