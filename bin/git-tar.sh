#!/bin/bash

source common.sh

DST_DIR=${1:-""}
DIR=$(pwd)
DIR=$(basename $DIR)
fname=$(f_get_git_snapfname $DIR).tar.gz

echo "DST_DIR: $DST_DIR"
echo "fname  : $fname"

git archive HEAD --prefix=$DIR/ --output=$fname

if [ -n "$DST_DIR" ]; then
  mv $fname $DST_DIR
fi

