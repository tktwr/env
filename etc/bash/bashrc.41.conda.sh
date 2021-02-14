#!/bin/bash

#======================================================
# conda
#======================================================

conda-upgrade() { conda update -n base -c defaults conda; }
conda-venv-info() { conda info -e; }
conda-venv-create() { conda create -n $1 python; }
conda-venv-activate() { conda activate $1; }
conda-venv-deactivate() { conda deactivate; }
conda-venv-remove() { conda remove -n $1 --all; }
conda-venv-move() {
  conda create -n $2 --clone $1;
  conda remove -n $1 --all;
}

