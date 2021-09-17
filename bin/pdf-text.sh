#!/bin/bash

source common.sh

files="$@"

for i in $files; do
  name=`f_get_name $i`
  f_eval "pdftotext $i $name.txt"
done

