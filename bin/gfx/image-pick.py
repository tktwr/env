#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import cv_util as cu


if __name__ == "__main__":
    fname = sys.argv[1]
    x = int(sys.argv[2])
    y = int(sys.argv[3])
    val = cu.cv_pick(fname, x, y)
    print(val)

