#!/bin/bash

#======================================================
# colors
#======================================================
export BAT_THEME='gruvbox-dark'

# tw: スティッキビットありother書き込み権限つきディレクトリ
# ow: スティッキビットなしother書き込み権限つきディレクトリ

# ls colors
LS_COLORS=""
LS_COLORS="$LS_COLORS:di=31"
LS_COLORS="$LS_COLORS:ln=31"
LS_COLORS="$LS_COLORS:tw=31:ow=31"
LS_COLORS="$LS_COLORS:ex=0"

LS_COLORS="$LS_COLORS:*.cpp=32"
LS_COLORS="$LS_COLORS:*.c=32"
LS_COLORS="$LS_COLORS:*.h=36"
LS_COLORS="$LS_COLORS:*.py=33"
LS_COLORS="$LS_COLORS:*.sh=35"
#LS_COLORS="$LS_COLORS:*.vim=32"
LS_COLORS="$LS_COLORS:*.html=33"
LS_COLORS="$LS_COLORS:*.glb=36"
LS_COLORS="$LS_COLORS:*.blend=36"
LS_COLORS="$LS_COLORS:*.png=35:*.jpg=35"
LS_COLORS="$LS_COLORS:*.tif=33:*.exr=33"
LS_COLORS="$LS_COLORS:*CMakeLists.txt=37"
LS_COLORS="$LS_COLORS:*Makefile=37"
LS_COLORS="$LS_COLORS:*make.sh=30;47"

export LS_COLORS

# colors
export COLOR0="\033[30m"  # black
export COLOR1="\033[31m"  # red
export COLOR2="\033[32m"  # green
export COLOR3="\033[33m"  # yellow
export COLOR4="\033[34m"  # blue
export COLOR5="\033[35m"  # magenta
export COLOR6="\033[36m"  # cyan
export COLOR7="\033[37m"  # white
export COLORD="\033[0m"   # default
export COLORR="\033[7m"   # reverse

export ECO0="\[$COLOR0\]"
export ECO1="\[$COLOR1\]"
export ECO2="\[$COLOR2\]"
export ECO3="\[$COLOR3\]"
export ECO4="\[$COLOR4\]"
export ECO5="\[$COLOR5\]"
export ECO6="\[$COLOR6\]"
export ECO7="\[$COLOR7\]"
export ECOD="\[$COLORD\]"
export ECOR="\[$COLORR\]"

