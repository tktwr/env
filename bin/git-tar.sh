#!/bin/sh

source common.sh

DIR=`pwd`
DIR=`basename $DIR`
fname=`f_get_git_snapfname $DIR`
git archive HEAD "$@" --prefix=$DIR/ --output=$fname.tar.gz

