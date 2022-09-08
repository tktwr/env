#!/bin/bash

files="\
$HOME/.bashrc \
$HOME/WinHome/.bashrc \
$HOME/.no_file \
$HOME/WinHome/.no_file \
"

echo "--- pathconv.sh ---"
for i in $files; do
  pathconv.sh unix $i
  pathconv.sh win $i
done

echo "--- pathconv.py ---"
for i in $files; do
  pathconv.py -t unix $i
  pathconv.py -t windows $i
done
