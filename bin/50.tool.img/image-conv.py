#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import argparse
import tt_util as tu
import cv_util as cu


def f_conv_images(files, args):
    dst_size = (args.width, args.height)

    for ifname in files:
        fname = tu.FileName(ifname)
        name = fname.name()
        ofname = f"{name}.{args.ext}"
        if os.path.isfile(ofname) == True and not args.force:
            print(f"file is already existed: {ofname}")
            continue

        try:
            img = cu.cv_load(ifname)

            if args.srgb_to_linear:
                img = cu.cv_srgb_to_linear(img)

            if args.thumbnail > 0:
                thmb_size = (args.thumbnail, args.thumbnail)
                img = cu.cv_fit_img(img, thmb_size)
                img = cu.cv_crop_img(img, (0, 0), thmb_size, True)
            else:
                img = cu.cv_resize_img(img, dst_size)
                img = cu.cv_cvt_channels(img, args.channels)
                img = cu.cv_cvt_dtype(img, args.dtype)
                img = cu.cv_mult_img(img, args.mult)
                img = cu.cv_brightness_contrast_img(img, args.brightness, args.contrast)
                if args.crop_size != [0, 0]:
                    img = cu.cv_crop_img(img, args.crop_pos, args.crop_size, args.crop_centering)

            if args.linear_to_srgb:
                img = cu.cv_linear_to_srgb(img)

            cu.cv_save(ofname, img)
        except Exception as e:
            print(f'fail to convert ... {ifname} {e}')


def parse_args():
    parser = argparse.ArgumentParser(
        formatter_class=tu.MyHelpFormatter,
        description='convert images',
        epilog='''
examples:

  same size as each input
      image-conv.py -e jpg a.png b.png...

  fixed width
      image-conv.py -e jpg -w 200 a.png b.png...

  fixed height
      image-conv.py -e jpg -h 200 a.png b.png...

  fixed width and height
      image-conv.py -e jpg -w 200 -h 100 a.png b.png...
        ''',
        add_help=False)

    #------------------------------------------------------
    # positional arguments
    #------------------------------------------------------
    parser.add_argument('files',
                        type=str,
                        nargs='+',
                        help='input files')

    #------------------------------------------------------
    # common
    #------------------------------------------------------
    parser.add_argument('--help',
                        action='help',
                        help="show this help message and exit")
    parser.add_argument('-v', '--verbose',
                        action='store_true',
                        help='show verbose message')
    parser.add_argument('-f', '--force',
                        action='store_true',
                        help='force to overwrite')

    #------------------------------------------------------
    # special
    #------------------------------------------------------
    parser.add_argument('-t', '--thumbnail',
                        type=int,
                        default=0,
                        help='set thumbnail size')

    #------------------------------------------------------
    # basic
    #------------------------------------------------------
    parser.add_argument('-e', '--ext',
                        type=str,
                        default='jpg',
                        help='set ext')
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
                        choices=[1, 3, 4],
                        default=0,
                        help='set channels')
    parser.add_argument('-y', '--dtype',
                        type=str,
                        choices=['uint8', 'uint16', 'float32'],
                        default='',
                        help='set dtype')

    #------------------------------------------------------
    # crop
    #------------------------------------------------------
    parser.add_argument('-cp', '--crop_pos',
                        type=int,
                        nargs=2,
                        default=[0, 0],
                        help='set crop position')
    parser.add_argument('-cs', '--crop_size',
                        type=int,
                        nargs=2,
                        default=[0, 0],
                        help='set crop size')
    parser.add_argument('-cc', '--crop_centering',
                        action='store_true',
                        help='set crop centering')

    #------------------------------------------------------
    # color space
    #------------------------------------------------------
    parser.add_argument('--linear_to_srgb',
                        action='store_true',
                        help='convert linear to srgb')
    parser.add_argument('--srgb_to_linear',
                        action='store_true',
                        help='convert srgb to linear')

    #------------------------------------------------------
    # pixel value
    #------------------------------------------------------
    parser.add_argument('--mult',
                        type=float,
                        default=1,
                        help='multiply')
    parser.add_argument('--brightness',
                        type=float,
                        default=0,
                        help='set brightness')
    parser.add_argument('--contrast',
                        type=float,
                        default=0,
                        help='set contrast')

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


