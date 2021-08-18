#!/bin/bash

source bashrc.min.sh

FILES="\
$MY_ETC/fzy/dir.00.$MY_OS_NAME.txt \
$MY_CONFIG/common/dir.00.$MY_OS_NAME.txt \
\
$MY_ETC/fzy/dir.01.usr.txt \
$MY_CONFIG/common/dir.01.usr.txt \
\
$MY_ETC/fzy/dir.txt \
$MY_CONFIG/common/dir.txt \
"

$MY_PYTHON_EXE ./make.dir.py $FILES

