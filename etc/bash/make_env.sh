#!/bin/bash

source bashrc_zero.sh
source bashrc_min.sh

FILES="\
$MY_FZY/dir.00.sys.txt \
$MY_COMMON_SETTING/fzy/dir.00.sys.txt \
$MY_DOTMY/fzy/dir.00.sys.txt \
\
$MY_FZY/dir.01.usr.txt \
$MY_COMMON_SETTING/fzy/dir.01.usr.txt \
$MY_DOTMY/fzy/dir.01.usr.txt \
\
$MY_FZY/dir.txt \
$MY_COMMON_SETTING/fzy/dir.txt \
$MY_DOTMY/fzy/dir.txt \
"

case $MY_OS_NAME in
  wsl|linux)
    opt="-p /mnt"
    ;;
esac

$MY_PYTHON_EXE ./expand_env.py $opt $FILES

