#!/usr/bin/env python
# -*- coding: utf-8 -*-

import argparse
import numpy as np
import cv_util as cu


def parse_args():
    parser = argparse.ArgumentParser(description='create an image')
    parser.add_argument('-a', '--action',
                        choices=['new', 'hgrad', 'vgrad'],
                        type=str,
                        default="new",
                        help='set action (default=new)')
    parser.add_argument('-o', '--ofname',
                        type=str,
                        default="output.png",
                        help='set output filename')
    parser.add_argument('-s', '--size',
                        nargs='+',
                        type=int,
                        default=[256, 256],
                        help='set image size (default=256 256)')
    parser.add_argument('-c', '--channels',
                        type=int,
                        default=3,
                        help="set channels (default=3)")
    parser.add_argument('-t', '--dtype',
                        choices=['uint8', 'uint16', 'float32'],
                        type=str,
                        default="uint8",
                        help='set dtype (default=uint8)')
    parser.add_argument('--bgr0',
                        nargs='+',
                        type=float,
                        default=[1.0, 1.0, 1.0],
                        help='set bgr color (default=1.0 1.0 1.0)')
    parser.add_argument('--bgr1',
                        nargs='+',
                        type=float,
                        default=[1.0, 1.0, 1.0],
                        help='set bgr color (default=1.0 1.0 1.0)')
    return parser.parse_args()


if __name__ == "__main__":
    args = parse_args()

    w = args.size[0]
    h = args.size[1]
    c = args.channels

    shape = (h, w, c)
    dtype = args.dtype
    bgr0 = np.array(args.bgr0)
    bgr0 = cu.cv_color(bgr0, dtype)
    bgr1 = np.array(args.bgr1)
    bgr1 = cu.cv_color(bgr1, dtype)

    print(f"shape = {shape}")
    print(f"dtype = {dtype}")
    print(f"bgr0 = {bgr0}")
    print(f"bgr1 = {bgr1}")

    if args.action == 'new':
        cu.cv_create(args.ofname, shape, dtype, bgr0)
    elif args.action == 'hgrad':
        cu.cv_create_hgrad(args.ofname, shape, dtype, bgr0, bgr1)
    elif args.action == 'vgrad':
        cu.cv_create_vgrad(args.ofname, shape, dtype, bgr0, bgr1)

