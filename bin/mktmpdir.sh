#!/bin/bash

source common.sh

tmpdir=tmp.$(f_get_date)

if [ ! -d $tmpdir ]; then
  echo "make $tmpdir"
  mkdir $tmpdir
fi

