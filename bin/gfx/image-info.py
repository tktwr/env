#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import img_util as iu
import cv_util as cu


if __name__ == "__main__":
    for fname in sys.argv[1:]:
        print(f'filename: {fname}')
        #iu.img_info(fname)
        cu.cv_info(fname)
        print(f'---')

