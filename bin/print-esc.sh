#!/bin/sh

# 0 end
# 7 reverse video
#
# \033          ascii ESCape
# \033[<NUM>G   move to column <NUM> (linux console, xterm, not vt100)
# \033[<NUM>C   move <NUM> columns forward but only upto last column
# \033[<NUM>D   move <NUM> columns backward but only upto first column
# \033[<NUM>A   move <NUM> rows up
# \033[<NUM>B   move <NUM> rows down
# \033[1m       switch on bold
# \033[31m      switch on red
# \033[32m      switch on green
# \033[33m      switch on yellow
# \033[m        switch off color/bold
# \017          exit alternate mode (xterm, vt100, linux console)
# \033[10m      exit alternate mode (linux console)
# \015          carriage return (without newline)

esc="\033["
f_esc ()
{
  att=$1
  for i in 30 31 32 33 34 35 36 37; do
    word="${att};${i}"
    echo -e "${esc}${att};${i}m${word}${esc}0m"
  done
}

f_all ()
{
  #echo "none"
  f_esc 00
  #echo "bold"
  f_esc 01
  #echo "underscore"
  f_esc 04
  #echo "blink"
  f_esc 05
  #echo "reverse"
  f_esc 07
}

f_all | column -c 80

echo -e "${esc}20GHello world."
COLUMNS=80
echo -e "${esc}${COLUMNS}C${esc}20DHello world."
echo -e "${esc}1AHello world."

