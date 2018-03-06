#!/bin/sh

cd

cmd=diff

if [ $# -eq 1 ]; then
  case $1 in
    --init)
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

$cmd etc/dot/.hostname .hostname
$cmd etc/dot/.bashrc .bashrc
$cmd etc/dot/.vimrc .vimrc
$cmd etc/dot/.minttyrc .minttyrc
$cmd etc/dot/.gitconfig .gitconfig
$cmd etc/dot/.gitignore_global .gitignore_global

