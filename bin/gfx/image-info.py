#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import img_util as iu


if __name__ == "__main__":
    for fname in sys.argv[1:]:
        print(f'filename: {fname}')
        iu.img_info(fname)
        print(f'---')

