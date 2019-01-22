#!/bin/sh

f_gitbash_git() {
  GITBASH_GIT="/mingw64/bin/git.exe"

  if [ -x "$GITBASH_GIT" ]; then
    exec "$GITBASH_GIT" "$@"
  fi
}

f_msys2_git() {
  MSYS2_GIT="/usr/bin/git.exe"

  if [ -x "$MSYS2_GIT" ]; then
    exec "$MSYS2_GIT" "$@"
  fi
}

f_win_git() {
  WIN_GIT="$SYS_PROG64_DIR/Git/mingw64/bin/git.exe"

  if [ -x "$WIN_GIT" ]; then
    PATH="$SYS_PROG64_DIR/Git/bin:$PATH"
    PATH="$SYS_PROG64_DIR/Git/usr/bin:$PATH"
    PATH="$SYS_PROG64_DIR/Git/mingw64/bin:$PATH"
    exec "$WIN_GIT" "$@"
  fi
}

f_gitbash_git "$@"

case "$1" in
  push|pull|fetch|clone|ls-remote)
    f_win_git "$@"
    ;;
  *)
    f_msys2_git "$@"
    ;;
esac

