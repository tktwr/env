#!/bin/bash

f_mkpydist() {
  cp $MY_ENV/share/app.ico .
  cp $1 .

  fname=$(basename $1)

  pyinstaller $fname --onefile --noconsole --icon app.ico
}

f_mkpydist $1

