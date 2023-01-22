#!/bin/bash

src=$(basename $(pwd))
dst=../${src}_tags

if [ ! -d "$dst" ]; then
  echo "make tags_dir: [$dst]"
  mkdir $dst
  cd $dst
  ln -s ../${src} doc
fi
