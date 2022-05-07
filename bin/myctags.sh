#!/bin/bash

f_tags_filter() {
  sed -e 's+C:/msys64+/c/msys64+' -e 's+C:/Users+/c/Users+'
}

ctags -f - -R "$@" | f_tags_filter

