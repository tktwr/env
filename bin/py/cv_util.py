#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import cv2
from ttpy import ImageSize


def cv_info(fname):
    img = cv2.imread(fname, cv2.IMREAD_ANYCOLOR|cv2.IMREAD_ANYDEPTH)
    if len(img.shape) == 3:
        height, width, channels = img.shape[:3]
    else:
        height, width = img.shape[:2]
        channels = 1

    print(f"img.shape = {img.shape}")
    print(f"height    = {height}")
    print(f"width     = {width}")
    print(f"channels  = {channels}")
    print(f"img.dtype = {img.dtype}")
    print(f"type(img) = {type(img)}")


def cv_resize(ifname, ofname, dst_size):
    img = cv2.imread(ifname, cv2.IMREAD_COLOR)
    h, w = img.shape[:2]

    img_size = ImageSize((w, h))
    new_size = img_size.getSize(dst_size)

    oimg = cv2.resize(img, new_size, interpolation=cv2.INTER_AREA)
    cv2.imwrite(ofname, oimg)

    print(f"cv_resize {ifname} {ofname} {new_size}")


class ImageTile():
    def __init__(self):
        pass

    def hconcat(self, img_list, interpolation=cv2.INTER_AREA):
        l = []
        for i in img_list:
            if len(i.shape) == 3:
                l.append(i)
            else:
                bgr = cv2.cvtColor(i, cv2.COLOR_GRAY2BGR)
                l.append(bgr)
        h_min = min(i.shape[0] for i in l)
        img_list_resize = [cv2.resize(i, (int(i.shape[1] * h_min / i.shape[0]), h_min), interpolation=interpolation) for i in l]
        return cv2.hconcat(img_list_resize)

    def vconcat(self, img_list, interpolation=cv2.INTER_AREA):
        w_min = min(i.shape[1] for i in img_list)
        img_list_resize = [cv2.resize(i, (w_min, int(i.shape[0] * w_min / i.shape[1])), interpolation=interpolation) for i in img_list]
        return cv2.vconcat(img_list_resize)

    def tile(self, img_list_2d, interpolation=cv2.INTER_AREA):
        img_list_v = [self.hconcat(img_list_h, interpolation) for img_list_h in img_list_2d]
        return self.vconcat(img_list_v, interpolation)

