#!/bin/bash

mycmake.sh make Release
cp build.make/Release/compile_commands.json .
