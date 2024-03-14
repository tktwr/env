#!/bin/bash

files=(\
"$HOME/.bashrc" \
"$HOME/.not_existing_file" \
"$HOME/WinHome/.bashrc" \
"$HOME/WinHome/.not_existing_file" \
"C:/Users/Takeh/.bashrc" \
"C:/Users/Takeh2/.bashrc" \
"C:/Program Files" \
"C:\Program Files" \
)

echo "=== pathconv.sh ===================="
len=${#files[@]}
for (( i=0; i<$len; i++ )); do
  orig=${files[$i]}
  echo "------------------------------"
  echo "orig: $orig"
  echo "unix: $(pathconv.sh unix $orig)"
  echo "win : $(pathconv.sh win $orig)"
done

echo "=== pathconv.py ===================="
len=${#files[@]}
for (( i=0; i<$len; i++ )); do
  orig=${files[$i]}
  echo "------------------------------"
  echo "orig: $orig"
  echo "unix: $(pathconv.py -t unix $orig)"
  echo "mix : $(pathconv.py -t mixed $orig)"
  echo "win : $(pathconv.py -t windows $orig)"
done
