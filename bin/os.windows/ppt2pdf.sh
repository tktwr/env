#!/bin/bash


export PATH="$SYS_PROG64_DIR/LibreOffice/program:$PATH"

soffice.exe --headless --invisible --convert-to pdf "$@"

