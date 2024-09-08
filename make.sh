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
VIM_FILES="\
$MY_ENV/etc/vim/*.vim \
$MY_ENV/etc/vim/vim-plug/*.vim \
$MY_ENV/etc/vim/plugin \
$MY_VIM_PLUGGED_DIR/vim-ide-style \
"

#======================================================
# functions
#======================================================
f_10_git_status()  { for-dir.sh "git.sh status -s"    $GIT_DIRS; }
f_11_git_graph()   { for-dir.sh "git-graph.sh -1"     $GIT_DIRS; }
f_12_git_fetch()   { for-dir.sh "git.sh fetch"        $GIT_DIRS; }
f_13_git_pull()    { for-dir.sh "git.sh pull"         $GIT_DIRS; }

f_20_git_tar()     { for-dir.sh "git-tar.sh $MY_SNAP" $SNAP_DIRS; }
f_21_git_tar_wip() { tar czvf wip.tar.gz $(git.sh diff --name-only); }

f_30_cpp_build()   { for-dir.sh "make all"            $BUILD_DIRS; }
f_31_cpp_clean()   { for-dir.sh "make all.clean"      $BUILD_DIRS; }

f_tags() {
  ctags -o .tags.bin_sh -R bin/*.sh bin/*/*.sh
  ctags -o .tags.bin_py -R bin/py/*.py
  ctags -o .tags.bash   -R etc/bash/*.sh
  ctags -o .tags.vim    -R $VIM_FILES
}

#======================================================
# main
#======================================================
f_fzf_default() { f_10_git_status; }
f_fzf_main "$@"
