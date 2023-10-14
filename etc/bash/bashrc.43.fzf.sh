#!/bin/bash

#======================================================
# fzf
#======================================================
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
  else
    echo "Canceled"
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
  awk -F '|' '{print $3}' | sed -e 's+^ *++'
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

eval_fzf_cmd() {
  eval_cmd "$1" $(fzf_cmd.sh "$1")
}

#------------------------------------------------------
# setup
#------------------------------------------------------
# fzf functions:
# - page-up
# - page-down
# - preview-page-up
# - preview-page-down
# - preview-up
# - preview-down

_my_setup_fzf_common() {
  export FZF_DEFAULT_OPTS="--exact --no-sort --reverse --info 'inline-right'"
  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --header '[A-thjkl:preview]'"
  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind 'alt-t:toggle-preview'"
  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind 'alt-h:preview-page-up'"
  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind 'alt-j:preview-down'"
  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind 'alt-k:preview-up'"
  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind 'alt-l:preview-page-down'"
}

_my_setup_fzf_fdfind() {
  _my_setup_fzf_common
  export FZF_DEFAULT_COMMAND="fdfind"
  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color 'bg:#2a2a2a,bg+:#3c3836,fg:#ebdbb2,fg+:#ebdbb2,hl:#928374,hl+:#fb4934,preview-bg:#2a2a2a,spinner:#fb4934,header:#928374,info:#8ec07c,pointer:#fb4934,marker:#fb4934,prompt:#fb4934,border:#ebdbb2,separator:#504945'"
  export RUNEWIDTH_EASTASIAN=0
}

_my_setup_fzf_find() {
  _my_setup_fzf_common
  export FZF_DEFAULT_COMMAND="find"
  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --no-unicode"
}

_my_setup_fzf_alias() {
  alias  f='eval_bmk      $(fzf_bmk.sh bmk_dir.txt bmk_dir_opt.txt tcmd.txt tcmd_sys.txt tcmd_git.txt bmk_file.txt bmk_file_opt.txt links.txt papers.txt)'
  alias  d='eval_fzf_fd'
  alias  r='eval_fzf_rg'
  alias  M='eval_fzf_cmd  mymake.sh'
  alias  S='eval_fzf_cmd  setup.sh'

  alias ,+='eval_cmd      pushd $(fzf_bmk.sh bmk_dir.txt bmk_dir_opt.txt | bmk_get_value)'
  alias ,,='eval_cmd      pushd $(fzf_pushd)'
  alias ,-='eval_cmd      popd  $(fzf_pushd)'
}

my_setup_fzf() {
  _my_setup_fzf_$SYS_FIND_EXE
  _my_setup_fzf_alias

  export -f fzf_print
  export -f eval_cmd
  export -f eval_fzf_cmd
}

#------------------------------------------------------
my_setup_fzf
