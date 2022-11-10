#!/bin/bash

#======================================================
# fzy
#======================================================
fzy_pushd() {
  echo $(dirs -v | fzy | awk '{print "+"$1}')
}

fzy_hist() {
  echo $(history 40 | fzy | awk '{print $1}')
}

#------------------------------------------------------
# fzy_cmd
#------------------------------------------------------
fzy_cmd() {
  cmd="$1"
  arg=`$2`
  if [ -n "$arg" ]; then
    eval "$cmd \"$arg\""
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

alias     vi?='fzy_cmd vim       "fzy_bmk.sh bmk_file.txt"'
alias    cmd?='fzy_cmd " "       "fzy_bmk.sh tcmd.txt $MY_BMK/tcmd_system.txt"'
alias    git?='fzy_cmd " "       "fzy_bmk.sh tcmd_git.txt"'
alias  links?='fzy_cmd chrome.sh "fzy_bmk.sh links.txt"'
alias papers?='fzy_cmd chrome.sh "fzy_bmk.sh papers.txt"'

alias     ff?='fzy_cmd vim       "fzy_file.sh"'
alias     fd?='fzy_cmd cd        "fzy_dir.sh"'
alias    .fd?='fzy_cmd pushd     "fzy_dir.sh"'

alias   make?='fzy_cmd make       fzy_make.sh'

#alias     h?='fzy_cmd "!"        fzy_hist'

