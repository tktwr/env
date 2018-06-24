#!/bin/sh

# for gitbash
GITBASH_GIT="/mingw64/bin/git.exe"

if [ -x "$GITBASH_GIT" ]; then
  exec "$GITBASH_GIT" "$@"
fi


# use windows native git on msys2
BIN_FILE="$SYS_PROG64_DIR/Git/mingw64/bin/git.exe"

if [ ! -x "$BIN_FILE" ]; then
  echo "no $BIN_FILE"
  exit
fi

PATH="$SYS_PROG64_DIR/Git/bin:$PATH"
PATH="$SYS_PROG64_DIR/Git/usr/bin:$PATH"
PATH="$SYS_PROG64_DIR/Git/mingw64/bin:$PATH"

exec "$BIN_FILE" "$@"

