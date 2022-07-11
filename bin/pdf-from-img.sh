#!/bin/bash
#
# USAGE:
#   pdf-from-img.sh image_dir
#
# OUTPUT:
#   image_dir.pdf

f_conv() {
  convert $1/*.jpg $1.pdf
}

f_conv $1
