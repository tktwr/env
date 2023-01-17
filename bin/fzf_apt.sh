#!/bin/bash

apt list "$@" 2> /dev/null | fzf --prompt 'apt search > ' --preview 'preview_apt.sh {}'
