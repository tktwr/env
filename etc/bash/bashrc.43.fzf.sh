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

export FZF_DEFAULT_COMMAND="fdfind --strip-cwd-prefix"
export FZF_DEFAULT_OPTS="--exact --no-sort --reverse"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --header '[A-T:preview, A-N:p-next, A-P:p-prev]'"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind 'alt-t:toggle-preview'"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind 'alt-n:preview-page-down,alt-p:preview-page-up'"
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
  file="$*"
  if [ -d "$file" ]; then
    eval_cmd cd "$file"
  elif [ -f "$file" ]; then
    eval_cmd vim "$file"
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

bmk_expand() {
  eval "echo $*"
}

eval_bmk() {
  file=$(echo "$*" | bmk_get_value)

  case "$file" in
    '>'*)
      fzf_print "tcmd: [$file]"
      if [ "$VIM_TERMINAL" ]; then
        vimapi_exec "call bmk#ExecTermCommand('$file')"
      else
        file=$(echo "$file" | bmk_rm_tcmd)
        eval "$file"
      fi
      ;;
    ':'*)
      fzf_print "vcmd: [$file]"
      ;;
    '_Plug_'*)
      fzf_print "vcmd: [$file]"
      ;;
    http*)
      fzf_print "http: [$file]"
      chrome.sh "$file"
      ;;
    *)
      file=$(bmk_expand "$file")
      eval_fd "$file"
      ;;
  esac
}

#------------------------------------------------------
# fzf alias
#------------------------------------------------------
alias  c='eval_bmk           $(fzf_bmk.sh --prompt-icons " " tcmd.txt tcmd_sys.txt tcmd_git.txt)'
alias  f='eval_bmk           $(fzf_bmk.sh --prompt-icons "   " bmk_dir.txt bmk_file.txt links.txt papers.txt)'
alias  d='eval_fd            $(fzf_fd.sh --root)'
alias  r='eval_rg            $(fzf_rg_plus.sh)'
alias  m='eval_cmd make      $(fzf_make.sh)'

alias .?='eval_cmd pushd     $(fzf_bmk.sh --fzf-post bmk_dir.txt)'
alias ,?='eval_cmd popd      $(fzf_pushd)'
alias ??='eval_cmd pushd     $(fzf_pushd)'
