#!/bin/bash

source common.sh

f_test() {
  fname=$1
  echo "file name           : $fname"
  echo "f_get_dirname       : $(f_get_dirname $fname)"
  echo "f_get_dirname2      : $(f_get_dirname2 $fname)"
  echo "f_get_fname         : $(f_get_fname $fname)"
  echo "f_get_fname2        : $(f_get_fname2 $fname)"
  echo "f_get_name          : $(f_get_name $fname)"
  echo "f_get_ext           : $(f_get_ext $fname)"
  echo "f_get_snapfname     : $(f_get_snapfname $fname)"
  echo "f_get_git_snapfname : $(f_get_git_snapfname $fname)"
}

f_test ${1:-"/a/b/c/d.txt"}

