#!/bin/bash

COMPLETION_PATH="$SYS_PROG64_DIR/Git/mingw64/share/git/completion"

cd $MY_ETC/git
cp "$COMPLETION_PATH/git-prompt.sh" .
cp "$COMPLETION_PATH/git-completion.bash" .

