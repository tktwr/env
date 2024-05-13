#!/bin/bash

url=$(_f_expand "$*")

case $MY_OS_NAME in
  linux)
    #evince "$url"
    qpdfview --unique "$url"
    ;;
  *)
    open_web.sh "$url"
    ;;
esac
