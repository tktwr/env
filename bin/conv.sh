#!/bin/bash

source common.sh

#opt="-geometry 1280"
#opt="-colorspace gray"
ext=".jpg"

for i in $*
do
  fname=`f_get_fname $i`
  name=`f_get_name $fname`
  f_eval "convert $opt $i $name$ext"
done

