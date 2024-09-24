#!/usr/bin/env python
# -*- coding: utf-8 -*-

import numpy as np
import tt_util as tu
import cv_util as cu


# -----------------------------------------------------
def make_img_list(ifnames, args):
    wh = args.tile_wh
    nr = 1
    l1 = []
    for i in ifnames:
        if i == 'BLACK':
            img = np.zeros((wh[1], wh[0], 3), 'uint8')
        elif i == 'WHITE':
            img = np.ones((wh[1], wh[0], 3), 'uint8') * 255
        else:
            img = cu.cv_load(i)
            img = cu.cv_fit_img(img, wh)
            img = cu.cv_crop_img(img, (0, 0), wh, True)
            cu.cv_add_label(img, args.label_type, i, nr)
            nr += 1
        if args.linear_to_srgb:
            img = cu.cv_linear_to_srgb(img)
        l1.append(img)
    return l1


def make_htile(ifnames, nx, args):
    l1 = make_img_list(ifnames, args)
    l2 = cu.cv_convert_1d_to_2d(l1, nx)
    return cu.cv_htile(l2)


def make_vtile(ifnames, ny, args):
    l1 = make_img_list(ifnames, args)
    l2 = cu.cv_convert_1d_to_2d(l1, ny)
    return cu.cv_vtile(l2)


# -----------------------------------------------------
def save_tile(ofname, files, args):
    nx, ny, fill = tu.tile_fill(len(files), args.nx, args.ny)
    if not (nx > 0 and ny > 0):
        print('Valid args are nx > 0 and ny > 0')
        return

    print(f'nx, ny, fill: {nx} {ny} {fill}')
    if fill > 0:
        # fill by 'BLACK'
        files += ['BLACK'] * fill

    img = None
    if args.order == 'X':
        img = make_htile(files, nx, args)
    elif args.order == 'Y':
        img = make_vtile(files, ny, args)

    if img is not None:
        cu.cv_save(ofname, img)


def save_tiles(args):
    mx = args.max
    if mx == 0:
        mx = len(args.files)

    subs = tu.lst_split_sublists(args.files, mx)
    n = 0
    for i in subs:
        ofname = args.output % n
        save_tile(ofname, i, args)
        n += 1


# =====================================================
def parse_args():
    parser = tu.parser('tiling images')
    A = parser.add_argument

    A('files' , nargs='+'           , help='input files'                     , type=str            , )
    A('-o'    , '--output'          , help="set output file name"            , type=str            , default='tile_%02d.jpg' , )
    A('-max'  , '--max'             , help="set max per page"                , type=int            , default=0               , )
    A('-nx'   , '--nx'              , help="set nx"                          , type=int            , default=0               , )
    A('-ny'   , '--ny'              , help="set ny"                          , type=int            , default=0               , )
    A('-T'    , '--tile_wh'         , help='set each tile image size (w h)'  , type=int            , nargs=2                 , default=[500    , 500]   , )
    A('-O'    , '--order'           , help="set the order of input files"    , type=str            , default='X'             , choices=['X'    , 'Y']   , )
    A('-L'    , '--label_type'      , help="set label type"                  , type=str            , default='NONE'          , choices=['NONE' , 'FILE' , 'DIR' , 'NUM' , 'ALPHA'] , )
    A('-N'    , '--normalize'       , help='normalize'                       , action='store_true' , )
    A('-Nr'   , '--normalize_range' , help='set normalize range'             , type=float          , nargs=2                 , default=[0.0    , 0.0]   , )
    A('-l2s'  , '--linear_to_srgb'  , help='convert linear to srgb'          , action='store_true' , )

    return parser.parse_args()

# -----------------------------------------------------
if __name__ == "__main__":
    save_tiles(parse_args())
