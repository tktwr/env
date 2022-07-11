#!/bin/bash
#
# USAGE:
#   pdf-to-img.sh file.pdf
#
# OUTPUT:
#   img_NUMdpi_NAME/page-*.jpg

source common.sh

#DPI=150
DPI=300

f_pdftoimg() {
  pdftocairo -jpeg -r $DPI $1 $2/page
  #pdftoppm -jpeg -r $DPI $1 $2/page
}

name=`f_get_name $1`
odir=img_${DPI}dpi_$name
mkdir -p $odir

f_pdftoimg $1 $odir
