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
    col0 = cu.cv_color(args.col0, dtype)
    col1 = cu.cv_color(args.col1, dtype)

    if args.action == 'new':
        img = cu.cv_create_img(shape, dtype, col0)
    elif args.action == 'hgrad':
        img = cu.cv_create_hgrad_img(shape, dtype, col0, col1)
    elif args.action == 'vgrad':
        img = cu.cv_create_vgrad_img(shape, dtype, col0, col1)
    elif args.action == 'check':
        img = cu.cv_create_check_img(shape, dtype, col0, col1, args.nelm)
    elif args.action == 'hstripe':
        img = cu.cv_create_hstripe_img(shape, dtype, col0, col1, args.nelm)
    elif args.action == 'se_stripe':
        img = cu.cv_create_se_stripe_img(shape, dtype, col0, col1, args.nelm)
    else:
        tu.log(f'unknown action: {args.action}')
        img = None

    cu.cv_save(args.output, img)
