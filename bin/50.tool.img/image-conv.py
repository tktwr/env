#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import tt_util as tu
import cv_util as cu


def f_conv(ifname, args):
    fname = tu.FileName(ifname)
    if args.relative:
        dirname = fname.dirname()
    else:
        dirname = ''
    name = fname.name()
    ofname = f"{args.output_dir}/{dirname}/{name}.{args.ext}"
    if os.path.isfile(ofname) == True and not args.force:
        print(f"file is already existed: {ofname}")
        return

    img = cu.imgfile_load(ifname)

    if args.srgb_to_linear:
        img = cu.img_srgb_to_linear(img)

    if args.thumbnail > 0:
        thmb_size = (args.thumbnail, args.thumbnail)
        img = cu.img_fit(img, thmb_size)
        img = cu.img_crop(img, (0, 0), thmb_size, True)
    else:
        dst_size = (args.width, args.height)
        img = cu.img_resize(img, dst_size)
        img = cu.img_cvt_channels(img, args.channels)
        img = cu.img_cvt_dtype(img, args.dtype)
        if args.normalize:
            img = cu.img_normalize(img, args.normalize_range[0], args.normalize_range[1])
        # img = cu.img_mult(img, args.mult)
        # img = cu.img_brightness_contrast(img, args.brightness, args.contrast)
        if args.flip_x:
            img = cu.img_flip_x(img)
        if args.crop_size != [0, 0]:
            img = cu.img_crop(img, args.crop_pos, args.crop_size, args.crop_centering)

    if args.linear_to_srgb:
        img = cu.img_linear_to_srgb(img)

    cu.imgfile_save(ofname, img)


def f_conv_all(args):
    for fname in args.files:
        try:
            if os.path.isfile(fname) == False:
                continue
            f_conv(fname, args)
        except Exception as e:
            print(f'{e}: {fname}')


# =====================================================
def parse_args():
    parser = tu.parser(
        desc='convert images',
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
        ''')

    A = parser.add_argument

    A('files' , nargs='+'           , help='input files'                     , type=str            , )
    A('-v'    , '--verbose'         , help='show verbose message'            , action='store_true' , )
    A('-f'    , '--force'           , help='force to overwrite'              , action='store_true' , )
    A('-R'    , '--relative'        , help='relative path'                   , action='store_true' , )
    A('-o'    , '--output_dir'      , help='set output directory'            , type=str            , default='.'   , )
    A('-e'    , '--ext'             , help='set image ext'                   , type=str            , default='jpg' , )
    A('-W'    , '--width'           , help='set image width'                 , type=int            , default=0     , )
    A('-H'    , '--height'          , help='set image height'                , type=int            , default=0     , )
    A('-ch'   , '--channels'        , help='set image channels'              , type=int            , default=0     , choices=[1       , 3        , 4]         , )
    A('-ty'   , '--dtype'           , help='set image dtype'                 , type=str            , default=''    , choices=['uint8' , 'uint16' , 'float32'] , )
    A('-N'    , '--normalize'       , help='normalize'                       , action='store_true' , )
    A('-Nr'   , '--normalize_range' , help='set normalize range'             , type=float          , nargs=2       , default=[0.0     , 0.0]     , )
    A('-l2s'  , '--linear_to_srgb'  , help='convert linear to srgb'          , action='store_true' , )
    A('-s2l'  , '--srgb_to_linear'  , help='convert srgb to linear'          , action='store_true' , )
    A('-mult' , '--mult'            , help='multiply'                        , type=float          , default=1.0   , )
    A('-br'   , '--brightness'      , help='set brightness'                  , type=float          , default=0.0   , )
    A('-ct'   , '--contrast'        , help='set contrast'                    , type=float          , default=0.0   , )
    A('-Cc'   , '--crop_centering'  , help='set crop centering'              , action='store_true' , )
    A('-Cp'   , '--crop_pos'        , help='set crop position'               , type=int            , nargs=2       , default=[0       , 0]       , )
    A('-Cs'   , '--crop_size'       , help='set crop size'                   , type=int            , nargs=2       , default=[0       , 0]       , )
    A('-T'    , '--thumbnail'       , help='set thumbnail size'              , type=int            , default=0     , )
    A('-fx'   , '--flip_x'          , help='flip x'                          , action='store_true' , )

    return parser.parse_args()


# -----------------------------------------------------
if __name__ == "__main__":
    args = parse_args()
    if args.verbose:
        tu.print_args(args)

    f_conv_all(args)
