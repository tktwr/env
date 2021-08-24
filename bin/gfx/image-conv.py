#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# USAGE
#     conv.py w h dst_ext image_file...
#
# EXAMPLES
#
# - same size as each input
#     conv.py   0   0 jpg a.png b.png...
#
# - fixed width
#     conv.py 200   0 jpg a.png b.png...
#
# - fixed height
#     conv.py   0 200 jpg a.png b.png...
#
# - fixed width and height
#     conv.py 200 100 jpg a.png b.png...

import sys
import cv2
from PIL import Image
from ttpy import FileName
from ttpy import ImageSize
import argparse


def cv_resize_image(ifname, ofname, dst_size):
    img = cv2.imread(ifname, cv2.IMREAD_COLOR)
    h, w = img.shape[:2]

    img_size = ImageSize((w, h))
    new_size = img_size.getSize(dst_size)

    oimg = cv2.resize(img, new_size, interpolation=cv2.INTER_AREA)
    cv2.imwrite(ofname, oimg)

    print(f"cv_resize_image {ifname} {ofname} {new_size}")


def pil_resize_image(ifname, ofname, dst_size):
    img = Image.open(ifname)

    img_size = ImageSize(img.size)
    new_size = img_size.getSize(dst_size)

    oimg = img.resize(new_size)
    oimg.save(ofname)

    print(f"pil_resize_image {ifname} {ofname} {new_size}")


def f_conv_images(dst_size, dst_ext, files):
    for ifname in files:
        fname = FileName(ifname)
        name = fname.name()
        ofname = f"{name}.{dst_ext}"

        cv_resize_image(ifname, ofname, dst_size)
        #pil_resize_image(ifname, ofname, dst_size)


def parse_args(argv):
    parser = argparse.ArgumentParser(description='convert images')
    parser.add_argument('-v', '--verbose',
                        action='store_true',
                        help='show verbose message')
    parser.add_argument('-s', '--size',
                        nargs='+',
                        type=int,
                        default=[0, 0],
                        help='set image size')
    parser.add_argument('-e', '--ext',
                        type=str,
                        default='jpg',
                        help='set ext')
    parser.add_argument('files',
                        nargs='+',
                        type=str,
                        help='input files')

    args = parser.parse_args()
    return args


if __name__ == "__main__":
    args = parse_args(sys.argv)
    if args.verbose:
        print(f"args.size: {args.size}")
        print(f"args.ext: {args.ext}")
        print(f"args.files: {args.files}")
        print()

    f_conv_images(args.size, args.ext, args.files)


