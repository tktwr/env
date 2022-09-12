#!/bin/bash

#======================================================
# path
#======================================================

# system path
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

MANPATH="/usr/local/share/man:$MANPATH"

for i in $MY_OPT/usr/local; do
  PATH="$i/bin:$PATH"
  LD_LIBRARY_PATH="$i/bin:$LD_LIBRARY_PATH"
  LD_LIBRARY_PATH="$i/lib:$LD_LIBRARY_PATH"
  MANPATH="$i/share/man:$MANPATH"
  INFOPATH="$i/share/info:$INFOPATH"
done

for i in $MY_ENV; do
  PATH="$i/bin:$PATH"
  PATH="$i/bin/cron:$PATH"
  PATH="$i/bin/sys:$PATH"
  PATH="$i/bin/gfx:$PATH"
  PATH="$i/bin/wrapper:$PATH"
  PATH="$i/bin/external:$PATH"
  PATH="$i/bin/experimental:$PATH"
  PATH="$i/bin/os.$MY_OS_NAME:$PATH"
done

