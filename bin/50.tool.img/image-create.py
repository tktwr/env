#!/usr/bin/env python
# -*- coding: utf-8 -*-

import tt_util as tu
import cv_util as cu


# =====================================================
def parse_args():
    parser = tu.parser('create an image')
    A = parser.add_argument

    A('-o'  , '--output'   , help='set output file name'    , type=str   , default='output.png' , )
    A('-s'  , '--size'     , help='set image size'          , type=int   , nargs=2              , default=[256     , 256]     , )
    A('-ch' , '--channels' , help='set image channels'      , type=int   , default=3            , choices=[1       , 3        , 4]         , )
    A('-ty' , '--dtype'    , help='set image dtype'         , type=str   , default='uint8'      , choices=['uint8' , 'uint16' , 'float32'] , )
    A('-a'  , '--action'   , help='set action'              , type=str   , default='new'        , choices=['new'   , 'hgrad'  , 'vgrad'    , 'check' , 'hstripe' , 'se_stripe'] , )
    A('-n'  , '--nelm'     , help='set number of elements'  , type=int   , nargs=2              , default=[2       , 2]       , )
    A('-c0' , '--col0'     , help='set color0 in BGR [0 1]' , type=float , nargs='+'            , default=[0.0     , 0.0      , 0.0]       , )
    A('-c1' , '--col1'     , help='set color1 in BGR [0 1]' , type=float , nargs='+'            , default=[1.0     , 1.0      , 1.0]       , )

    return parser.parse_args()


# -----------------------------------------------------
if __name__ == "__main__":
    args = parse_args()

    w = args.size[0]
    h = args.size[1]
    c = args.channels

    shape = (h, w, c)
    dtype = args.dtype
    col0 = cu.color_cvt_dtype(args.col0, dtype)
    col1 = cu.color_cvt_dtype(args.col1, dtype)

    if args.action == 'new':
        img = cu.img_create(shape, dtype, col0)
    elif args.action == 'hgrad':
        img = cu.img_create_hgrad(shape, dtype, col0, col1)
    elif args.action == 'vgrad':
        img = cu.img_create_vgrad(shape, dtype, col0, col1)
    elif args.action == 'check':
        img = cu.img_create_check(shape, dtype, col0, col1, args.nelm)
    elif args.action == 'hstripe':
        img = cu.img_create_hstripe(shape, dtype, col0, col1, args.nelm)
    elif args.action == 'se_stripe':
        img = cu.img_create_se_stripe(shape, dtype, col0, col1, args.nelm)
    else:
        tu.log(f'unknown action: {args.action}')
        img = None

    cu.imgfile_save(args.output, img)
