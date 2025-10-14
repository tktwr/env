#!/bin/bash

f_blender_clean() {
  rm $APP_L/Temp/*_autosave.blend
}
#======================================================
# all
#======================================================
f_all_env_tags() {
  local VIM_FILES="\
    $MY_ENV/etc/vim/*.vim \
    $MY_ENV/etc/vim/vim-plug/*.vim \
    $MY_ENV/etc/vim/plugin \
    $MY_VIM_PLUGGED_DIR/vim-ide-style \
    "
  cd $MY_ENV
  ctags -o .tags.bin_sh -R bin/*.sh bin/*/*.sh
  ctags -o .tags.bin_py -R bin/py/*.py
  ctags -o .tags.bash   -R etc/bash/*.sh
  ctags -o .tags.vim    -R $VIM_FILES
}
f_all_env_dot_backup() {
  cd $MY_ETC
  mymake.sh f_dot_backup_tar
}
#------------------------------------------------------
GIT_DIRS="\
  $MY_ENV \
  $MY_MEMO \
  $MY_SAMPLES \
  $MY_LIBTT \
  $MY_REMOTE_CONFIG/templates \
  $MY_VIM_PLUGGED_DIR/vim-ide-style \
  "
f_all_env_status()      { for-dir.sh "git.sh status -s"    $GIT_DIRS; }
f_all_env_graph()       { for-dir.sh "git-graph.sh -1"     $GIT_DIRS; }
f_all_env_fetch()       { for-dir.sh "git.sh fetch"        $GIT_DIRS; }
f_all_env_pull()        { for-dir.sh "git.sh pull"         $GIT_DIRS; }
#------------------------------------------------------
BUILD_DIRS="\
  $MY_LIBTT \
  $MY_SAMPLES/cpp \
  $MY_SAMPLES/cpp_lib \
  "
f_all_env_build()       { for-dir.sh "make all"            $BUILD_DIRS; }
f_all_env_build_clean() { for-dir.sh "make all.clean"      $BUILD_DIRS; }
#------------------------------------------------------
MEMO_DIRS="\
  $MY_MEMO \
  $MY_LOCAL_CONFIG/memo \
  $MY_DIARY \
  "
f_all_memo_status()     { for-dir.sh "mymake.sh f_git_submodule_status"     $MEMO_DIRS; }
f_all_memo_update()     { for-dir.sh "mymake.sh f_git_submodule_update_all" $MEMO_DIRS; }
#------------------------------------------------------
SNAP_DIRS="\
  $MY_ENV \
  $MY_DIARY \
  $MY_SECRET \
  "
f_all_snap() { for-dir.sh "git-tar.sh $MY_SNAP" $SNAP_DIRS; }

#======================================================
# daily
#======================================================
f_cron_daily_update() {
  f_vim_plug_update
}
#======================================================
# weekly
#======================================================
f_cron_weekly_tags() {
  local MEMO_TAGS_DIRS="\
    $MY_ENV \
    $MY_MEMO \
    $MY_LOCAL_CONFIG/memo \
    $MY_DIARY \
    "
  for-dir.sh "mymake.sh f_memo_tags" $MEMO_TAGS_DIRS

  local C_TAGS_DIRS="\
    $MY_LIBTT \
    $MY_SAMPLES \
    "
  for-dir.sh "mymake.sh f_tags" $C_TAGS_DIRS

  local PLUG_DIRS="\
    $MY_VIM_PLUGGED_DIR/vim-ide-style/doc \
    "
  for-dir.sh "helptags.sh" $PLUG_DIRS
}
f_cron_weekly_build() {
  cd $MY_BIN/50.tool.img/image-viewer
  mymake.sh f_dist
  mymake.sh f_install
}
#======================================================
# monthly
#======================================================
f_cron_monthly_tags() {
  local C_TAGS_DIRS="\
    $MY_GITHUB \
    "
  for-dir.sh "mymake.sh f_tags" $C_TAGS_DIRS
}
f_cron_monthly_clean() {
  f_blender_clean
}
f_cron_monthly_backup() {
  f_all_snap
  f_all_env_dot_backup
}
