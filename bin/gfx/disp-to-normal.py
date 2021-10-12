#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import cv2
import numpy as np


def normalize_vector(v):
    l = np.sqrt(v[0]**2 + v[1]**2 + v[2]**2)
    return v / l


def depth_to_normal(ifname, ofname):
    gray_img = cv2.imread(ifname, cv2.IMREAD_ANYCOLOR|cv2.IMREAD_ANYDEPTH)
    if len(gray_img.shape) == 3:
        h, w, ch = gray_img.shape[:3]
        gray_img = gray_img[:, :, 0]
    else:
        h, w = gray_img.shape[:2]
        ch = 1

    gray_img = gray_img.astype('float')

    # exr: if value is [0, 1]
    #gray_img *= 65536.0
    gray_img *= 256.0

    nml_img = np.zeros((h, w, 3), dtype=float)

    for y in range(1, h-1):
        for x in range(1, w-1):
            dzdx = (gray_img[y, x+1] - gray_img[y, x-1]) / 2.0
            dzdy = (gray_img[y+1, x] - gray_img[y-1, x]) / 2.0
            d = (-dzdx, dzdy, 1.0)
            n = normalize_vector(d)
            nml_img[y, x] = n * 0.5 + 0.5
    nml_img *= 255
    nml_img = nml_img.astype('uint8')
    nml_img = cv2.cvtColor(nml_img, cv2.COLOR_RGB2BGR)
    cv2.imwrite(f"{ofname}", nml_img)


def main(argv):
    depth_to_normal(argv[1], argv[2])


if __name__ == "__main__":
    main(sys.argv)

