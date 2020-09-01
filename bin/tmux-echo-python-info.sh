#!/bin/bash

python_type=$(mypython.sh --python-type)
python_venv=$(mypython.sh --python-venv)
echo "$python_type,$python_venv"
