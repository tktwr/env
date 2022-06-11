#!/bin/bash

#======================================================
# fzy
#======================================================
#------------------------------------------------------
# fzy_arg
#------------------------------------------------------
fzy_fzy_filter() {
  grep -v '^#' | fzy | awk -F '|' '{print $3}'
}

fzy_fzy() {
  local files="$MY_DOTMY/fzy/dir.txt \
               $MY_COMMON_SETTING/fzy/dir.txt \
               $MY_ETC/fzy/dir.00.msys.txt \
               $MY_ETC/fzy/dir.01.usr.txt \
               $MY_ETC/fzy/dir.txt \
               "
  echo $(cat $files 2> /dev/null | fzy_fzy_filter)
}

#------------------------------------------------------
fzy_pushd() {
  echo $(dirs -v | fzy | awk '{print "+"$1}')
}

fzy_make() {
  echo $(make help | cut -d " " -f 1 | fzy)
}

fzy_hist() {
  echo $(history 40 | fzy | awk '{print $1}')
}

memo() {
  tags_files="\
  -t=$MY_REMOTE_CONFIG/memo/tags.memo \
  -t=$MY_REMOTE_CONFIG/samples/tags.memo \
  -t=$MY_LOCAL_CONFIG/memo/tags.memo \
  -t=$MY_DIARY/tags.memo \
  "
  eval "memo.sh $tags_files $@"
}

fzy_memo() {
  echo $(memo --fzy | fzy | awk '{print $1}')
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
virg() {
  fzy_cmd vim "fzy_rg.sh $*"
}

#------------------------------------------------------
# fzy alias
#------------------------------------------------------
alias      D?='fzy_cmd D         "fzy_bmk.sh bmk_dir.txt"'
alias     D2?='fzy_cmd D2        "fzy_bmk.sh bmk_dir.txt"'
alias     cd?='fzy_cmd cd        "fzy_bmk.sh bmk_dir.txt"'
alias      x?='fzy_cmd te.sh     "fzy_bmk.sh bmk_dir.txt"'
alias      .?='fzy_cmd pushd     "fzy_bmk.sh bmk_dir.txt"'
alias      ,?='fzy_cmd popd       fzy_pushd'
alias      ??='fzy_cmd pushd      fzy_pushd'

alias    cmd?='fzy_cmd " "       "fzy_bmk.sh tcmd.txt"'
alias    git?='fzy_cmd " "       "fzy_bmk.sh tcmd_git.txt"'
alias  links?='fzy_cmd chrome.sh "fzy_bmk.sh links.txt"'
alias papers?='fzy_cmd chrome.sh "fzy_bmk.sh papers.txt"'

alias     vi?='fzy_cmd vim       "fzy_bmk.sh bmk_file.txt"'
alias    vif?='fzy_cmd vim       "fzy_file.sh 6"'

alias     fd?='fzy_cmd cd        "fzy_dir.sh 6"'
alias    .fd?='fzy_cmd pushd     "fzy_dir.sh 6"'

alias   make?='fzy_cmd make       fzy_make'

#alias     h?='fzy_cmd "!"        fzy_hist'
#alias  memo?='fzy_cmd memo       fzy_memo'

