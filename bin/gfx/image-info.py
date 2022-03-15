#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import cv_util as cu


if __name__ == "__main__":
    for fname in sys.argv[1:]:
        try:
            cu.cv_info(fname)
        except Exception as e:
            print(f'fail to get info ... {fname}')

