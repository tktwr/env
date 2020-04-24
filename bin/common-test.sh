#!/bin/bash

source common.sh

echo "dirname: " `f_get_dirname $1`
echo "fname: " `f_get_fname $1`
echo "name: " `f_get_name $1`
echo "ext: " `f_get_ext $1`
echo "snapfname: " `f_get_snapfname $1`
echo "git_snapfname: " `f_get_git_snapfname $1`
