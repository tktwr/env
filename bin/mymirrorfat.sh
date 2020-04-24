#!/bin/bash

rsync -avRC --delete --size-only -O --no-g --no-p "$@"

