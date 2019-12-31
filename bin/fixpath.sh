#!/bin/sh

echo "$@" | sed 's+[\]+/+g'

