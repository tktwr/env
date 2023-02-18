#!/bin/bash

g_bin_name='fzf_bmk.sh'

g_pre_filter='-'
g_action='--fzf'
g_prompt='   '
g_files=""

#------------------------------------------------------
f_help() {
  echo "NAME"
  echo "  $g_bin_name"
  echo
  echo "SYNOPSIS"
  echo "  $g_bin_name [options] [file...]"
  echo
  echo "OPTIONS"
  echo "  --help       ... print help"
  echo "  --print-args ... print args"
  echo "  --src        ... print source lines"
  echo "  --fzf        ... print the selected line by fzf"
  echo "  --fzf-post   ... print the selected line by fzf (post processed)"
  echo "  --fzf-open   ... open the selected line by fzf"
  echo "  --eval-open  ... open line"
  echo "  +            ... filter +"
}

#------------------------------------------------------
eval_cmd() {
  cmd="$1"
  arg="$2"
  if [ -n "$arg" ]; then
    eval "$cmd \"$arg\""
  fi
}

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

bmk_open() {
  file=$(echo "$*" | bmk_get_value)

  case "$file" in
    '>'*)
      echo "tcmd: [$file]"
      ;;
    ':'*)
      echo "vcmd: [$file]"
      ;;
    '_Plug_'*)
      echo "vcmd: [$file]"
      ;;
    http*)
      echo "http: [$file]"
      chrome.sh "$file"
      ;;
    *)
      file=$(bmk_expand "$file")
      if [ -d "$file" ]; then
        echo "dir: [$file]"
        te.sh "$file"
      elif [ -f "$file" ]; then
        echo "file: [$file]"
        vscode.sh "$file"
      fi
      ;;
  esac
}

#------------------------------------------------------
fzf_bmk_pre() {
  case $g_pre_filter in
    +)
      grep '^+ '
      ;;
    *)
      grep '^[-+] '
      ;;
  esac
}

fzf_bmk_selector() {
  opt="--prompt '$g_prompt'"
  opt="$opt --preview 'preview_bmk.sh {}'"
  opt="$opt --preview-window 'hidden'"
  opt="$opt --header '[C-R:open, C-T:preview]'"
  opt="$opt --bind 'ctrl-r:execute(fzf_bmk.sh --eval-open {})'"
  opt="$opt --bind 'ctrl-t:toggle-preview'"
  eval "fzf $opt"
}

fzf_bmk_post() {
  awk -F '|' '{print $2}' | sed -e 's+^ *++' -e 's+> ++' -e 's+<CR>++'
}

fzf_bmk() {
  files=""
  for i in "$@"; do
    files="$files \
      $MY_ETC/bmk/$i \
      $MY_COMMON_SETTING/bmk/$i \
      $MY_DOTMY/bmk/$i \
      "
  done

  cmd="cat $files 2> /dev/null"

  case $g_action in
    --src)
      eval "$cmd" | fzf_bmk_pre
      ;;
    --fzf)
      eval "$cmd" | fzf_bmk_pre | fzf_bmk_selector
      ;;
    --fzf-post)
      eval "$cmd" | fzf_bmk_pre | fzf_bmk_selector | fzf_bmk_post
      ;;
    --fzf-open)
      bmk_open $(eval "$cmd" | fzf_bmk_pre | fzf_bmk_selector)
      ;;
  esac
}

#------------------------------------------------------
f_print_args() {
  echo "== [args] ============================================="
  echo "g_pre_filter : [$g_pre_filter]"
  echo "g_action     : [$g_action]"
  echo "g_prompt     : [$g_prompt]"
  echo "g_files      : [$g_files]"
  echo "======================================================="
}

f_parse_args() {
  while [ $# -gt 0 ]; do
    case "$1" in
      --help)
        f_help
        exit
        ;;
      --print-args)
        f_print_args 1>&2
        exit
        ;;
      --src|--fzf|--fzf-post|--fzf-open)
        g_action=$1
        ;;
      --eval-open)
        shift
        bmk_open "$*"
        exit
        ;;
      --prompt)
        shift
        g_prompt="$1"
        ;;
      +)
        g_pre_filter='+'
        ;;
      *)
        g_files="$g_files $1"
        ;;
    esac
    shift
  done
}

#------------------------------------------------------
f_parse_args "$@"
if [ "$g_files" != "" ]; then
  fzf_bmk $g_files
fi
