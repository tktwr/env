#!/bin/bash

url=$1
dir=$2

svn export $url/trunk/$dir
