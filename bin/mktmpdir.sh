#!/bin/bash

source common.sh

name=${1:-"tmp"}
tmpdir=$name.$(f_get_date)

if [ ! -d $tmpdir ]; then
  echo "make $tmpdir"
  mkdir $tmpdir
else
  echo "$tmpdir already exists."
fi

