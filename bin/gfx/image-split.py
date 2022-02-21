#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import cv2
import cv_util as cu
import numpy as np
import tt_util as tu


def f_image_split(ifname):
    fname = tu.FileName(ifname)
    name = fname.name()
    ext = fname.ext()
    ext = ".png"

    img = cu.cv_load(ifname)

    img_list = cu.cv_split_img(img)
    idx = 0
    for i in img_list:
        ofname = f"{name}_{idx}{ext}"
        cu.cv_save(ofname, i)
        idx += 1


if __name__ == "__main__":
    f_image_split(sys.argv[1])

