#!/bin/bash

f_tags_filter() {
  sed 's+C:/msys64+/c/msys64+' | sed 's+C:/Users+/c/Users+'
}

ctags -f - -R "$@" | f_tags_filter

