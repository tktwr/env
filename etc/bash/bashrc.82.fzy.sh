#!/bin/bash

#======================================================
# fzy
#======================================================
#------------------------------------------------------
# fzy_arg
#------------------------------------------------------
fzy_dir_filter() {
  grep -v '^#' | fzy | awk -F '|' '{print $3}'
}

fzy_arg_dir() {
  local files="$MY_DOTMY/fzy/dir.txt \
               $MY_COMMON_SETTING/fzy/dir.txt \
               $MY_FZY/dir.00.msys.txt \
               $MY_FZY/dir.01.usr.txt \
               $MY_FZY/dir.txt \
               "
  echo $(cat $files 2> /dev/null | fzy_dir_filter)
}

#------------------------------------------------------
fzy_arg_pushd() {
  echo $(dirs -v | fzy | awk '{print "+"$1}')
}

fzy_arg_find_dir() {
  depth=${1:-3}
  echo $(find-dir.sh -maxdepth $depth | fzy)
}

fzy_arg_find_file() {
  depth=${1:-3}
  echo $(find-txt.sh -maxdepth $depth | fzy)
}

fzy_arg_make() {
  echo $(make help | cut -d " " -f 1 | fzy)
}

fzy_arg_hist() {
  echo $(history 40 | fzy | awk '{print $1}')
}

fzy_arg_memo() {
  echo $(memo.sh --fzy | fzy | awk '{print $1}')
}

#------------------------------------------------------
# fzy_cmd
#------------------------------------------------------
fzy_cmd() {
  cmd="$1"
  arg=`$2`
  if [ -n "$arg" ]; then
    #echo -n "$cmd $arg"
    eval "$cmd $arg"
  fi
}

#------------------------------------------------------
# fzy alias
#------------------------------------------------------
alias  D?='fzy_cmd D     "bmk.sh bmk_dir.txt"'
alias D2?='fzy_cmd D2    "bmk.sh bmk_dir.txt"'
alias cd?='fzy_cmd cd    "bmk.sh bmk_dir.txt"'
alias  x?='fzy_cmd te.sh "bmk.sh bmk_dir.txt"'
alias  .?='fzy_cmd pushd "bmk.sh bmk_dir.txt"'
alias  ,?='fzy_cmd popd   fzy_arg_pushd'
alias  ??='fzy_cmd pushd  fzy_arg_pushd'

alias     vi?='fzy_cmd vim       "bmk.sh bmk_file.txt"'
alias     tc?='fzy_cmd " "       "bmk.sh tcmd.txt"'
alias    git?='fzy_cmd " "       "bmk.sh tcmd_git.txt"'
alias  links?='fzy_cmd chrome.sh "bmk.sh links.txt"'
alias papers?='fzy_cmd chrome.sh "bmk.sh papers.txt"'

alias  fd?='fzy_cmd cd    "fzy_arg_find_dir  6"'
alias .fd?='fzy_cmd pushd "fzy_arg_find_dir  6"'
alias  ff?='fzy_cmd vim   "fzy_arg_find_file 6"'

alias make?='fzy_cmd make fzy_arg_make'

#alias h?='fzy_cmd "!" fzy_arg_hist'
#alias memo?='fzy_cmd memo.sh fzy_arg_memo'

