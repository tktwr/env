#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import cv_util as cu


def main(argv):
    fname = argv[1]
    pos = (int(argv[2]), int(argv[3]))
    size = (int(argv[4]), int(argv[5]))

    img = cu.cv_load(fname)
    img_crop = cu.cv_crop_img_simple(img, pos, size)
    cu.cv_save(f'crop_{fname}', img_crop)


if __name__ == "__main__":
    main(sys.argv)

