#!/bin/bash

WHICH_PYTHON=`which python`
PYTHON_PATH=`cygpath -w $WHICH_PYTHON | sed 's+[\]+\\\\\\\\+g'`

echo $PYTHON_PATH

