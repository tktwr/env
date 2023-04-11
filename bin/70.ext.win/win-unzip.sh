#!/bin/bash

zip_file="$1"
powershell.exe expand-archive "$zip_file"
