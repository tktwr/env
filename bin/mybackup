#!/bin/sh

source common.sh

for i in $*; do
  dst=`f_get_git_snapfname $i`
  f_eval "cp -a $i $MY_BACKUP/$dst"
done

