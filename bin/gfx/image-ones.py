#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import cv2
import cv_util as cu
import numpy as np


def img_ones(ofname, w, h, val):
    img = np.ones((h, w))
    img = np.clip(img * val, 0, 255).astype(np.uint8)
    cu.cv_save(ofname, img)


if __name__ == "__main__":
    ofname = sys.argv[1]
    w = int(sys.argv[2])
    h = int(sys.argv[3])
    val = float(sys.argv[4])

    img_ones(ofname, w, h, val)

