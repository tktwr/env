#!/bin/bash

#======================================================
# util
#======================================================
f_memo_tags() {
  memotags.sh 'memo:' *.html > tags.memo
}
f_memo_add_memo_js() {
  mkdir -p third_party
  git submodule add https://github.com/tktwr/memo_js.git third_party/memo_js
}
