#!/bin/bash

exec exa -lFG --icons --git --group-directories-first --no-permissions --no-filesize --no-user --no-time "$@"
