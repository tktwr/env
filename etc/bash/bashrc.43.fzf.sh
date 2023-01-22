#!/bin/bash

local fzf_bind='--bind=ctrl-d:page-up,ctrl-f:page-down,alt-d:preview-page-up,alt-f:preview-page-down,alt-p:preview-up,alt-n:preview-down'
local fzf_color_gruvbox='--color=bg:#2a2a2a,bg+:#3c3836,fg:#ebdbb2,fg+:#ebdbb2,hl:#928374,hl+:#fb4934,preview-bg:#2a2a2a,spinner:#fb4934,header:#928374,info:#8ec07c,pointer:#fb4934,marker:#fb4934,prompt:#fb4934,border:#ebdbb2,separator:#504945'

export FZF_DEFAULT_COMMAND='fdfind --type f --strip-cwd-prefix'
export FZF_DEFAULT_OPTS="--exact --no-sort --reverse $fzf_bind $fzf_color_gruvbox"
export RUNEWIDTH_EASTASIAN=0

#======================================================
# fzf
#======================================================
fzf_pushd() {
  echo $(dirs -v | fzf | awk '{print "+"$1}')
}

fzf_hist() {
  echo $(history 40 | fzf | awk '{print $1}')
}

#------------------------------------------------------
# fzf_cmd
#------------------------------------------------------
fzf_cmd() {
  cmd="$1"
  arg=`$2`
  if [ -n "$arg" ]; then
    export FZF_SELECTED="$arg"
    eval "$cmd \"$arg\""
  fi
}

#------------------------------------------------------
fzf_rg() {
  fzf_cmd echo "fzf_rg.sh $*"
}

#------------------------------------------------------
# fzf alias
#------------------------------------------------------
alias      .?='fzf_cmd pushd     "fzf_bmk.sh bmk_dir.txt"'
alias      ,?='fzf_cmd popd       fzf_pushd'
alias      ??='fzf_cmd pushd      fzf_pushd'

alias     vi?='fzf_cmd vim       "fzf_file.sh"'
alias   bmkf?='fzf_cmd vim       "fzf_bmk.sh bmk_file.txt"'

alias     cd?='fzf_cmd cd        "fzf_dir.sh"'
alias   bmkd?='fzf_cmd cd        "fzf_bmk.sh bmk_dir.txt"'

alias   tcmd?='fzf_cmd eval      "fzf_bmk.sh tcmd.txt tcmd_git.txt tcmd_sys.txt"'
alias  links?='fzf_cmd chrome.sh "fzf_bmk.sh links.txt"'
alias papers?='fzf_cmd chrome.sh "fzf_bmk.sh papers.txt"'

alias     ff?='fzf_file.sh'
alias     fd?='fzf_dir.sh'

alias     rg?='fzf_rg'

alias   make?='fzf_cmd make       fzf_make.sh'

#alias      h?='fzf_cmd "!"        fzf_hist'

