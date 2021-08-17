#!/bin/bash

source bashrc.min.sh

FILES="\
$MY_REMOTE_CONFIG/env/etc/fzy/dir.00.$MY_OS_NAME.txt \
$MY_LOCAL_CONFIG/env/etc/fzy/dir.00.$MY_OS_NAME.txt \
$MY_PRIVATE_CONFIG/env/etc/fzy/dir.00.$MY_OS_NAME.txt \
$MY_HOME/.my.common/dir.00.$MY_OS_NAME.txt \
\
$MY_REMOTE_CONFIG/env/etc/fzy/dir.01.usr.txt \
$MY_LOCAL_CONFIG/env/etc/fzy/dir.01.usr.txt \
$MY_PRIVATE_CONFIG/env/etc/fzy/dir.01.usr.txt \
$MY_HOME/.my.common/dir.01.usr.txt \
\
$MY_REMOTE_CONFIG/env/etc/fzy/dir.txt \
$MY_LOCAL_CONFIG/env/etc/fzy/dir.txt \
$MY_PRIVATE_CONFIG/env/etc/fzy/dir.txt \
$MY_HOME/.my.common/dir.txt \
"

$MY_PYTHON_EXE ./make.dir.py $FILES

