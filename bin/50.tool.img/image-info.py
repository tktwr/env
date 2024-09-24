#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import tt_util as tu
import cv_util as cu


def f_info_pick(fname, xy):
    x, y = xy
    val = cu.cv_pick(fname, x, y)
    print(f'{fname} {xy} {val}')


def f_info(fname, args):
    if args.verbose:
        cu.cv_info(fname)
    else:
        cu.cv_info_short(fname)


def f_info_all(args):
    for fname in args.files:
        try:
            if os.path.isfile(fname) == False:
                continue
            f_info(fname, args)
            if args.xy != [-1, -1]:
                f_info_pick(fname, args.xy)
            print(f'---')
        except Exception as e:
            print(f'{e}: {fname}')


# =====================================================
def parse_args():
    parser = tu.parser('print information of images')
    A = parser.add_argument

    A('files' , nargs='+'   , help='input files'          , type=str            , )
    A('-v'    , '--verbose' , help='show verbose message' , action='store_true' , )
    A('-xy'   , '--xy'      , help='set position'         , type=int            , nargs=2 , default=[-1 , -1] , )

    return parser.parse_args()


# -----------------------------------------------------
if __name__ == "__main__":
    args = parse_args()
    f_info_all(args)
