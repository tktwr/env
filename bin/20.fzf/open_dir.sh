#!/bin/bash

url=$(_f_expand "$*")

case $MY_OS_NAME in
  linux)
    exo-open --launch FileManager "$url"
    #nautilus "$url"
    ;;
  *)
    te.sh "$url"
    #explorer.sh "$url"
    ;;
esac
