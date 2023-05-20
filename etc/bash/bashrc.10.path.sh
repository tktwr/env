#!/bin/bash

#======================================================
# path
#======================================================
f_add_path()      { export PATH="$PATH:$*"; }
f_add_path_py()   { export PYTHONPATH="$PYTHONPATH:$*"; }
f_add_path_ld()   { export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$*"; }
f_add_path_man()  { export MANPATH="$MANPATH:$*"; }
f_add_path_info() { export INFOPATH="$INFOPATH:$*"; }

f_ins_path()      { export PATH="$*:$PATH"; }
f_ins_path_py()   { export PYTHONPATH="$*:$PYTHONPATH"; }
f_ins_path_ld()   { export LD_LIBRARY_PATH="$*:$LD_LIBRARY_PATH"; }
f_ins_path_man()  { export MANPATH="$*:$MANPATH"; }
f_ins_path_info() { export INFOPATH="$*:$INFOPATH"; }

#------------------------------------------------------
f_init_path() {
  if [ -z "$SYS_PATH" ]; then
    export SYS_PATH=$PATH
    export SYS_PYTHONPATH=$PYTHONPATH
    export SYS_LD_LIBRARY_PATH=$LD_LIBRARY_PATH
    export SYS_MANPATH=$MANPATH
    export SYS_INFOPATH=$INFOPATH
  fi

  export PATH="$SYS_PATH"
  export PYTHONPATH="$SYS_PYTHONPATH"
  export LD_LIBRARY_PATH="$SYS_LD_LIBRARY_PATH"
  export MANPATH="$SYS_MANPATH"
  export INFOPATH="$SYS_INFOPATH"
}

f_ins_path_local() {
  local pth=$1
  f_ins_path      "$pth/bin"
  f_ins_path_ld   "$pth/bin"
  f_ins_path_ld   "$pth/lib"
  f_ins_path_man  "$pth/share/man"
  f_ins_path_info "$pth/share/info"
}

my_setup_path_env() {
  f_ins_path "$MY_ENV/bin"
  dirs=$(/bin/ls -d $MY_ENV/bin/[0-9]?.*/)
  for i in $dirs; do
    f_ins_path "$i"
  done
}

my_setup_path_os() {
  f_ins_path "$MY_ENV/bin/os.$MY_OS_NAME"
}

#------------------------------------------------------
f_init_path
f_ins_path_man "/usr/local/share/man"
#f_ins_path_local $MY_ROAMING/usr/local
my_setup_path_env
