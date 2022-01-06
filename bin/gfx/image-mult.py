#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import cv2
import cv_util as cu
import numpy as np


def img_mult(ofname, ifname, val):
    img = cu.cv_load(ifname)
    img = np.clip(img * val, 0, 255).astype(np.uint8)
    cu.cv_save(ofname, img)


if __name__ == "__main__":
    ofname = sys.argv[1]
    ifname = sys.argv[2]
    val = float(sys.argv[3])

    img_mult(ofname, ifname, val)

