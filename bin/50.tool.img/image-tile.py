#!/usr/bin/env python
# -*- coding: utf-8 -*-

import argparse
import numpy as np
import tt_util as tu
import cv_util as cu
import cv2


def make_img_list(wh, ifnames, label_type):
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

            if label_type == 'FILE':
                name = i.split('/')[-1]
            elif label_type == 'NUM':
                name = f'{nr})'
                nr += 1
            elif label_type == 'ALPHA':
                ch = chr(ord('a') + nr - 1)
                name = f'{ch})'
                nr += 1
            else:
                name = ''

            if name != '':
                xy = (int(0.05 * wh[0]), int(0.95 * wh[1]))
                color = (255, 255, 255)
                cv2.putText(img, name, xy, cv2.FONT_HERSHEY_SIMPLEX, 1, color, 1, cv2.LINE_AA)
        l1.append(img)

    return l1


def make_htile(tile_wh, nx, ifnames, label_type):
    l1 = make_img_list(tile_wh, ifnames, label_type)
    l2 = cu.cv_convert_1d_to_2d(l1, nx)
    return cu.cv_htile(l2)


def make_vtile(tile_wh, ny, ifnames, label_type):
    l1 = make_img_list(tile_wh, ifnames, label_type)
    l2 = cu.cv_convert_1d_to_2d(l1, ny)
    return cu.cv_vtile(l2)


def parse_args():
    parser = argparse.ArgumentParser(
        formatter_class=tu.MyHelpFormatter,
        description='tiling images',
        add_help=False)

    parser.add_argument('--help',
                        action='help',
                        help="show this help message and exit")
    parser.add_argument('-o', '--output',
                        type=str,
                        default='tile.jpg',
                        help="set output file name")
    parser.add_argument('-nx',
                        type=int,
                        default=0,
                        help="set nx")
    parser.add_argument('-ny',
                        type=int,
                        default=0,
                        help="set ny")
    parser.add_argument('-T', '--tile-wh',
                        type=int,
                        nargs=2,
                        default=[500, 500],
                        help='set each tile size (w, h)')
    parser.add_argument('-O', '--file-order',
                        type=str,
                        choices=['X', 'Y'],
                        default='X',
                        help="the order of input files")
    parser.add_argument('-L', '--label-type',
                        type=str,
                        choices=['NONE', 'FILE', 'NUM', 'ALPHA'],
                        default='NONE',
                        help="set label type")
    parser.add_argument('files',
                        type=str,
                        nargs='+',
                        help='input files')

    return parser.parse_args()


def compute_nsize(nelm, nx, ny):
    mod = 0
    fill = 0
    if nx == 0 and ny > 0:
        nx, mod = divmod(nelm, ny)
        if mod > 0:
            nx += 1
            fill = ny - mod
    elif ny == 0 and nx > 0:
        ny, mod = divmod(nelm, nx)
        if mod > 0:
            ny += 1
            fill = nx - mod
    return (nx, ny, fill)


def run(args):
    nx, ny, fill = compute_nsize(len(args.files), args.nx, args.ny)
    if not (nx > 0 and ny > 0):
        print('Valid args are nx > 0 and ny > 0')
        return

    print(f'nx, ny, fill: {nx} {ny} {fill}')
    if fill > 0:
        # fill by 'BLACK'
        args.files += ['BLACK'] * fill

    img = None
    if args.file_order == 'X':
        img = make_htile(args.tile_wh, nx, args.files, args.label_type)
    elif args.file_order == 'Y':
        img = make_vtile(args.tile_wh, ny, args.files, args.label_type)

    if img is not None:
        cu.cv_save(args.output, img)


if __name__ == "__main__":
    run(parse_args())
