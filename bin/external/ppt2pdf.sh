#!/bin/bash

export PATH="$SYS_PROG64_DIR/LibreOffice/program:$PATH"

exec $WINPTY soffice.exe --headless --invisible --convert-to pdf "$@"
