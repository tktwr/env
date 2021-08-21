#!/bin/bash

source bashrc.min.sh

FILES="\
$MY_ETC/fzy/dir.00.$MY_OS_NAME.txt \
$MY_COMMON_CONFIG/dir.00.$MY_OS_NAME.txt \
$HOME/.my/dir.00.$MY_OS_NAME.txt \
\
$MY_ETC/fzy/dir.01.usr.txt \
$MY_COMMON_CONFIG/dir.01.usr.txt \
$HOME/.my/dir.01.usr.txt \
\
$MY_ETC/fzy/dir.txt \
$MY_COMMON_CONFIG/dir.txt \
$HOME/.my/dir.txt \
"

$MY_PYTHON_EXE ./make.dir.py $FILES

