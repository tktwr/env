#!/bin/bash

cd $MY_TMP

work_dir=pydist

rm -rf $work_dir
mkdir $work_dir
cd $work_dir

mkpydist.sh $MY_BIN/gfx/image-show-tk.py
cp dist/image-show-tk.exe ~/Desktop/bin

