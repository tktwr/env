#!/usr/bin/env python
# -*- coding: utf-8 -*-

import argparse
import cv2
import cv_util as cu
from ttpy import FileName


def img_show(fname, size, pos, crop_size):
    img = cu.cv_load(fname)
    h, w = img.shape[:2]
    if pos == [0, 0]:
        pos = (w//2, h//2)
    val = img[pos[1], pos[0]]
    h_max = size[1]
    w_max = size[0]

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
        img_crop = cu.cv_crop_center_img(img, pos, crop_size)
        cv2.imshow(f"crop: {fname} {pos}, {crop_size}", img_crop)

    key = cv2.waitKey()
    if key == 115: # 's'
        fn = FileName(fname)
        ofname = f"small_{fn.name()}.png"
        cu.cv_save(ofname, oimg)
        if dst_size != (0, 0):
            ofname = f"crop_{fn.name()}.png"
            cu.cv_save(ofname, img_crop)


def parse_args():
    parser = argparse.ArgumentParser(description='show images')
    parser.add_argument('-s', '--size',
                        nargs='+',
                        type=int,
                        default=[500, 500],
                        help='set display size [w, h]')
    parser.add_argument('-p', '--pos',
                        nargs='+',
                        type=int,
                        default=[0, 0],
                        help='set position [x, y]')
    parser.add_argument('-cs', '--crop_size',
                        nargs='+',
                        type=int,
                        default=[500, 500],
                        help='set crop size [w, h]')
    parser.add_argument('file',
                        nargs='+',
                        type=str,
                        help='input file')
    return parser.parse_args()


if __name__ == "__main__":
    args = parse_args()
    for fname in args.file:
        img_show(fname, args.size, args.pos, args.crop_size)

