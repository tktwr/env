#!/bin/bash

f_conda_info()      { conda info; }
f_conda_info_envs() { conda info -e; }
f_conda_list()      { conda list; }

f_conda_00_init() {
  conda init bash
}
f_conda_10_create() {
  name='$(basename $PWD)'
  conda create -n $name --prefix .conda_env
}
f_conda_10_remove() {
  name='$(basename $PWD)'
  conda remove -n $name --all
}
f_conda_10_activate() {
  name='$(basename $PWD)'
  conda activate $name
}
f_conda_10_deactivate() {
  conda deactivate
}
