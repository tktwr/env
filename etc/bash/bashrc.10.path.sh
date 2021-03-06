#!/bin/bash

#======================================================
# path
#======================================================

# system path
if [ -z "$SYS_PATH" ]; then
  export SYS_PATH=$PATH
  export SYS_MANPATH=$MANPATH
  export SYS_INFOPATH=$INFOPATH
  export SYS_LD_LIBRARY_PATH=$LD_LIBRARY_PATH
  export SYS_PYTHONPATH=$PYTHONPATH
fi

export PATH="$SYS_PATH"
export MANPATH="$SYS_MANPATH"
export INFOPATH="$SYS_INFOPATH"
export LD_LIBRARY_PATH="$SYS_LD_LIBRARY_PATH"
export PYTHONPATH="$SYS_PYTHONPATH"

MANPATH="/usr/local/share/man:$MANPATH"

for i in $MY_OPT/usr/local; do
  PATH="$i/bin:$PATH"
  LD_LIBRARY_PATH="$i/bin:$LD_LIBRARY_PATH"
  LD_LIBRARY_PATH="$i/lib:$LD_LIBRARY_PATH"
  MANPATH="$i/share/man:$MANPATH"
  INFOPATH="$i/share/info:$INFOPATH"
done

for i in $MY_REMOTE_CONFIG/env $MY_LOCAL_CONFIG/env; do
  PATH="$i/bin:$PATH"
  PATH="$i/bin/os.$MY_OS_NAME:$PATH"
  PATH="$i/bin/shell.$MY_SHELL_NAME:$PATH"
  PATH="$i/bin/site.$MY_SITE_NAME:$PATH"
  PATH="$i/bin/host.$MY_HOST_NAME:$PATH"
  PATH="$i/share/dict:$PATH"
done

