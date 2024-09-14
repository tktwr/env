#!/bin/bash

source common.sh

output_dir=${1:-"."}

dirname=$(basename $(pwd))
fname=$output_dir/wip-$(f_get_git_snapfname $dirname).diff

git.sh diff > $fname
echo $fname

