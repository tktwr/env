#!/bin/bash

sys=$(mycmake.sh --build-sys)
config=$(mycmake.sh --build-config)
echo "$sys,$config"
