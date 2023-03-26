#!/bin/bash

#======================================================
# fzf
#======================================================
# fzf functions:
# - page-up
# - page-down
# - preview-page-up
# - preview-page-down
# - preview-up
# - preview-down

export FZF_DEFAULT_COMMAND="fdfind"
export FZF_DEFAULT_OPTS="--exact --no-sort --reverse"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --header '[A-T:preview, A-N:p-next, A-P:p-prev]'"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind 'alt-t:toggle-preview'"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind 'alt-n:preview-down,alt-p:preview-up'"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color 'bg:#2a2a2a,bg+:#3c3836,fg:#ebdbb2,fg+:#ebdbb2,hl:#928374,hl+:#fb4934,preview-bg:#2a2a2a,spinner:#fb4934,header:#928374,info:#8ec07c,pointer:#fb4934,marker:#fb4934,prompt:#fb4934,border:#ebdbb2,separator:#504945'"
export RUNEWIDTH_EASTASIAN=0

case $MY_OS_NAME in
  gitbash)
    export FZF_DEFAULT_COMMAND="find"
    export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --no-unicode"
    alias fzf='winpty fzf'
    ;;
esac
#------------------------------------------------------
fzf_pushd() {
  echo $(dirs -v | fzf | awk '{print "+"$1}')
}

fzf_hist() {
  echo $(history 40 | fzf | awk '{print $1}')
}

fzf_print() {
  debug=0
  if [ $debug -eq 1 ]; then
    echo "$*"
  fi
}

#------------------------------------------------------
# eval
#------------------------------------------------------
eval_cmd() {
  cmd="$1"
  arg="$2"
  fzf_print "eval_cmd: [$cmd] [$arg]"
  if [ -n "$arg" ]; then
    eval "$cmd \"$arg\""
  fi
}

eval_fd() {
  # expand env variables
  line=$(eval "echo $*")

  if [ -d "$line" ]; then
    eval_cmd cd "$line"
  elif [ -f "$line" ]; then
    eval_cmd vim "$line"
  fi
}

eval_rg() {
  file=$(echo "$*" | awk -F ':' '{print $1}')
  eval_cmd vim "$file"
}

#------------------------------------------------------
# bmk
#------------------------------------------------------
bmk_get_value() {
  awk -F '|' '{print $2}' | sed -e 's+^ *++'
}

bmk_rm_tcmd() {
  sed -e 's+> ++' -e 's+<CR>++'
}

eval_bmk() {
  line=$(echo "$*" | bmk_get_value)

  case "$line" in
    '>'*)
      fzf_print "tcmd: [$line]"
      if [ "$VIM_TERMINAL" ]; then
        vimapi_exec "call bmk#ExecTermCommand('$line')"
      else
        line=$(echo "$line" | bmk_rm_tcmd)
        eval "$line"
      fi
      ;;
    ':'*)
      fzf_print "vcmd: [$line]"
      ;;
    '_Plug_'*)
      fzf_print "vcmd: [$line]"
      ;;
    http*)
      fzf_print "http: [$line]"
      chrome.sh "$line"
      ;;
    *)
      eval_fd "$line"
      ;;
  esac
}

#------------------------------------------------------
eval_fzf_fd() {
  eval_fd $(fzf_fd.sh "$@")
}

eval_fzf_rg() {
  eval_rg $(fzf_rg.sh "$@")
}

#------------------------------------------------------
# fzf alias
#------------------------------------------------------
alias  c='eval_bmk           $(fzf_bmk.sh tcmd.txt tcmd_sys.txt tcmd_git.txt)'
alias  f='eval_bmk           $(fzf_bmk.sh bmk_dir.txt bmk_file.txt links.txt papers.txt)'
alias  d='eval_fzf_fd'
alias  r='eval_fzf_rg'
alias  m='eval_cmd make      $(fzf_make.sh)'

alias .?='eval_cmd pushd     $(fzf_bmk.sh bmk_dir.txt | bmk_get_value)'
alias ,?='eval_cmd popd      $(fzf_pushd)'
alias ??='eval_cmd pushd     $(fzf_pushd)'
