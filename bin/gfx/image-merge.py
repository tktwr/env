#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import cv2
import cv_util as cu
import numpy as np


def f_image_merge(ofname, ifnames):
    print(f"ofname  = {ofname}")
    print(f"ifnames = {ifnames}")

    h = 100
    w = 100
    ch = 1
    dtype = np.uint8

    img_list = []
    for i in ifnames:
        if i == "zero":
            img = np.zeros((h, w, ch), dtype)
        elif i == "one":
            img = np.ones((h, w, ch), dtype)
        else:
            img = cv2.imread(i, cv2.IMREAD_ANYCOLOR|cv2.IMREAD_ANYDEPTH)
            h, w, ch = cu.cv_size(img)
            dtype = img.dtype

        img_list.append(img)

    img_out = cv2.merge(img_list)
    cv2.imwrite(ofname, img_out)


if __name__ == "__main__":
    f_image_merge(sys.argv[1], sys.argv[2:])

