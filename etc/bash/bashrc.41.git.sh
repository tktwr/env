#!/bin/bash

#======================================================
# git
#======================================================
case $MY_OS_NAME in
  wsl) export GIT_EXE=git.sh ;;
  *)   export GIT_EXE=git ;;
esac

#------------------------------------------------------
# print
#------------------------------------------------------
git-root() {
  git rev-parse --show-toplevel 2> /dev/null
}

git-branch-name() {
  $GIT_EXE rev-parse --abbrev-ref HEAD 2>/dev/null
  #$GIT_EXE symbolic-ref --short HEAD 2>/dev/null
  #$GIT_EXE branch --show-current 2>/dev/null
}

git-commit-hash() {
  commit=${1:-HEAD}
  $GIT_EXE rev-parse --short $commit 2>/dev/null
}

git-commit-hash-long() {
  commit=${1:-HEAD}
  $GIT_EXE rev-parse $commit 2>/dev/null
}

git-print-branch-all() {
  echo "[REMOTE]"
  $GIT_EXE remote -v
  echo "[BRANCH]"
  $GIT_EXE branch -a -vv
}

git-print-tag-all() {
  echo "[TAG]"
  $GIT_EXE tag
  $GIT_EXE ls-remote --tags
}

#------------------------------------------------------
# cd
#------------------------------------------------------
git-cd-root() {
  topdir=$(git-root)
  if [ -n "$topdir" ]; then
    cd $topdir
  fi
}

#------------------------------------------------------
# graph
#------------------------------------------------------
# less options
# -E or --QUIT-AT-EOF
# -F or --quit-if-one-screen
# -R or --RAW-CONTROL-CHARS
# -S or --chop-long-lines
# -X or --no-init
git-graph() {
  $GIT_EXE graph --color=always $* | less -EFRSX
}

git-graph-date() {
  $GIT_EXE graph --color=always --date-order  $* | less -EFRSX
}

git-graph-status() {
  $GIT_EXE graph --color=always --name-status $* | less -EFRSX
}

#------------------------------------------------------
# ls
#------------------------------------------------------
git-ls-track() {
  $GIT_EXE ls-files -s
}

git-ls-untrack() {
  $GIT_EXE ls-files -o --directory
}

git-ls-no-x() {
  $GIT_EXE ls-files -s | grep '^100644' | awk '{print $4}'
}

#------------------------------------------------------
# chmod
#------------------------------------------------------
git-chmod-x() {
  $GIT_EXE update-index --add --chmod=+x "$@"
}

git-chmod-x-all() {
  git-chmod-x $(git-ls-no-x)
}

#------------------------------------------------------
# branch
#------------------------------------------------------
git-reset-branch() {
  br=$(prompt.sh 'Reset branch' 'master' "$*")
  if [ -n "$br" ]; then
    $GIT_EXE branch -f $br HEAD
    $GIT_EXE checkout $br
  fi
}

git-create-branch() {
  br=$(prompt.sh 'Create branch' 'tmp' "$*")
  if [ -n "$br" ]; then
    $GIT_EXE branch $br
  fi
}

git-delete-branch() {
  $GIT_EXE branch
  br=$(prompt.sh 'Delete branch' '' "$*")
  if [ -n "$br" ]; then
    $GIT_EXE branch -d $br
  fi
}

git-delete-branch-origin() {
  br=$(prompt.sh 'Delete remote branch' '' "$*")
  if [ -n "$br" ]; then
    $GIT_EXE push origin :$br
  fi
}

#------------------------------------------------------
# stage/unstage
#------------------------------------------------------
git-stage() {
  $GIT_EXE add "$@"
}

git-unstage() {
  $GIT_EXE reset -- "$@"
}

#------------------------------------------------------
# track/untrack
#------------------------------------------------------
git-track() {
  $GIT_EXE add "$@"
}

git-untrack() {
  $GIT_EXE rm --cached -r "$@"
}

#------------------------------------------------------
# commit
#------------------------------------------------------
git-commit() {
  msg=$(prompt.sh 'Commit message' 'update' "$*")
  $GIT_EXE commit -m "$msg"
}

git-commit-add() {
  msg=$(prompt.sh 'Commit message' 'update' "$*")
  $GIT_EXE commit -a -m "$msg"
}

git-commit-amend() {
  msg=$(prompt.sh 'Amend commit message' 'amend' "$*")
  $GIT_EXE commit --amend -m "$msg"
}

#------------------------------------------------------
# reset
#------------------------------------------------------
git-reset-last() {
  $GIT_EXE reset HEAD~
}

git-reset-hard() {
  $GIT_EXE reset --hard "$@"
}

git-reset-hard-origin() {
  $GIT_EXE reset --hard origin/$(git-branch-name)
}

#------------------------------------------------------
# push/pull
#------------------------------------------------------
git-push-origin() {
  br=$(prompt.sh 'Push branch' "$(git-branch-name)" "$*")
  if [ -n "$br" ]; then
    $GIT_EXE push origin $br
  fi
}

git-pull-origin() {
  br=$(prompt.sh 'Pull branch' "$(git-branch-name)" "$*")
  if [ -n "$br" ]; then
    $GIT_EXE pull origin $br
  fi
}

#------------------------------------------------------
# merge/rebase
#------------------------------------------------------
git-merge() {
  br=$(prompt.sh 'Merge branch' "$(git-branch-name)" "$*")
  if [ -n "$br" ]; then
    $GIT_EXE merge --no-ff $br
  fi
}

git-merge-abort() {
  $GIT_EXE merge --abort
}

git-rebase() {
  br=$(prompt.sh 'Rebase branch' "$(git-branch-name)" "$*")
  if [ -n "$br" ]; then
    $GIT_EXE rebase $br
  fi
}

git-rebase-abort() {
  $GIT_EXE rebase --abort
}

#------------------------------------------------------
# tmp
#------------------------------------------------------
git-tmp() {
  msg=$(prompt.sh 'Commit message' '[TMP] update' "$*")
  if [ -n "$msg" ]; then
    $GIT_EXE commit -a -m "$msg"
  fi
}

git-tmp-reset() {
  $GIT_EXE reset HEAD~
}

#------------------------------------------------------
# others
#------------------------------------------------------
git-clone-shallow() {
  $GIT_EXE clone --depth 1 "$@"
}

git-clone-shallow-recursive() {
  $GIT_EXE clone --depth 1 --recurse-submodules --shallow-submodules "$@"
}

git-clone-recursive() {
  $GIT_EXE clone --recurse-submodules "$@"
}

git-submodule-update-all() {
  $GIT_EXE submodule update --init --recursive
}

git-dirdiff() {
  $GIT_EXE difftool --dir-diff
}

#------------------------------------------------------
# alias
#------------------------------------------------------
git-default() {
  if [ $# -eq 0 ]; then
    $GIT_EXE status -s
  else
    $GIT_EXE "$@"
  fi
}

alias g='git-default'

alias gs='$GIT_EXE status'
alias gS='$GIT_EXE status -s'
alias gd='$GIT_EXE diff'
alias gD='$GIT_EXE diff --staged'
alias gf='$GIT_EXE fetch'
alias gg='$GIT_EXE graph'
alias gb='$GIT_EXE branch'
alias gt='$GIT_EXE tag'

alias gA='$GIT_EXE add'
alias gAu='$GIT_EXE add -u'
alias gAC='git-commit-add'
alias gC='git-commit'

alias gR='$GIT_EXE reset --hard'
alias gRom='git-reset-hard-origin'
alias gPom='git-push-origin'

alias G='git-graph-date -6'
alias GA='git-graph-date -6 --all'
alias GM='git-log.sh --log 4 --log-submodule 2'

alias gba='git-print-branch-all'
alias gta='git-print-tag-all'

alias cd.root='cd $(git-root)'
alias .root='pushd $(git-root)'
