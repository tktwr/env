#!/bin/bash

#======================================================
# fzy
#======================================================

fzy_arg_links() {
  local files="$MY_DOTMY/links.txt \
               $MY_COMMON_SETTING/links.txt \
               $MY_FZY/links.txt \
               "
  echo $(grep -s -h -v '^#' $files | fzy | awk -F '|' '{print $2}')
}
fzy_arg_dir() {
  local files="$MY_DOTMY/dir.txt \
               $MY_COMMON_SETTING/dir.txt \
               $MY_FZY/dir.txt \
               "
  echo $(grep -s -h -v '^#' $files | fzy | awk -F '|' '{print $3}')
}
fzy_arg_cmd() {
  local files="$MY_DOTMY/cmd.txt \
               $MY_COMMON_SETTING/cmd.txt \
               $MY_FZY/cmd.txt \
               "
  echo $(grep -s -h -v '^#' $files | fzy | awk -F '|' '{print $2}')
}
fzy_arg_find_dir() {
  echo $(find -type d | fzy)
}
fzy_arg_hist() {
  echo $(history 40 | fzy | awk '{print $1}')
}
fzy_arg_pushd() {
  echo $(dirs -v | fzy | awk '{print $1}')
}
fzy_arg_make() {
  echo $(make help | fzy | awk '{print $1}')
}
fzy_arg_memo() {
  echo $(memo --fzy | fzy | awk '{print $1}')
}
fzy_cmd() {
  cmd="$1"
  arg=`$2`
  if [ -n "$arg" ]; then
    eval "$cmd$arg"
  fi
}

alias links?='fzy_cmd "chrome.sh " fzy_arg_links'
alias x?='fzy_cmd "explorer.sh " fzy_arg_dir'
alias cd?='fzy_cmd "cd " fzy_arg_dir'
alias .?='fzy_cmd "pushd " fzy_arg_dir'
alias  findd?='fzy_cmd "cd " fzy_arg_find_dir'
alias .findd?='fzy_cmd "pushd " fzy_arg_find_dir'
#alias h?='fzy_cmd "!" fzy_arg_hist'
alias ??='fzy_cmd "pushd +" fzy_arg_pushd'
alias ,?='fzy_cmd "popd +" fzy_arg_pushd'
alias make?='fzy_cmd "make " fzy_arg_make'
alias memo?='fzy_cmd "memo " fzy_arg_memo'
alias cmd?='fzy_cmd " " fzy_arg_cmd'

