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
                if args.normalize:
                    img = cu.cv_normalize_img(img, args.normalize_range[0], args.normalize_range[1])
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

    A = parser.add_argument

    A('files' , nargs='+'           , help='input files'                     , type=str            , )
    #         ,
    A('-h'    , '--help'            , help="show this help message and exit" , action='help'       , )
    A('-v'    , '--verbose'         , help='show verbose message'            , action='store_true' , )
    A('-f'    , '--force'           , help='force to overwrite'              , action='store_true' , )
    A('-Cc'   , '--crop_centering'  , help='set crop centering'              , action='store_true' , )
    A('-l2s'  , '--linear_to_srgb'  , help='convert linear to srgb'          , action='store_true' , )
    A('-s2l'  , '--srgb_to_linear'  , help='convert srgb to linear'          , action='store_true' , )
    A('-N'    , '--normalize'       , help='normalize'                       , action='store_true' , )
    #         ,
    A('-e'    , '--ext'             , help='set ext'                         , type=str            , default='jpg' , )
    A('-T'    , '--thumbnail'       , help='set thumbnail size'              , type=int            , default=0     , )
    A('-W'    , '--width'           , help='set width'                       , type=int            , default=0     , )
    A('-H'    , '--height'          , help='set height'                      , type=int            , default=0     , )
    A('-mult' , '--mult'            , help='multiply'                        , type=float          , default=1.0   , )
    A('-br'   , '--brightness'      , help='set brightness'                  , type=float          , default=0.0   , )
    A('-ct'   , '--contrast'        , help='set contrast'                    , type=float          , default=0.0   , )
    #         ,
    A('-Cp'   , '--crop_pos'        , help='set crop position'               , type=int            , nargs=2       , default=[0       , 0]       , )
    A('-Cs'   , '--crop_size'       , help='set crop size'                   , type=int            , nargs=2       , default=[0       , 0]       , )
    A('-Nr'   , '--normalize_range' , help='set normalize range'             , type=float          , nargs=2       , default=[0.0     , 0.0]     , )
    #         ,
    A('-ty'   , '--dtype'           , help='set dtype'                       , type=str            , default=''    , choices=['uint8' , 'uint16' , 'float32'] , )
    A('-ch'   , '--channels'        , help='set channels'                    , type=int            , default=0     , choices=[1       , 3        , 4]         , )

    return parser.parse_args()


def print_args(args):
    print(f"--- args ---")
    print(f"{args}")


if __name__ == "__main__":
    args = parse_args()
    if args.verbose:
        print_args(args)

    f_conv_images(args.files, args)


