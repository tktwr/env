#!/usr/bin/env python
# -*- coding: utf-8 -*-

import numpy as np
import tt_util as tu
import cv_util as cu


# -----------------------------------------------------
def make_img_list(ifnames, args):
    text_height = 18
    color = (255, 255, 255)
    wh = args.tile_wh
    nr = 1
    l1 = []
    for i in ifnames:
        if i == 'BLACK':
            img = np.zeros((wh[1], wh[0], 3), 'uint8')
        elif i == 'WHITE':
            img = np.ones((wh[1], wh[0], 3), 'uint8') * 255
        else:
            img = cu.imgfile_load(i)
            img = cu.img_fit(img, wh)
            img = cu.img_crop(img, (0, 0), wh, True)
            cu.img_draw_label(img, args.label_type, i, nr, text_height, color)
            nr += 1
        if args.linear_to_srgb:
            img = cu.img_linear_to_srgb(img)
        l1.append(img)
    return l1


def make_htile(ifnames, nx, args):
    l1 = make_img_list(ifnames, args)
    l2 = cu.imglst_to_imglst2d(l1, nx)
    return cu.imglst_htile(l2)


def make_vtile(ifnames, ny, args):
    l1 = make_img_list(ifnames, args)
    l2 = cu.imglst_to_imglst2d(l1, ny)
    return cu.imglst_vtile(l2)


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

    if args.border > 0:
        color = (127, 127, 127)
        thickness = args.border
        cu.img_draw_grid(img, args.tile_wh, (nx, ny), color, thickness)

    if args.title != '':
        text_height = 20
        color = (0, 255, 255)
        thickness = 2
        cu.img_draw_title(img, args.title, text_height, color, thickness)

    if img is not None:
        cu.imgfile_save(ofname, img)


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

    A('files' , nargs='+'           , help='input files'                    , type=str            , )
    A('-o'    , '--output'          , help="set output file name"           , type=str            , default='tile_%02d.jpg' , )
    A('-max'  , '--max'             , help="set max per page"               , type=int            , default=0               , )
    A('-nx'   , '--nx'              , help="set nx"                         , type=int            , default=0               , )
    A('-ny'   , '--ny'              , help="set ny"                         , type=int            , default=0               , )
    A('-T'    , '--tile_wh'         , help='set each tile image size (w h)' , type=int            , nargs=2                 , default=[500    , 500]   , )
    A('-O'    , '--order'           , help="set the order of input files"   , type=str            , default='X'             , choices=['X'    , 'Y']   , )
    #         ,
    A('-N'    , '--normalize'       , help='normalize'                      , action='store_true' , )
    A('-Nr'   , '--normalize_range' , help='set normalize range'            , type=float          , nargs=2                 , default=[0.0    , 0.0]   , )
    A('-l2s'  , '--linear_to_srgb'  , help='convert linear to srgb'         , action='store_true' , )
    #         ,
    A('-t'    , '--title'           , help="set title"                      , type=str            , default=''              , )
    A('-L'    , '--label_type'      , help="set label type"                 , type=str            , default='NONE'          , choices=['NONE' , 'FILE' , 'DIR' , 'NUM' , 'ALPHA'] , )
    A('-b'    , '--border'          , help="set border"                     , type=int            , default=0               , )

    return parser.parse_args()

# -----------------------------------------------------
if __name__ == "__main__":
    save_tiles(parse_args())
