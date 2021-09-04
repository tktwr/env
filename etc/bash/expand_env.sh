#!/bin/bash

source bashrc_min.sh

FILES="\
$MY_FZY/dir.00.$MY_OS_NAME.txt \
$MY_COMMON_SETTING/dir.00.$MY_OS_NAME.txt \
$MY_DOTMY/dir.00.$MY_OS_NAME.txt \
\
$MY_FZY/dir.01.usr.txt \
$MY_COMMON_SETTING/dir.01.usr.txt \
$MY_DOTMY/dir.01.usr.txt \
\
$MY_FZY/dir.txt \
$MY_COMMON_SETTING/dir.txt \
$MY_DOTMY/dir.txt \
"

$MY_PYTHON_EXE ./expand_env.py $FILES

