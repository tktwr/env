#!/bin/bash

export PATH="$SYS_PROG64_DIR/LibreOffice/program:$PATH"

exec soffice.exe --headless --invisible --convert-to pdf "$@"
