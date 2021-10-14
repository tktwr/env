#!/usr/bin/env python
# -*- coding: utf-8 -*-

import argparse
import numpy as np
import cv_util as cu


def parse_args():
    parser = argparse.ArgumentParser(description='create an image')
    parser.add_argument('-o', '--ofname',
                        type=str,
                        default="output.png",
                        help='set output filename')
    parser.add_argument('-s', '--size',
                        nargs='+',
                        type=int,
                        default=[256, 256],
                        help='set image size')
    parser.add_argument('-c', '--channels',
                        type=int,
                        default=3,
                        help="set channels")
    parser.add_argument('-t', '--dtype',
                        choices=['uint8', 'uint16', 'float32'],
                        type=str,
                        default="uint8",
                        help='set dtype')
    parser.add_argument('--bgr',
                        nargs='+',
                        type=float,
                        default=[1.0, 1.0, 1.0],
                        help='set bgr color')
    return parser.parse_args()


def f_create(fname, shape, dtype, val):
    img = np.ones(shape, dtype=dtype)
    img *= val
    cu.cv_save(fname, img)


if __name__ == "__main__":
    args = parse_args()

    w = args.size[0]
    h = args.size[1]
    c = args.channels
    shape = (h, w, c)
    dtype = args.dtype
    bgr = np.array(args.bgr)
    if dtype == 'uint8':
        bgr = (bgr * 255).astype('uint8')
    elif dtype == 'uint16':
        bgr = (bgr * 65535).astype('uint16')

    f_create(args.ofname, shape, dtype, bgr)

