#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import cv2
import numpy as np
from ttpy import ImageSize
from ttpy import FileName


#======================================================
# interface for image
#======================================================

def cv_size(img):
    if len(img.shape) == 3:
        h, w, ch = img.shape[:3]
    else:
        h, w = img.shape[:2]
        ch = 1
    return (h, w, ch)


def cv_crop_img(img, pos, size):
    top    = pos[1]
    bottom = pos[1] + size[1]
    left   = pos[0]
    right  = pos[0] + size[0]
    return img[top:bottom, left:right]


def cv_crop_center_img(img, center, size):
    pos = [0, 0]
    pos[0] = center[0] - (size[0] // 2)
    pos[1] = center[1] - (size[1] // 2)
    return cv_crop_img(img, pos, size)


def cv_resize_img(img, dst_size):
    h, w = img.shape[:2]

    img_size = ImageSize((w, h))
    new_size = img_size.getSize(dst_size)

    return cv2.resize(img, new_size, interpolation=cv2.INTER_AREA)


#======================================================
# interface for file
#======================================================

def cv_info(fname):
    img = cv2.imread(fname, cv2.IMREAD_ANYCOLOR|cv2.IMREAD_ANYDEPTH)
    h, w, ch = cv_size(img)

    print(f'filename  = {fname}')
    print(f"img.shape = {img.shape}")
    print(f"height    = {h}")
    print(f"width     = {w}")
    print(f"channels  = {ch}")
    print(f"img.dtype = {img.dtype}")
    print(f"type(img) = {type(img)}")
    print(f'---')


def cv_pick(fname, x, y):
    img = cv2.imread(fname, cv2.IMREAD_ANYCOLOR|cv2.IMREAD_ANYDEPTH)
    return img[y, x]


def cv_resize(ifname, ofname, dst_size):
    img = cv2.imread(ifname, cv2.IMREAD_ANYCOLOR|cv2.IMREAD_ANYDEPTH)
    oimg = cv_resize_img(img, dst_size)
    cv2.imwrite(ofname, oimg)

    print(f"cv_resize {ifname} {ofname} {new_size}")


def cv_load(ifname):
    return cv2.imread(ifname, cv2.IMREAD_ANYCOLOR|cv2.IMREAD_ANYDEPTH)


def cv_save(ifname, img):
    fname = FileName(ifname)
    ext = fname.ext()

    if img.dtype == np.uint8:
        if ext == ".png":
            print(f"cv_save: {ifname}:")
            cv2.imwrite(ifname, img)
    elif img.dtype == np.uint16:
        if ext == ".png":
            print(f"cv_save: {ifname}: convert uint16 to png")
    elif img.dtype == np.float32:
        if ext == ".png":
            print(f"cv_save: {ifname}: convert float32 to png")
            oimg = np.clip(img * 255, 0, 255).astype(np.uint8)
            cv2.imwrite(ifname, oimg)


#======================================================
# tiling image
#======================================================

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

