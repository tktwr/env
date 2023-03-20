#!/bin/bash

source common.sh

files="$@"

for i in $files; do
  o=$(f_get_name $i).txt
  f_eval "pdftotext $i $o"
done

