#!/bin/bash

ls -d "$@" | awk '{print "mv", $0, $0}'
