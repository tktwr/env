#!/bin/bash

ls -d $* | awk '{print "mv", $1, $1}'
