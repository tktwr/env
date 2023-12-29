#!/bin/bash

case $MY_OS_NAME in
  linux)
    #nautilus "$@"
    exo-open --launch FileManager "$@"
    ;;
  *)
    te.sh "$@"
    #explorer.sh "$@"
    ;;
esac
