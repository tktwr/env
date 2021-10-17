#!/usr/bin/env python
# -*- coding: utf-8 -*-

import argparse
import cv2
import cv_util as cu
import numpy as np


def convert_1d_to_2d(l, cols):
    return [l[i:i + cols] for i in range(0, len(l), cols)]


def make_tile(width, cols, ifnames, ofname):
    w = width // cols
    h = w
    blank_img = np.zeros((h, w, 3), np.uint8)

    l1 = []
    for i in ifnames:
        if i == "None":
            img = blank_img
        else:
            img = cu.cv_load(i)
        l1.append(img)

    l2 = convert_1d_to_2d(l1, cols)

    mycv = cu.ImageTile()
    img_all = mycv.tile(l2)
    cu.cv_save(ofname, img_all)


def parse_args():
    parser = argparse.ArgumentParser(description='tiling images')
    parser.add_argument('file', nargs='*')
    parser.add_argument('-w', '--width',
                        type=int,
                        default=500,
                        help="set width")
    parser.add_argument('-c', '--cols',
                        type=int,
                        default=2,
                        help="set columns")
    return parser.parse_args()


def main():
    args = parse_args()
    make_tile(args.width, args.cols, args.file, "out.png")


if __name__ == "__main__":
    main()

