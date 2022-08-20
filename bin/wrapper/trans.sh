#!/bin/bash

echo "$@" > ~/trans.log
exec trans "$@"
