#!/bin/bash

#======================================================
# git
#======================================================
#------------------------------------------------------
# print
#------------------------------------------------------
git-branch-name() {
  git rev-parse --abbrev-ref HEAD 2>/dev/null
  #git symbolic-ref --short HEAD 2>/dev/null
  #git branch --show-current 2>/dev/null
}

git-commit-hash() {
  commit=${1:-HEAD}
  git rev-parse --short $commit 2>/dev/null
}

git-commit-hash-long() {
  commit=${1:-HEAD}
  git rev-parse $commit 2>/dev/null
}

git-print-branch-all() {
  echo "[REMOTE]"
  git remote -v
  echo "[BRANCH]"
  git branch -a -vv
}

git-print-tag-all() {
  echo "[TAG]"
  git tag
  git ls-remote --tags
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
  git graph --color=always $* | less -EFRSX
}

git-graph-date() {
  git graph --color=always --date-order  $* | less -EFRSX
}

git-graph-status() {
  git graph --color=always --name-status $* | less -EFRSX
}

#------------------------------------------------------
# ls
#------------------------------------------------------
git-ls-track() {
  git ls-files -s
}

git-ls-untrack() {
  git ls-files -o --directory
}

git-ls-no-x() {
  git ls-files -s | grep '^100644' | awk '{print $4}'
}

#------------------------------------------------------
# chmod
#------------------------------------------------------
git-chmod-x() {
  git update-index --add --chmod=+x "$@"
}

git-chmod-x-all() {
  git-chmod-x $(git-ls-no-x)
}

#------------------------------------------------------
# branch
#------------------------------------------------------
git-branch-reset() {
  br=$(prompt.sh 'Reset branch' 'master' "$*")
  if [ -n "$br" ]; then
    git branch -f $br HEAD
    git checkout $br
  fi
}

git-branch-create() {
  br=$(prompt.sh 'Create branch' 'tmp' "$*")
  if [ -n "$br" ]; then
    git branch $br
  fi
}

git-branch-delete() {
  git branch
  br=$(prompt.sh 'Delete branch' '' "$*")
  if [ -n "$br" ]; then
    git branch -d $br
  fi
}

git-remote-branch-delete() {
  br=$(prompt.sh 'Delete remote branch' '' "$*")
  if [ -n "$br" ]; then
    git push origin :$br
  fi
}

#------------------------------------------------------
# stage/unstage
#------------------------------------------------------
git-stage() {
  git add "$@"
}

git-unstage() {
  git reset -- "$@"
}

#------------------------------------------------------
# track/untrack
#------------------------------------------------------
git-track() {
  git add "$@"
}

git-untrack() {
  git rm --cached -r "$@"
}

#------------------------------------------------------
# commit
#------------------------------------------------------
git-commit() {
  msg=$(prompt.sh 'Commit message' 'update' "$*")
  git commit -m "$msg"
}

git-commit-add() {
  msg=$(prompt.sh 'Commit message' 'update' "$*")
  git commit -a -m "$msg"
}

git-commit-amend() {
  msg=$(prompt.sh 'Amend commit message' 'amend' "$*")
  git commit --amend -m "$msg"
}

#------------------------------------------------------
# reset
#------------------------------------------------------
git-reset-last() {
  git reset HEAD~
}

git-reset-hard() {
  git reset --hard "$@"
}

git-reset-hard-origin() {
  git reset --hard origin/$(git-branch-name)
}

#------------------------------------------------------
# push/pull
#------------------------------------------------------
git-push-origin() {
  br=$(prompt.sh 'Push branch' "$(git-branch-name)" "$*")
  if [ -n "$br" ]; then
    git push origin $br
  fi
}

git-pull-origin() {
  br=$(prompt.sh 'Pull branch' "$(git-branch-name)" "$*")
  if [ -n "$br" ]; then
    git pull origin $br
  fi
}

#------------------------------------------------------
# merge/rebase
#------------------------------------------------------
git-merge() {
  br=$(prompt.sh 'Merge branch' "$(git-branch-name)" "$*")
  if [ -n "$br" ]; then
    git merge --no-ff $br
  fi
}

git-merge-abort() {
  git merge --abort
}

git-rebase() {
  br=$(prompt.sh 'Rebase branch' "$(git-branch-name)" "$*")
  if [ -n "$br" ]; then
    git rebase $br
  fi
}

git-rebase-abort() {
  git rebase --abort
}

#------------------------------------------------------
# tmp
#------------------------------------------------------
git-tmp() {
  msg=$(prompt.sh 'Commit message' '[TMP] update' "$*")
  if [ -n "$msg" ]; then
    git commit -a -m "$msg"
  fi
}

git-tmp-reset() {
  git reset HEAD~
}

#------------------------------------------------------
# others
#------------------------------------------------------
git-clone-shallow() {
  git clone --depth 1 "$@"
}

git-clone-shallow-recursive() {
  git clone --depth 1 --recurse-submodules --shallow-submodules "$@"
}

git-clone-recursive() {
  git clone --recurse-submodules "$@"
}

git-submodule-update-all() {
  git submodule update --init --recursive
}

git-dirdiff() {
  git difftool --dir-diff
}

#------------------------------------------------------
# alias
#------------------------------------------------------
alias gs='git status'
alias gS='git status -s'
alias gd='git diff'
alias gD='git diff --staged'
alias gf='git fetch'
alias gg='git graph'
alias gb='git branch'
alias gt='git tag'

alias gA='git add'
alias gAu='git add -u'
alias gAC='git-commit-add'
alias gC='git-commit'

alias gbR='git-branch-reset'
alias gR='git reset --hard'
alias gRom='git-reset-hard-origin'
alias gPom='git-push-origin'

alias G='git-graph-date -6'
alias GA='git-graph-date -6 --all'
alias GM='git-log.sh --log 4 --log-submodule 2'

alias gls='git-ls.sh'
alias gba='git-print-branch-all'
alias gta='git-print-tag-all'
