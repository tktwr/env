#!/bin/sh

cmd=diff

if [ $# -eq 1 ]; then
  case $1 in
    --cp)
      cmd=cp
      ;;
    --diff)
      cmd=diff
      ;;
    --vimdiff)
      cmd=vimdiff
      ;;
  esac
fi

$cmd .hostname $HOME/.hostname
$cmd .bashrc $HOME/.bashrc
$cmd .vimrc $HOME/.vimrc
$cmd .minttyrc $HOME/.minttyrc
$cmd .gitconfig $HOME/.gitconfig
$cmd .gitignore_global $HOME/.gitignore_global

