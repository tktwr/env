#!/bin/bash

cp bashrc_all.sh $HOME/.bashrc
./expand_env.sh > $HOME/.bashrc.env

