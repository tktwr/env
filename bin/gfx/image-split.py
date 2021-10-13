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

    img = cv2.imread(ifname, cv2.IMREAD_ANYCOLOR|cv2.IMREAD_ANYDEPTH)
    h, w, ch = cu.cv_size(img)
    if ch == 3:
        img_b = img[:, :, 0]
        img_g = img[:, :, 1]
        img_r = img[:, :, 2]
        ofname_b = f"{name}_b{ext}"
        cv2.imwrite(ofname_b, img_b)
        ofname_g = f"{name}_g{ext}"
        cv2.imwrite(ofname_g, img_g)
        ofname_r = f"{name}_r{ext}"
        cv2.imwrite(ofname_r, img_r)


if __name__ == "__main__":
    f_image_split(sys.argv[1])

