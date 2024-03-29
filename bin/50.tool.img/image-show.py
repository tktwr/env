#!/usr/bin/env python
# -*- coding: utf-8 -*-

import cv2
import argparse
import cv_util as cu
import tt_util as tu


def img_show(fname, size):
    img = cu.cv_load(fname)

    oimg = cu.cv_fit_img(img, size)

    cv2.imshow(f"{fname}, {img.shape} {img.dtype}", oimg)

    key = cv2.waitKey()
    if key == 115: # 's'
        fn = tu.FileName(fname)
        ofname = f"small_{fn.name()}.png"
        cu.cv_save(ofname, oimg)


def parse_args():
    parser = argparse.ArgumentParser(
        formatter_class=tu.MyHelpFormatter,
        description='show images')

    parser.add_argument('-s', '--size',
                        type=int,
                        nargs=2,
                        default=[500, 500],
                        help='set display size')
    parser.add_argument('files',
                        type=str,
                        nargs='+',
                        help='input files')

    return parser.parse_args()


if __name__ == "__main__":
    args = parse_args()

    for fname in args.files:
        img_show(fname, args.size)

