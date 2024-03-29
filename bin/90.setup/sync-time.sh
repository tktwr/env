#!/bin/bash

USERPROFILE=$(cmd.exe /c echo "%USERPROFILE%" 2>/dev/null | tr -d \\r)
USERPROFILE=$(wslpath $USERPROFILE)

timestamp="$USERPROFILE/.wsltimestamp"

date --rfc-3339=ns
touch "$timestamp"
windate=$(date --rfc-3339=ns -r "$timestamp")
sudo date --rfc-3339=ns -s "$windate"
