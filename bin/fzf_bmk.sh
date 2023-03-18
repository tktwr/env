#!/bin/bash

g_bin_name='fzf_bmk.sh'

g_action='--fzf'
g_prompt_format='Bmk(%s)> '
g_prompt_icons='  '
g_bmk_pre_filter='-'
g_bmk_files=""

#------------------------------------------------------
f_help() {
  echo "NAME"
  echo "  $g_bin_name"
  echo
  echo "SYNOPSIS"
  echo "  $g_bin_name [options] [file...]"
  echo
  echo "OPTIONS"
  echo "  --help      ... print help"
  echo "  --args      ... print args"
  echo "  --src       ... print source lines"
  echo "  --fzf       ... print the selected line by fzf"
  echo "  --fzf-post  ... print the selected line by fzf (post processed)"
  echo "  --fzf-open  ... open the selected line by fzf"
  echo "  --eval-open ... open line"
  echo "  +           ... filter +"
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
  case $g_bmk_pre_filter in
    +)
      grep '^+ '
      ;;
    *)
      grep '^[-+] '
      ;;
  esac
}

fzf_bmk_selector() {
  prompt=$(printf "$g_prompt_format" "$g_prompt_icons")
  opt="--prompt '$prompt'"
  opt="$opt --header '[A-O:open, A-T:preview, A-N:p-next, A-P:p-prev]'"
  opt="$opt --bind 'alt-o:execute(fzf_bmk.sh --eval-open {})'"
  opt="$opt --preview 'preview_bmk.sh {}'"
  if [ $COLUMNS -lt 120 ]; then
    opt="$opt --preview-window 'hidden'"
  fi
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
  echo "g_action         : [$g_action]"
  echo "g_prompt_format  : [$g_prompt_format]"
  echo "g_prompt_icons   : [$g_prompt_icons]"
  echo "g_bmk_pre_filter : [$g_bmk_pre_filter]"
  echo "g_bmk_files      : [$g_bmk_files]"
  echo "======================================================="
}

f_parse_args() {
  while [ $# -gt 0 ]; do
    case "$1" in
      --help)
        f_help
        exit
        ;;
      --args)
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
      --prompt-icons)
        shift
        g_prompt_icons="$1"
        ;;
      +)
        g_bmk_pre_filter='+'
        ;;
      *)
        g_bmk_files="$g_bmk_files $1"
        ;;
    esac
    shift
  done
}

#------------------------------------------------------
f_parse_args "$@"
if [ -n "$g_bmk_files" ]; then
  fzf_bmk $g_bmk_files
fi
