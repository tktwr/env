#!/bin/bash

f_memo_tags() {
  memotags.sh 'memo:' *.html > tags.memo
}
f_memo_add_memo_js() {
  mkdir -p third_party
  git submodule add https://github.com/tktwr/memo_js.git third_party/memo_js
}
#------------------------------------------------------
MEMO_DIRS="\
  $MY_MEMO \
  $MY_LOCAL_CONFIG/memo \
  $MY_DIARY \
  "
f_memos_status()     { for-dir.sh "mymake.sh f_git_submodule_status"     $MEMO_DIRS; }
f_memos_update()     { for-dir.sh "mymake.sh f_git_submodule_update_all" $MEMO_DIRS; }
