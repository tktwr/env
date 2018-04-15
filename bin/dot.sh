#!/bin/sh

cmd=cmp

if [ $# -eq 0 ]; then
  vimdirdiff . ~
  exit
fi

f_diff() {
  if [ ! -f "$1" ]; then
    echo "[no file] $1"
  fi
  if [ ! -f "$2" ]; then
    echo "[no file] $2"
  fi
  if [ ! \( -f "$1" -a -f "$2" \) ]; then
    return
  fi
  cmp -s "$1" "$2"
  if [ $? -eq 0 ]; then
    echo "[==] $1 $2"
  elif [ $? -eq 1 ]; then
    echo "[!=] $1 $2"
    if [ "$cmd" = "diff" -o "$cmd" = "vimdiff" ]; then
      $cmd "$1" "$2"
    fi
  fi
}

if [ $# -eq 1 ]; then
  case $1 in
    --cp)
      cmd=cp
      ;;
    --cmp)
      cmd=cmp
      ;;
    --diff)
      cmd=diff
      ;;
    --vimdiff)
      cmd=vimdiff
      ;;
    *)
      exit
      ;;
  esac
fi

# common for all shells
f_diff .bashrc $HOME/.bashrc
f_diff .vimrc $HOME/.vimrc
f_diff .gitignore_global $HOME/.gitignore_global
f_diff .tmux.conf $HOME/.tmux.conf

# different for each shell
f_diff .gitconfig $HOME/.gitconfig
f_diff .hostname $HOME/.hostname
f_diff .minttyrc $HOME/.minttyrc

