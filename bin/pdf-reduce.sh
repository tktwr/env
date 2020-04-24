#!/bin/bash

source common.sh

opt=""
# screen: 72dpi
#opt="-dPDFSETTINGS=//screen"
# ebook: 150dpi
#opt="-dPDFSETTINGS=//ebook"
# prepress: 300dpi
opt="-dPDFSETTINGS=//prepress"
# printer: 300dpi
#opt="-dPDFSETTINGS=//printer"
# default:
#opt="-dPDFSETTINGS=//default"

files=$*

for i in $files; do
  fname=`f_get_fname $i`
  f_eval "ps2pdf $opt $i $fname"
done

