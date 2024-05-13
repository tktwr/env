#!/bin/bash

url=$(_f_expand "$*")

chrome.sh "$url"
