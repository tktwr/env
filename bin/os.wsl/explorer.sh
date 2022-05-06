#!/bin/bash

wp=$(pathconv.sh win "$*")
exec explorer.exe "$wp" > /dev/null 2>&1 &
