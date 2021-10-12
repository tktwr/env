#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import cv_util as cu


if __name__ == "__main__":
    for fname in sys.argv[1:]:
        cu.cv_info(fname)

