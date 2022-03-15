#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# USAGE
#     conv.py [-w width] [-h height] -e dst_ext image_file...
#
# EXAMPLES
#
# - same size as each input
#     conv.py -e jpg a.png b.png...
#
# - fixed width
#     conv.py -w 200 -e jpg a.png b.png...
#
# - fixed height
#     conv.py -h 200 -e jpg a.png b.png...
#
# - fixed width and height
#     conv.py -w 200 -h 100 -e jpg a.png b.png...

import argparse
import tt_util as tu
import cv_util as cu


def f_conv_images(files, args):
    dst_size = (args.width, args.height)

    for ifname in files:
        fname = tu.FileName(ifname)
        name = fname.name()
        ofname = f"{name}.{args.ext}"

        #cu.cv_resize(ifname, ofname, dst_size)

        img = cu.cv_load(ifname)
        img = cu.cv_resize_img(img, dst_size)
        img = cu.cv_cvt_channels(img, args.channels)
        img = cu.cv_cvt_dtype(img, args.dtype)
        cu.cv_save(ofname, img)


def parse_args():
    parser = argparse.ArgumentParser(description='convert images', add_help=False)
    parser.add_argument('--help',
                        action='help',
                        help="show this help message and exit")
    parser.add_argument('-v', '--verbose',
                        action='store_true',
                        help='show verbose message')
    parser.add_argument('-w', '--width',
                        type=int,
                        default=0,
                        help='set width')
    parser.add_argument('-h', '--height',
                        type=int,
                        default=0,
                        help='set height')
    parser.add_argument('-c', '--channels',
                        type=int,
                        default=0,
                        help='set channels (1|3|4)')
    parser.add_argument('-d', '--dtype',
                        type=str,
                        default='',
                        help='set dtype (uint8|uint16|float)')
    parser.add_argument('-e', '--ext',
                        type=str,
                        default='jpg',
                        help='set ext (default=jpg)')
    parser.add_argument('files',
                        nargs='+',
                        type=str,
                        help='input files')

    return parser.parse_args()


if __name__ == "__main__":
    args = parse_args()
    if args.verbose:
        print(f"args.ext   : {args.ext}")
        print(f"args.files : {args.files}")
        print()

    f_conv_images(args.files, args)


