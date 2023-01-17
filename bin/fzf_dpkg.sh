#!/bin/bash

dpkg --get-selections | awk '{print $1}' | fzf --prompt 'dpkg > ' --preview 'dpkg -L {}'
