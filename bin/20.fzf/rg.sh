#!/bin/bash

rg --with-filename --column --line-number --no-heading --color=always --smart-case $*
