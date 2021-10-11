#!/usr/bin/env python
# -*- coding: utf-8 -*-

import argparse
import cv2
import cv_util
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
            img = cv2.imread(i)
        l1.append(img)

    l2 = convert_1d_to_2d(l1, cols)

    mycv = cv_util.ImageTile()
    img_all = mycv.tile(l2)
    cv2.imwrite(ofname, img_all)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('file', nargs='*')
    parser.add_argument('-w', '--width',
                        type=int,
                        default=500,
                        help="set width")
    parser.add_argument('-c', '--cols',
                        type=int,
                        default=2,
                        help="set width")
    args = parser.parse_args()

    make_tile(args.width, args.cols, args.file, "out.png")


if __name__ == "__main__":
    main()

