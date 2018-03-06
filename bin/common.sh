#!/bin/sh

EXEC=1

# to handle filenames including spaces
#IFS=\


function f_get_dirname() {
  #echo ${1%/*}
  echo `dirname $1`
}

function f_get_fname() {
  echo ${1##*/}
}

function f_get_name() {
  local fname=`f_get_fname $1`
  echo ${fname%%.*}
}

function f_get_ext() {
  local fname=`f_get_fname $1`
  local ext=${fname#*.}
  if [ $ext == $fname ]; then
    echo
  else
    echo .$ext
  fi
}

function f_get_date() {
  echo `env LC_TIME=C date '+%Y%m%d'`
}

function f_get_time() {
  echo `env LC_TIME=C date '+%H%M%S'`
}

function f_get_snapfname() {
  local name=`f_get_name $1`
  local d=`f_get_date $1`
  local t=`f_get_time $1`
  local ext=`f_get_ext $1`
  echo $name-$d-$t$ext
}

function f_eval() {
  echo $*
  if [ $EXEC -eq 1 ]; then
    eval $*
  fi
}

function f_mkdir() {
  if [ ! -d $1 ]; then
    f_eval "mkdir $1"
  fi
}

function f_rm() {
  if [ -f $1 ]; then
    f_eval "rm -f $1"
  fi
}

function f_rmdir() {
  if [ -d $1 ]; then
    f_eval "rm -rf $1"
  fi
}

