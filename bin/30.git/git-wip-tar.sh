#!/bin/bash

source common.sh

output_dir=${1:-"."}

dirname=$(basename $(pwd))
fname=$output_dir/wip-$(f_get_git_snapfname $dirname).tar.gz

tar czvf $fname $(git.sh diff --name-only)
echo $fname

