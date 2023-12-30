#!/bin/bash

# expand env variables
url=$(eval "echo $*")

chrome.sh "$url"
