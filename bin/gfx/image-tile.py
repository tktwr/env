#!/usr/bin/env python
# -*- coding: utf-8 -*-

import argparse
import cv2
import cv_util as cu
import numpy as np


def convert_1d_to_2d(l, step):
    return [l[i:i + step] for i in range(0, len(l), step)]


def make_img_list(ifnames):
    blank_img = np.zeros((1, 1, 3), np.uint8)

    l1 = []
    for i in ifnames:
        if i == "None":
            img = blank_img
        else:
            img = cu.cv_load(i)
            h, w, ch = cu.cv_size(img)
            if ch == 4:
                img = cu.cv_bgra_to_bgr_img(img)
        l1.append(img)

    return l1


def make_vtile(cols, ifnames):
    l1 = make_img_list(ifnames)
    rows = len(l1) // cols
    l2 = convert_1d_to_2d(l1, rows)
    return cu.cv_vtile(l2)


def make_htile(cols, ifnames):
    l1 = make_img_list(ifnames)
    l2 = convert_1d_to_2d(l1, cols)
    return cu.cv_htile(l2)


def parse_args():
    parser = argparse.ArgumentParser(description='tiling images', add_help=False)
    parser.add_argument('--help',
                        action='help',
                        help="show this help message and exit")
    parser.add_argument('-o', '--output',
                        type=str,
                        default='tile.png',
                        help="set output file name")
    parser.add_argument('-c', '--cols',
                        type=int,
                        default=2,
                        help="set columns")
    parser.add_argument('-h', '--htile',
                        action='store_true',
                        help="input files are in horizontal order")
    parser.add_argument('files',
                        nargs='+',
                        type=str,
                        help='input files')
    return parser.parse_args()


def main():
    args = parse_args()
    if args.htile:
        img = make_htile(args.cols, args.files)
    else:
        img = make_vtile(args.cols, args.files)
    cu.cv_save(args.output, img)


if __name__ == "__main__":
    main()

