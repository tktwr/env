#!/bin/bash

#======================================================
# dirs
#======================================================
GIT_DIRS="\
  $MY_ENV \
  $MY_MEMO \
  $MY_SAMPLES \
  $MY_LIBTT \
  $MY_REMOTE_CONFIG/templates \
  $MY_VIM_PLUGGED_DIR/vim-ide-style \
  "
SNAP_DIRS="\
  $MY_ENV \
  $MY_DIARY \
  $MY_SECRET \
  "
BUILD_DIRS="\
  $MY_LIBTT \
  $MY_SAMPLES/cpp \
  $MY_SAMPLES/cpp_lib \
  "
MONTHLY_TAGS_DIRS="\
  $MY_GITHUB \
  "
WEEKLY_TAGS_DIRS="\
  $MY_ENV \
  $MY_LIBTT \
  $MY_SAMPLES \
  $MY_MEMO \
  $MY_LOCAL_CONFIG/memo \
  $MY_DIARY \
  "
PLUG_DIRS="\
  $MY_VIM_PLUGGED_DIR/vim-ide-style/doc \
  "
MEMO_DIRS="\
  $MY_MEMO \
  $MY_LOCAL_CONFIG/memo \
  $MY_DIARY \
  "
#======================================================
# util
#======================================================
f_util_tags() {
  memotags.sh 'memo:' *.html > tags.memo
}
f_util_add_memo_js() {
  mkdir -p third_party
  git submodule add https://github.com/tktwr/memo_js.git third_party/memo_js
}
#======================================================
# all monthly
#======================================================
f_all_monthly_tags() {
  for-dir.sh "mymake.sh f_tags" ${MONTHLY_TAGS_DIRS}
}
f_all_monthly_clean() {
  rm $APP_L/Temp/*_autosave.blend
}
f_all_monthly_backup() {
  for-dir.sh "git-tar.sh $MY_SNAP" $SNAP_DIRS
  cd $MY_ETC
  mymake.sh f_backup_tar
}
#======================================================
# all weekly
#======================================================
f_all_weekly_tags() {
  for-dir.sh "mymake.sh f_tags" ${WEEKLY_TAGS_DIRS}
  for-dir.sh "helptags.sh" ${PLUG_DIRS}
}
f_all_weekly_build() {
  cd $MY_BIN/50.tool.img/image-viewer
  mymake.sh f_dist
  mymake.sh f_install
}
#======================================================
# all
#======================================================
f_all_memo_status() { for-dir.sh "mymake.sh f_status" ${MEMO_DIRS}; }
#======================================================
# env
#======================================================
f_all_env_status()      { for-dir.sh "git.sh status -s"    $GIT_DIRS; }
f_all_env_graph()       { for-dir.sh "git-graph.sh -1"     $GIT_DIRS; }
f_all_env_fetch()       { for-dir.sh "git.sh fetch"        $GIT_DIRS; }
f_all_env_pull()        { for-dir.sh "git.sh pull"         $GIT_DIRS; }
f_all_env_build()       { for-dir.sh "make all"            $BUILD_DIRS; }
f_all_env_build_clean() { for-dir.sh "make all.clean"      $BUILD_DIRS; }

