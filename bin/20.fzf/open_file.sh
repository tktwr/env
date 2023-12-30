#!/bin/bash

# expand env variables
url=$(eval "echo $*")

gvim.sh "$url"
