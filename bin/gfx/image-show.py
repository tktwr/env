#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import cv2
import cv_util as cu


def img_show(fname):
    img = cv2.imread(fname, cv2.IMREAD_ANYCOLOR|cv2.IMREAD_ANYDEPTH)
    h, w = img.shape[:2]
    pos = (w//2, h//2)
    val = img[pos[1], pos[0]]
    h_max = 500
    w_max = 500

    if h >= w and h > h_max:
        dst_size = (0, h_max)
        oimg = cu.cv_resize_img(img, dst_size)
    elif w >= h and w > w_max:
        dst_size = (w_max, 0)
        oimg = cu.cv_resize_img(img, dst_size)
    else:
        dst_size = (0, 0)
        oimg = img

    cv2.imshow(f"{fname}, orig={(w, h)}, dst={dst_size}, pos={pos}, val={val}", oimg)
    if dst_size != (0, 0):
        crop_size = (500, 500)
        img_crop = cu.cv_crop_center_img(img, pos, crop_size)
        cv2.imshow(f"crop: {fname} {pos}, {crop_size}", img_crop)


if __name__ == "__main__":
    for fname in sys.argv[1:]:
        img_show(fname)
    cv2.waitKey()

