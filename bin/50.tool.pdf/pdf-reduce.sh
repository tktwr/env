#!/bin/bash

source common.sh

declare -A OPT

# screen   : 72dpi
# ebook    : 150dpi
# prepress : 300dpi
# printer  : 300dpi
# default  :

OPT["screen"]="-dPDFSETTINGS=/screen"
OPT["ebook"]="-dPDFSETTINGS=/ebook"
OPT["prepress"]="-dPDFSETTINGS=/prepress"
OPT["printer"]="-dPDFSETTINGS=/printer"
OPT["default"]="-dPDFSETTINGS=/default"

files="$@"

for i in $files; do
  o=$(f_get_fname $i)
  f_eval "ps2pdf ${OPT["prepress"]} $i $o"
done

