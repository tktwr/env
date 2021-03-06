#!/bin/bash

# jpyear [<year>]

f_jpyear () {
  local year=$1
  local nenngo
  local jpyear

  if [ $year -gt 2018 ]; then
    nenngo="reiwa"
    jpyear=`expr $year - 2018`
  elif [ $year -gt 1988 ]; then
    nenngo="heisei"
    jpyear=`expr $year - 1988`
  elif [ $year -gt 1925 ]; then
    nenngo="showa"
    jpyear=`expr $year - 1925`
  elif [ $year -gt 1911 ]; then
    nenngo="taisho"
    jpyear=`expr $year - 1911`
  elif [ $year -gt 1867 ]; then
    nenngo="meiji"
    jpyear=`expr $year - 1867`
  fi

  echo "$nenngo $jpyear"
}

if [ $# -eq 1 ]; then
  year=$1
else
  year=`env LC_TIME=C date '+%Y'`
fi

f_jpyear $year

