#!/bin/bash

export PATH="$SYS_BLENDER:$PATH"

case $MY_OS_NAME in
  wsl|msys|gitbash)
    exec $WINPTY blender.exe "$@"
    ;;
  linux)
    exec $WINPTY blender-softwaregl "$@"
    ;;
esac
