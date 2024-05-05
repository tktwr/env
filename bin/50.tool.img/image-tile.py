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


# -----------------------------------------------------
def compute_nsize(nelm, nx, ny):
    mod = 0
    fill = 0
    if nx > 0 and ny > 0:
        fill = nx * ny - nelm
    elif nx == 0 and ny > 0:
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


def save_tile(ofname, files, args):
    nx, ny, fill = compute_nsize(len(files), args.nx, args.ny)
    if not (nx > 0 and ny > 0):
        print('Valid args are nx > 0 and ny > 0')
        return

    print(f'nx, ny, fill: {nx} {ny} {fill}')
    if fill > 0:
        # fill by 'BLACK'
        files += ['BLACK'] * fill

    img = None
    if args.order == 'X':
        img = make_htile(args.tile_wh, nx, files, args.label_type)
    elif args.order == 'Y':
        img = make_vtile(args.tile_wh, ny, files, args.label_type)

    if img is not None:
        cu.cv_save(ofname, img)


def save_tiles(args):
    mx = args.max
    if mx == 0:
        mx = len(args.files)

    sub_files = [args.files[i:i+mx] for i in range(0, len(args.files), mx)]
    n = 0
    for i in sub_files:
        ofname = args.output % n
        save_tile(ofname, i, args)
        n += 1


# -----------------------------------------------------
def parse_args():
    parser = argparse.ArgumentParser(
        formatter_class=tu.MyHelpFormatter,
        description='tiling images',
        add_help=False)

    parser.add_argument('--help', help="show this help message and exit",
                        action='help')
    parser.add_argument('-o', '--output', help="set output file name",
                        type=str, default='tile_%02d.jpg')
    parser.add_argument('-max', help="set max",
                        type=int, default=0)
    parser.add_argument('-nx', help="set nx",
                        type=int, default=0)
    parser.add_argument('-ny', help="set ny",
                        type=int, default=0)
    parser.add_argument('-T', '--tile-wh', help='set each tile image size (w, h)',
                        type=int, nargs=2, default=[500, 500])
    parser.add_argument('-O', '--order', help="set the order of input files",
                        type=str, default='X', choices=['X', 'Y'])
    parser.add_argument('-L', '--label-type', help="set label type",
                        type=str, default='NONE', choices=['NONE', 'FILE', 'NUM', 'ALPHA'])
    parser.add_argument('files', help='input files',
                        type=str, nargs='+')

    return parser.parse_args()


if __name__ == "__main__":
    save_tiles(parse_args())
