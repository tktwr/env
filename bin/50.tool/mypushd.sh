#!/bin/bash

PUSHDRC=$HOME/.my/pushdrc.sh

if [ -f $PUSHDRC ]; then
  source $PUSHDRC
fi

f_help() {
  echo "mypushd.sh [OPTIONS]"
  echo
  echo "OPTIONS:"
  echo "  --help    , print help"
  echo "  --set DIR , set DIR"
  echo "  --get     , get DIR"
  echo
  echo "ENVS:"
  echo "  MY_PUSHD_DIR=$MY_PUSHD_DIR"
}

f_set() {
  echo "export MY_PUSHD_DIR=$1"
}

case $1 in
  --help)
    f_help
    ;;
  --set)
    shift
    f_set "$@" > $PUSHDRC
    ;;
  --get)
    echo $MY_PUSHD_DIR
    ;;
esac

