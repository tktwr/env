#!/bin/bash

# remove commas
f_rm_comma () { sed 's/,//g'; }

# compute the sum of the first column
f_sum () { awk '{sum+=$1}END{print sum}'; }

col=1
if [ -n "$1" ]; then
  col=$1
fi

grep -v '^#' | awk '{print $'$col'}' | f_rm_comma | f_sum

