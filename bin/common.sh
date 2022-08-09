#!/bin/bash

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
  case $fname in
    *.tar.gz)
      fname=${fname%.*}
      fname=${fname%.*}
      ;;
    *)
      fname=${fname%.*}
      ;;
  esac
  echo $fname
}

function f_get_ext() {
  local fname=`f_get_fname $1`
  local ext=""
  case $fname in
    *.tar.gz)
      ext="tar.gz"
      ;;
    *)
      ext=${fname##*.}
      ;;
  esac
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

function f_get_git_branch() {
  echo `git rev-parse --abbrev-ref HEAD 2>/dev/null`
}

function f_get_git_commit() {
  echo `git rev-parse --short HEAD 2>/dev/null`
}

function f_get_snapfname() {
  local name=`f_get_name $1`
  local d=`f_get_date $1`
  local t=`f_get_time $1`
  local ext=`f_get_ext $1`
  echo $name-$d-$t$ext
}

function f_get_git_snapfname() {
  local name=`f_get_name $1`
  local d=`f_get_date $1`
  local t=`f_get_time $1`
  local br=`f_get_git_branch $1`
  if [ "x$br" != "x" ]; then
    br="-$br"
  fi
  local cm=`f_get_git_commit $1`
  if [ "x$cm" != "x" ]; then
    cm="-$cm"
  fi
  local ext=`f_get_ext $1`
  echo $name-$d-$t$br$cm$ext
}

function f_eval() {
  cmd="$1"
  exec_flag=${2:-1}
  if [ $exec_flag -eq 1 ]; then
    echo "$cmd"
    eval "$cmd"
  else
    echo "$cmd [no exec]"
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

f_helptags() {
  vim -e -c 'helptags . | quit'
}

