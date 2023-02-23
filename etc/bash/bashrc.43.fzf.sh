#!/bin/bash

#======================================================
# fzf
#======================================================
local fzf_color_gruvbox='--color=bg:#2a2a2a,bg+:#3c3836,fg:#ebdbb2,fg+:#ebdbb2,hl:#928374,hl+:#fb4934,preview-bg:#2a2a2a,spinner:#fb4934,header:#928374,info:#8ec07c,pointer:#fb4934,marker:#fb4934,prompt:#fb4934,border:#ebdbb2,separator:#504945'

export FZF_DEFAULT_COMMAND='fdfind --type f --strip-cwd-prefix'
export FZF_DEFAULT_OPTS="--exact --no-sort --reverse $fzf_color_gruvbox"
export RUNEWIDTH_EASTASIAN=0

#------------------------------------------------------
fzf_pushd() {
  echo $(dirs -v | fzf | awk '{print "+"$1}')
}

fzf_hist() {
  echo $(history 40 | fzf | awk '{print $1}')
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

eval_bmk() {
  file=$(echo "$*" | bmk_get_value)

  case "$file" in
    '>'*)
      echo "tcmd: [$file]"
      file=$(echo "$file" | bmk_rm_tcmd)
      eval "$file"
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
        eval_cmd cd "$file"
      elif [ -f "$file" ]; then
        echo "file: [$file]"
        eval_cmd vim "$file"
      fi
      ;;
  esac
}

eval_fd() {
  file="$*"
  if [ -d "$file" ]; then
    echo "dir: [$file]"
    eval_cmd cd "$file"
  elif [ -f "$file" ]; then
    echo "file: [$file]"
    eval_cmd vim "$file"
  fi
}

#------------------------------------------------------
# fzf alias
#------------------------------------------------------
alias f='eval_bmk           $(fzf_bmk.sh --prompt-icons "    " bmk_dir.txt bmk_file.txt tcmd.txt tcmd_git.txt tcmd_sys.txt links.txt papers.txt)'
alias d='eval_fd            $(fzf_fd.sh --root)'
alias m='eval_cmd make      $(fzf_make.sh)'

alias .?='eval_cmd pushd     $(fzf_bmk.sh --fzf-post bmk_dir.txt)'
alias ,?='eval_cmd popd      $(fzf_pushd)'
alias ??='eval_cmd pushd     $(fzf_pushd)'
