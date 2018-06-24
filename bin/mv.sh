#!/bin/sh

ls -d $* | awk '{print "mv", $1, dst-$1}'
