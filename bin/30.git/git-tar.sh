#!/bin/bash
#
# cd git_dir
# git-tar.sh [dst_dir]
#
# OUTPUT:
#   dst_dir/git_dir-date-time-branch-commit.tar.gz

source common.sh

bin_name="git-tar.sh"
dst_dir=${1:-""}
dirname=$(basename $(pwd))
fname=./$(f_get_git_snapfname $dirname).tar.gz

git.sh archive HEAD --prefix=$dirname/ --output=$fname

echo "$bin_name:output: $fname"
if [ -f $fname -a -d "$dst_dir" ]; then
  echo "mv $fname $dst_dir"
  mv $fname "$dst_dir"
fi

