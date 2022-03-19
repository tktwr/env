#!/usr/bin/env python
# -*- coding: utf-8 -*-

import argparse
import numpy as np
import tt_util as tu
import cv_util as cu


def parse_args():
    parser = argparse.ArgumentParser(
        formatter_class=tu.MyHelpFormatter,
        description='create an image')

    parser.add_argument('-a', '--action',
                        type=str,
                        choices=['new', 'hgrad', 'vgrad'],
                        default='new',
                        help='set action')
    parser.add_argument('-o', '--ofname',
                        type=str,
                        default='output.png',
                        help='set output file name')
    parser.add_argument('-s', '--size',
                        type=int,
                        nargs=2,
                        default=[256, 256],
                        help='set image size')
    parser.add_argument('-c', '--channels',
                        type=int,
                        choices=[1, 3, 4],
                        default=3,
                        help='set channels')
    parser.add_argument('-y', '--dtype',
                        type=str,
                        choices=['uint8', 'uint16', 'float32'],
                        default='uint8',
                        help='set dtype')
    parser.add_argument('--bgr0',
                        type=float,
                        nargs='+',
                        default=[1.0, 1.0, 1.0],
                        help='set bgr color')
    parser.add_argument('--bgr1',
                        type=float,
                        nargs='+',
                        default=[1.0, 1.0, 1.0],
                        help='set bgr color')

    return parser.parse_args()


if __name__ == "__main__":
    args = parse_args()

    w = args.size[0]
    h = args.size[1]
    c = args.channels

    shape = (h, w, c)
    dtype = args.dtype
    bgr0 = cu.cv_color(args.bgr0, dtype)
    bgr1 = cu.cv_color(args.bgr1, dtype)

    if args.action == 'new':
        cu.cv_create(args.ofname, shape, dtype, bgr0)
    elif args.action == 'hgrad':
        cu.cv_create_hgrad(args.ofname, shape, dtype, bgr0, bgr1)
    elif args.action == 'vgrad':
        cu.cv_create_vgrad(args.ofname, shape, dtype, bgr0, bgr1)

