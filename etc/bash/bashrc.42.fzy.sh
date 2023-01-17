#!/bin/bash

export FZF_DEFAULT_COMMAND='fdfind --type f --strip-cwd-prefix'
export FZF_DEFAULT_OPTS='--exact --reverse --bind alt-p:preview-up,alt-n:preview-down'

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
    export FZY_SELECTED="$arg"
    eval "$cmd \"$arg\""
  fi
}

#------------------------------------------------------
fzy_rg() {
  fzy_cmd echo "fzy_rg.sh $*"
}

#------------------------------------------------------
# fzy alias
#------------------------------------------------------
alias      .?='fzy_cmd pushd     "fzy_bmk.sh bmk_dir.txt"'
alias      ,?='fzy_cmd popd       fzy_pushd'
alias      ??='fzy_cmd pushd      fzy_pushd'

alias     vi?='fzy_cmd vim       "fzy_file.sh"'
alias   bmkf?='fzy_cmd vim       "fzy_bmk.sh bmk_file.txt"'

alias     cd?='fzy_cmd cd        "fzy_dir.sh"'
alias   bmkd?='fzy_cmd cd        "fzy_bmk.sh bmk_dir.txt"'

alias   tcmd?='fzy_cmd eval      "fzy_bmk.sh tcmd.txt"'
alias    git?='fzy_cmd eval      "fzy_bmk.sh tcmd_git.txt"'
alias    sys?='fzy_cmd eval      "fzy_bmk.sh tcmd_sys.txt"'

alias  links?='fzy_cmd chrome.sh "fzy_bmk.sh links.txt"'
alias      l?='fzy_cmd chrome.sh "fzy_bmk.sh + links.txt"'

alias papers?='fzy_cmd chrome.sh "fzy_bmk.sh papers.txt"'
alias      p?='fzy_cmd chrome.sh "fzy_bmk.sh + papers.txt"'

alias     ff?='fzy_file.sh'
alias     fd?='fzy_dir.sh'

alias     rg?='fzy_rg'

alias   make?='fzy_cmd make       fzy_make.sh'

#alias     h?='fzy_cmd "!"        fzy_hist'

