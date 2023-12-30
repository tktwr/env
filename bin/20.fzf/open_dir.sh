#!/bin/bash

# expand env variables
url=$(eval "echo $*")

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
