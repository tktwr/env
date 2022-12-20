#!/bin/bash

source common.sh

dst_tar=$(f_get_git_snapfname $1.tar.gz)
shift

echo $dst_tar
tar czvf $dst_tar "$@"
