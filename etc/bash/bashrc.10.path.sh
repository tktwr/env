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

#------------------------------------------------------
export MANPATH="/usr/local/share/man:$MANPATH"

for i in $MY_OPT/usr/local; do
  export PATH="$i/bin:$PATH"
  export LD_LIBRARY_PATH="$i/bin:$LD_LIBRARY_PATH"
  export LD_LIBRARY_PATH="$i/lib:$LD_LIBRARY_PATH"
  export MANPATH="$i/share/man:$MANPATH"
  export INFOPATH="$i/share/info:$INFOPATH"
done

for i in $MY_ENV; do
  export PATH="$i/bin:$PATH"
  export PATH="$i/bin/cron:$PATH"
  export PATH="$i/bin/sys:$PATH"
  export PATH="$i/bin/gfx:$PATH"
  export PATH="$i/bin/wrapper:$PATH"
  export PATH="$i/bin/external:$PATH"
  export PATH="$i/bin/experimental:$PATH"
  export PATH="$i/bin/os.$MY_OS_NAME:$PATH"
  export PATH="$i/bin/test:$PATH"
  export PATH="$i/setup:$PATH"
done

