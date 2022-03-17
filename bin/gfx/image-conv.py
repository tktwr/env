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

        try:
            img = cu.cv_load(ifname)
            img = cu.cv_resize_img(img, dst_size)
            img = cu.cv_cvt_channels(img, args.channels)
            img = cu.cv_cvt_dtype(img, args.dtype)
            img = cu.cv_crop_img_simple(img, args.crop_pos, args.crop_size)
            cu.cv_save(ofname, img)
        except Exception as e:
            print(f'fail to convert ... {ifname} {e}')


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
    parser.add_argument('-cp', '--crop_pos',
                        nargs=2,
                        type=int,
                        default=[0, 0],
                        help='set position (default=0 0)')
    parser.add_argument('-cs', '--crop_size',
                        nargs=2,
                        type=int,
                        default=[256, 256],
                        help='set image size (default=256 256)')
    parser.add_argument('-e', '--ext',
                        type=str,
                        default='jpg',
                        help='set ext (default=jpg)')
    parser.add_argument('files',
                        nargs='+',
                        type=str,
                        help='input files')

    return parser.parse_args()


def print_args(args):
    print(f"--- args ---")
    print(f"args.width     : {args.width}")
    print(f"args.height    : {args.height}")
    print(f"args.channels  : {args.channels}")
    print(f"args.dtype     : {args.dtype}")
    print(f"args.crop_pos  : {args.crop_pos}")
    print(f"args.crop_size : {args.crop_size}")
    print(f"args.ext       : {args.ext}")
    print(f"args.files     : {args.files}")

if __name__ == "__main__":
    args = parse_args()
    if args.verbose:
        print_args(args)

    f_conv_images(args.files, args)


