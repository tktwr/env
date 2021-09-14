#!/bin/bash

#find "$@" -name '*.h' -o -name '*.cpp' -print
find "$@" -name '*.h' -o -name '*.cpp' -exec clang-format -i {} \;

