#!/bin/bash

files="\
$HOME/.bashrc \
$HOME/WinHome/.bashrc \
$HOME/.not_existing_file \
$HOME/WinHome/.not_existing_file \
C:/Users/Takeh/.bashrc \
C:/Users/Takeh2/.bashrc \
"

echo "=== pathconv.sh ===================="
for i in $files; do
  echo "orig: $i --------------------"
  echo "unix: $(pathconv.sh unix $i)"
  echo "win : $(pathconv.sh win $i)"
done

echo "=== pathconv.py ===================="
for i in $files; do
  echo "orig: $i --------------------"
  echo "unix: $(pathconv.py -t unix $i)"
  echo "win : $(pathconv.py -t windows $i)"
  echo "mix : $(pathconv.py -t mixed $i)"
done
