#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import cv2
from ttpy import ImageSize


def cv_resize(ifname, ofname, dst_size):
    img = cv2.imread(ifname, cv2.IMREAD_COLOR)
    h, w = img.shape[:2]

    img_size = ImageSize((w, h))
    new_size = img_size.getSize(dst_size)

    oimg = cv2.resize(img, new_size, interpolation=cv2.INTER_AREA)
    cv2.imwrite(ofname, oimg)

    print(f"cv_resize {ifname} {ofname} {new_size}")


