#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import cv2
import cv_util as cu
import numpy as np
from ttpy import FileName


def f_image_split(ifname):
    fname = FileName(ifname)
    name = fname.name()
    ext = fname.ext()
    ext = ".png"

    img = cu.cv_load(ifname)
    h, w, ch = cu.cv_size(img)

    if ch >= 3:
        img_b = img[:, :, 0]
        ofname_b = f"{name}_b{ext}"
        cu.cv_save(ofname_b, img_b)

        img_g = img[:, :, 1]
        ofname_g = f"{name}_g{ext}"
        cu.cv_save(ofname_g, img_g)

        img_r = img[:, :, 2]
        ofname_r = f"{name}_r{ext}"
        cu.cv_save(ofname_r, img_r)

    if ch >= 4:
        img_a = img[:, :, 3]
        ofname_a = f"{name}_a{ext}"
        cu.cv_save(ofname_a, img_a)


if __name__ == "__main__":
    f_image_split(sys.argv[1])

