#!/bin/bash

url=$(_f_expand "$*")

gvim.sh "$url"
