#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import cv2
import numpy as np
from ttpy import FileName
import ttpy as tu


#======================================================
# interface for image
#======================================================

# color32f: [0, 1]
def cv_color(color32f, dtype):
    if dtype == 'uint8':
        color32f = (color32f * 255).astype('uint8')
    elif dtype == 'uint16':
        color32f = (color32f * 65535).astype('uint16')
    elif dtype == 'float32':
        color32f = color32f.astype('float32')
    return color32f


def cv_size(img):
    if len(img.shape) == 3:
        h, w, ch = img.shape[:3]
    else:
        h, w = img.shape[:2]
        ch = 1
    return (h, w, ch)


# pos  : [x, y]
# size : [w, h]
def cv_crop_img_simple(img, pos, size):
    top    = pos[1]
    bottom = pos[1] + size[1]
    left   = pos[0]
    right  = pos[0] + size[0]
    return img[top:bottom, left:right]


# pos  : [x, y]
# size : [w, h]
def cv_crop_img(img, pos, size):
    # region in the img
    h, w = img.shape[:2]

    top    = pos[1]
    bottom = pos[1] + size[1]
    left   = pos[0]
    right  = pos[0] + size[0]

    top = 0 if top < 0 else top
    left = 0 if left < 0 else left
    bottom = h-1 if bottom > h-1 else bottom
    right = w-1 if right > w-1 else right

    crop_img = img[top:bottom, left:right]

    # regin in the dst_img
    shape = list(img.shape)
    shape[0] = size[1]
    shape[1] = size[0]
    dst_img = np.zeros(shape, dtype=img.dtype)

    dx = 0
    dy = 0
    dh = bottom - top
    dw = right - left
    if top == 0:
        dy = size[1] - dh
    if left == 0:
        dx = size[0] - dw

    dst_img[dy:dy+dh, dx:dx+dw] = crop_img
    return dst_img


# center : [x, y]
# size   : [w, h]
def cv_crop_center_img(img, center, size):
    pos = [0, 0]
    pos[0] = center[0] - (size[0] // 2)
    pos[1] = center[1] - (size[1] // 2)
    return cv_crop_img(img, pos, size)


def cv_resize_img(img, dst_wh):
    h, w = img.shape[:2]
    src_wh = (w, h)
    new_wh = tu.fix_size(src_wh, dst_wh)
    return cv2.resize(img, new_wh, interpolation=cv2.INTER_AREA)


def cv_create_img(shape, dtype, val):
    return (np.ones(shape) * val).astype(dtype)


def cv_create_hgrad_img(shape, dtype, co0, co1):
    img = np.ones(shape)
    h, w = shape[:2]
    for y in range(0, h):
        for x in range(0, w):
            t = float(x) / (w - 1)
            img[y, x] = (1 - t) * co0 + t * co1
    return img.astype(dtype)


def cv_create_vgrad_img(shape, dtype, co0, co1):
    img = np.ones(shape)
    h, w = shape[:2]
    for y in range(0, h):
        for x in range(0, w):
            t = float(y) / (h - 1)
            img[y, x] = (1 - t) * co0 + t * co1
    return img.astype(dtype)


#======================================================
# interface for file
#======================================================

def cv_info(fname):
    img = cv_load(fname)
    h, w, ch = cv_size(img)
    min = img.min(axis=(0, 1))
    max = img.max(axis=(0, 1))

    print(f'filename  = {fname}')
    print(f"height    = {h}")
    print(f"width     = {w}")
    print(f"channels  = {ch}")
    print(f"img.shape = {img.shape}")
    print(f"img.dtype = {img.dtype}")
    print(f"type(img) = {type(img)}")
    print(f"min       = {min}")
    print(f"max       = {max}")
    print(f'---')


def cv_pick(fname, x, y):
    img = cv_load(fname)
    return img[y, x]


def cv_create(fname, shape, dtype, val):
    img = cv_create_img(shape, dtype, val)
    cv_save(fname, img)


def cv_create_hgrad(ofname, shape, dtype, co0, co1):
    img = cv_create_hgrad_img(shape, dtype, co0, co1)
    cv_save(ofname, img)


def cv_create_vgrad(ofname, shape, dtype, co0, co1):
    img = cv_create_vgrad_img(shape, dtype, co0, co1)
    cv_save(ofname, img)


def cv_resize(ifname, ofname, dst_size):
    img = cv_load(ifname)
    oimg = cv_resize_img(img, dst_size)
    cv_save(ofname, oimg)


def cv_load(ifname):
    return cv2.imread(ifname, cv2.IMREAD_UNCHANGED)


def cv_save(ifname, img):
    fname = FileName(ifname)
    ext = fname.ext()

    if img.dtype == np.float32 and ext == ".png":
        print(f"cv_save: {ifname}: convert float32 to png")
        oimg = np.clip(img * 255, 0, 255).astype(np.uint8)
        cv2.imwrite(ifname, oimg)
        return

    print(f"cv_save: {ifname}:")
    cv2.imwrite(ifname, img)


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

