#!/bin/bash

source common.sh

output_dir=${1:-"."}

dirname=$(basename $(pwd))
fname=$output_dir/$(f_get_git_snapfname $dirname).tar.gz

git.sh archive HEAD --prefix=$dirname/ --output=$fname
echo $fname

