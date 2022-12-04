#!/bin/bash

func() {
  i=1
  f=1.5
  bt=true
  bf=false
  s="hello"
  l="ab cd ef"
  a=("ab" "cd" "ef")
  declare -A d
  d['ab']=0
  d['cd']=1
  # ---------- [print] ----------
  echo "i           = $i"
  echo "f           = $f"
  echo "i + 1       = $(($i + 1))"
  echo "bt          = $bt"
  echo "bf          = $bf"
  echo "s           = $s"
  echo "\${a[0]}    = ${a[0]}"
  echo "\${a[*]}    = ${a[*]}"
  echo "\${a[@]}    = ${a[@]}"
  echo "\${#a[*]}   = ${#a[*]}"
  echo "\${#a[@]}   = ${#a[@]}"
  echo "\${d['ab']} = ${d['ab']}"
  # ---------- [if] ----------
  if false; then
    echo "0"
  elif false; then
    echo "1"
  else
    echo "2"
  fi
  # ---------- [for] ----------
  for i in $l; do
    echo -n "$i "
  done
  echo
}


func
