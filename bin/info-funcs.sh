#!/bin/bash

source cmd_funcs.sh

f_func_normal() { declare -F | grep '\-f ' | awk '{print $3}' | grep '\<f_'; }
f_sort_funcs() { sort | column; }

n_func_normal=$(f_func_normal | wc -l)

echo "normal: $n_func_normal"
f_func_normal | f_sort_funcs
