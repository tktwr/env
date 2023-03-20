#!/bin/bash

f_cols() {
  cols=80
  which tput > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    cols=$(tput cols)
  fi
  echo $cols
}

if [ -n $COLUMNS ]; then
  echo $COLUMNS
else
  f_cols
fi
