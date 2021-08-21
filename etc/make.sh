#!/bin/bash

./dot.sh --common-files --cp

cd bash
./make.sh
cd ..

cd vim
./make.sh
cd ..

