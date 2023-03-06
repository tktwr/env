#!/bin/bash

git.exe remote add origin "$1"
git.exe push -u origin --all
git.exe push -u origin --tags
