#!/bin/bash

source common.sh

dirname=$(basename $(pwd))
fname=$(f_get_git_snapfname $dirname).tar.gz

git archive HEAD --prefix=$dirname/ --output=$fname
echo $fname

