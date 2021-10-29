#!/bin/bash

#======================================================
# git
#======================================================
#------------------------------------------------------
# git-alias
#------------------------------------------------------
alias gs='git status'
alias gd='git diff'
alias gf='git fetch'
alias gb='git branch'
alias gt='git tag'

alias gA='git add'
alias gAu='git add -u'

# gC-amend ["amend"]
gC-amend() {
  msg=${1:-"amend"}
  git commit --amend -m "$msg"
}

# gC ["update"]
gC() {
  msg=${1:-"update"}
  git commit -m "$msg"
}

# gAC ["update"]
gAC() {
  msg=${1:-"update"}
  git commit -a -m "$msg"
}

alias gR='git reset --hard'
alias gRom='git reset --hard origin/$(git-branch-name)'
alias gPom='git push origin $(git-branch-name)'

alias git-clone-recursive='git clone --recurse-submodules'

alias git-submodule-update-all='git submodule update --init --recursive'
alias git-dirdiff='git difftool --dir-diff'

#------------------------------------------------------
# git (stage/unstage, track/untrack)
#------------------------------------------------------
alias git-stage='git add'
alias git-unstage='git reset --'

alias git-track='git add'
alias git-untrack-file='git rm --cached'
alias git-untrack-dir='git rm --cached -r'

git-chmod-x() {
  git update-index --add --chmod=+x "$@"
}

git-chmod-x-all() {
  git-chmod-x $(git-ls-no-x)
}

#------------------------------------------------------
# git-tmp
#------------------------------------------------------
git-tmp-commit() {
  git commit -a -m "[TMP] $*";
}

git-tmp-reset() {
  git reset HEAD^;
}

git-reset-last() {
  git reset HEAD^;
}

#------------------------------------------------------
# git (push/pull/merge/rebase)
#------------------------------------------------------
alias git-pull-no-commit='git pull --no-commit'
alias git-merge-no-commit='git merge --no-commit'
alias git-merge-no-ff='git merge --no-ff'

git-push-origin() {
  git push origin $(git-branch-name)
}

git-pull-origin() {
  git pull origin $(git-branch-name)
}

git-rebase-origin() {
  git rebase origin/$(git-branch-name)
}

git-merge-origin-no-commit() {
  git merge --no-commit origin/$(git-branch-name)
}

#------------------------------------------------------
# git-ls
#------------------------------------------------------
alias git-ls-track='git ls-files -s'
alias git-ls-untrack='git ls-files -o --directory'

git-ls-no-x() {
  git ls-files -s | grep '^100644' | awk '{print $4}'
}

alias gls='git-ls'

#------------------------------------------------------
# git-branch
#------------------------------------------------------
git-branch-name() {
  git rev-parse --abbrev-ref HEAD 2>/dev/null
  #git symbolic-ref --short HEAD 2>/dev/null
  #git branch --show-current 2>/dev/null
}

git-commit-hash() {
  git rev-parse --short HEAD 2>/dev/null
}

git-commit-hash-long() {
  git rev-parse HEAD 2>/dev/null
}

print-git-branch-all() {
  echo "[REMOTE]"
  git remote -v
  echo "[BRANCH]"
  git branch -a -vv
}

print-git-tag-all() {
  echo "[TAG]"
  git tag
  git ls-remote --tags
}

alias gb-all='print-git-branch-all'
alias gt-all='print-git-tag-all'

git-branch-delete() {
  br=$1
  git branch -d $br
}

git-remote-branch-delete() {
  br=$1
  git push origin :$br
}

#------------------------------------------------------
# git-graph
#------------------------------------------------------
# less options
# -E or --QUIT-AT-EOF
# -F or --quit-if-one-screen
# -R or --RAW-CONTROL-CHARS
# -S or --chop-long-lines
# -X or --no-init
gg()   { git graph --color=always $* | less -EFRSX; }
gg-d() { git graph --color=always --date-order  $* | less -EFRSX; }
gg-s() { git graph --color=always --name-status $* | less -EFRSX; }

#------------------------------------------------------
