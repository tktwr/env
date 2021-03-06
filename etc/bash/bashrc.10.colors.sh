#!/bin/bash

#======================================================
# colors
#======================================================

# tw: スティッキビットありother書き込み権限つきディレクトリ
# ow: スティッキビットなしother書き込み権限つきディレクトリ

# ls colors
LS_COLORS=""
LS_COLORS="$LS_COLORS:di=34:ex=32:ln=33"
LS_COLORS="$LS_COLORS:tw=34:ow=34"
LS_COLORS="$LS_COLORS:*Makefile=31:*CMakeLists.txt=31"
LS_COLORS="$LS_COLORS:*.c=31:*.C=31:*.cc=31:*.cpp=31:*.cxx=31:*.c++=31"
LS_COLORS="$LS_COLORS:*.h=32:*.H=32:*.hh=32:*.hpp=32:*.hxx=32:*.h++=32"
LS_COLORS="$LS_COLORS:*.o=33:*.a=35:*.lib=35"
LS_COLORS="$LS_COLORS:*.java=31:*.class=33:*.jar=32"
LS_COLORS="$LS_COLORS:*.pl=31"
LS_COLORS="$LS_COLORS:*.html=31:*.htm=31:*.shtml=31:*.php=31"
LS_COLORS="$LS_COLORS:*.md.html=31"
LS_COLORS="$LS_COLORS:*.css=33"
LS_COLORS="$LS_COLORS:*.js=32"
LS_COLORS="$LS_COLORS:*.tex=31:*.cls=32:*.sty=32:*.bib=32:*.eps=35:*.ps=35:*.pdf=36:*.doc=36"
LS_COLORS="$LS_COLORS:*.bak=33:*.old=33"
LS_COLORS="$LS_COLORS:*.tar=32:*.tgz=32:*.zip=32:*.Z=32:*.gz=32:*.bz2=32:*.lzh=32"
LS_COLORS="$LS_COLORS:*.xbm=33:*.xpm=33:*.gif=33:*.ppm=33:*.png=33:*.jpg=33:*.jpeg=33:*.tif=33:*.tiff=33:*.tga=33:*.sgi=33:*.rgb=33:*.bmp=33"
LS_COLORS="$LS_COLORS:*.hdr=34:*.pic=34:*.i3f=34"
LS_COLORS="$LS_COLORS:*.mpg=35:*.avi=35:*.mov=35"
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

