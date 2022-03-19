#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import cv2
import numpy as np
import tt_util as tu


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


#------------------------------------------------------
# convert dtype
#------------------------------------------------------
def cv_maximum(dtype):
    if dtype == 'uint8':
        maximum = 255
    elif dtype == 'uint16':
        maximum = 65535
    elif dtype == 'float32':
        maximum = 1.0
    return maximum


# col: [0.0, 1.0]
def cv_color(col, dst_dtype):
    dmax = cv_maximum(dst_dtype)
    return (np.array(col) * dmax).astype(dst_dtype)


def cv_cvt_dtype(img, dst_dtype):
    if dst_dtype not in ('uint8', 'uint16', 'float32'):
        return img

    if img.dtype == dst_dtype:
        return img

    smax = cv_maximum(img.dtype)
    dmax = cv_maximum(dst_dtype)
    return np.clip(img/smax * dmax, 0, dmax).astype(dst_dtype)


#------------------------------------------------------
# convert channel
#------------------------------------------------------
def cv_bgr_to_rgb_img(img):
    spl = cv2.split(img)
    return cv2.merge((spl[2], spl[1], spl[0]))


def cv_rgb_to_bgr_img(img):
    return cv_bgr_to_rgb_img(img)


def cv_bgr_to_bgra_img(img):
    img_list = list(cv2.split(img))
    img_a = np.ones_like(img_list[0]) * cv_maximum(img.dtype)
    img_list.append(img_a)
    return cv2.merge(img_list)


def cv_bgra_to_bgr_img(img):
    img_list = []
    img_list.append(img[:, :, 0])
    img_list.append(img[:, :, 1])
    img_list.append(img[:, :, 2])
    return cv2.merge(img_list)


def cv_split_img(img):
    h, w, ch = cv_size(img)
    img_list = []

    if ch >= 1:
        img_list.append(img[:, :, 0])

    if ch >= 3:
        img_list.append(img[:, :, 1])
        img_list.append(img[:, :, 2])

    if ch >= 4:
        img_list.append(img[:, :, 3])

    return img_list


def cv_merge_img(img_list):
    return cv2.merge(img_list)


def cv_cvt_channels(img, dst_ch):
    if dst_ch not in (1, 3, 4):
        return img

    h, w, ch = cv_size(img)

    if ch == dst_ch:
        return img

    img_list = list(cv2.split(img))
    img_a = np.ones_like(img_list[0]) * cv_maximum(img.dtype)

    if ch == 1 and dst_ch == 4:
        img_list.append(img_list[0])
        img_list.append(img_list[0])
        img_list.append(img_a)
        return cv2.merge(img_list)

    if ch == 3 and dst_ch == 4:
        img_list.append(img_a)
        return cv2.merge(img_list)

    if ch == 4 and dst_ch == 3:
        return cv2.merge([img_list[0], img_list[1], img_list[2]])

    if ch == 4 and dst_ch == 1:
        return img_list[0]


#------------------------------------------------------
# convert pixel value
#------------------------------------------------------
# brightness: [-1, 1]
# contrast  : [-1, 1]
def cv_brightness_contrast_img(img, brightness, contrast):
    a = 1.0 + contrast;
    b = brightness - contrast * 0.5;

    dtype = img.dtype
    img = cv_cvt_dtype(img, 'float32')

    img = a * img + b
    img = np.clip(img, 0.0, None)

    return cv_cvt_dtype(img, dtype)


def cv_bgr_to_hsv(img):
    return cv2.cvtColor(img, cv2.COLOR_BGR2HSV_FULL)


def cv_hsv_to_bgr(img):
    return cv2.cvtColor(img, cv2.COLOR_HSV2BGR_FULL)


def cv_linear_to_srgb(img):
    return np.power(img, 1.0/2.2)


def cv_srgb_to_linear(img):
    return np.power(img, 2.2)


#------------------------------------------------------
# convert for image list
#------------------------------------------------------
def cv_cvt_to_bgr_img_list(img_list):
    l = []
    for i in img_list:
        if len(i.shape) == 3:
            l.append(i)
        elif len(i.shape) == 4:
            bgr = cv_bgra_to_bgr_img(i)
            l.append(bgr)
        elif len(i.shape) == 1:
            bgr = cv2.cvtColor(i, cv2.COLOR_GRAY2BGR)
            l.append(bgr)
    return l


#------------------------------------------------------
# create
#------------------------------------------------------
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


#------------------------------------------------------
# resize
#------------------------------------------------------
def cv_resize_img(img, dst_wh):
    h, w = img.shape[:2]
    src_wh = (w, h)
    new_wh = tu.fix_size(src_wh, dst_wh)

    if src_wh == new_wh:
        return img
    else:
        return cv2.resize(img, new_wh, interpolation=cv2.INTER_AREA)


def cv_fit_img(img, dst_wh):
    h, w = img.shape[:2]
    src_wh = (w, h)
    fit_size = tu.fit_size(src_wh, dst_wh)
    return cv_resize_img(img, fit_size)


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
def cv_crop_img(img, pos, size, centering=False):
    # crop in the img
    h, w = img.shape[:2]

    top    = pos[1]
    bottom = pos[1] + size[1]
    left   = pos[0]
    right  = pos[0] + size[0]

    top = 0 if top < 0 else top
    left = 0 if left < 0 else left
    bottom = h if bottom > h else bottom
    right = w if right > w else right

    crop_img = img[top:bottom, left:right]

    # fill in the dst_img
    shape = list(img.shape)
    shape[0] = size[1]
    shape[1] = size[0]
    dst_img = np.zeros(shape, dtype=img.dtype)

    dx = 0
    dy = 0
    dh = bottom - top
    dw = right - left

    if centering:
        if dh < size[1]:
            dy = size[1] - dh
            dy //= 2
        if dw < size[0]:
            dx = size[0] - dw
            dx //= 2
    else:
        if dh < size[1] and top == 0:
            dy = size[1] - dh
        if dw < size[0] and left == 0:
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


#======================================================
# interface for file
#======================================================

def cv_info_short(fname):
    img = cv_load(fname)
    print(f'{fname} {img.shape} {img.dtype}')


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
    fname = tu.FileName(ifname)
    ext = fname.ext()

    dst_dtype = ''
    if ext in ('.png', '.jpg'):
        dst_dtype = 'uint8'

    img = cv_cvt_dtype(img, dst_dtype)

    print(f"cv_save: {ifname} {img.shape} {img.dtype}")
    cv2.imwrite(ifname, img)


#======================================================
# tiling image
#======================================================

def cv_hconcat(img_list, interpolation=cv2.INTER_AREA):
    l = cv_cvt_to_bgr_img_list(img_list)
    h_min = min(i.shape[0] for i in l)
    img_list_resize = [cv2.resize(i, (int(h_min * i.shape[1] / i.shape[0]), h_min), interpolation=interpolation) for i in l]
    return cv2.hconcat(img_list_resize)


def cv_vconcat(img_list, interpolation=cv2.INTER_AREA):
    l = cv_cvt_to_bgr_img_list(img_list)
    w_min = min(i.shape[1] for i in l)
    img_list_resize = [cv2.resize(i, (w_min, int(w_min * i.shape[0] / i.shape[1])), interpolation=interpolation) for i in l]
    return cv2.vconcat(img_list_resize)


def cv_htile(img_list_2d, interpolation=cv2.INTER_AREA):
    img_list_v = [cv_hconcat(img_list_h, interpolation) for img_list_h in img_list_2d]
    return cv_vconcat(img_list_v, interpolation)


def cv_vtile(img_list_2d, interpolation=cv2.INTER_AREA):
    img_list_h = [cv_vconcat(img_list_v, interpolation) for img_list_v in img_list_2d]
    return cv_hconcat(img_list_h, interpolation)

