#!/bin/bash

cols=80

which tput > /dev/null 2>&1
if [ $? -eq 0 ]; then
  cols=$(tput cols)
fi

tracked_files=$(mktemp).tracked_files.gls
untracked_files=$(mktemp).untracked_files.gls
out_tracked_files=$(mktemp).out_tracked_files.gls
out_untracked_files=$(mktemp).out_untracked_files.gls
out_mixed_files=$(mktemp).out_mixed_files.gls

f_uniq_dir() {
  sed 's|/.*|/|' | uniq | sort
}

f_tracked() {
  sed 's|\(.*\)|\1 [.]|'
}

f_untracked() {
  sed 's|\(.*\)|\1 [U]|'
}

f_mixed() {
  sed 's|\(.*\)|\1 [M]|'
}

f_swap_mark() {
  sed 's|\(.*\) \(\[.\]\)|\2 \1|'
}

git ls-files | f_uniq_dir > $tracked_files
git ls-files -o --directory | f_uniq_dir > $untracked_files
comm -23 $tracked_files $untracked_files > $out_tracked_files
comm -13 $tracked_files $untracked_files > $out_untracked_files
comm -12 $tracked_files $untracked_files > $out_mixed_files

f_list() {
  cat $out_tracked_files | f_tracked
  cat $out_untracked_files | f_untracked
  cat $out_mixed_files | f_mixed
}

f_list | sort | f_swap_mark | column -c $cols

rm $tracked_files $untracked_files
rm $out_tracked_files $out_untracked_files $out_mixed_files

