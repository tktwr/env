#!/usr/bin/env python
# -*- coding: utf-8 -*-

import argparse
import numpy as np
import tt_util as tu
import cv_util as cu
import cv2


def make_img_list(wh, ifnames, label):
    blank_img = np.zeros((wh[1], wh[0], 3), 'uint8')

    nr = 1
    l1 = []
    for i in ifnames:
        if i == 'None':
            img = blank_img
        else:
            img = cu.cv_load(i)
            img = cu.cv_fit_img(img, wh)
            img = cu.cv_crop_img(img, (0, 0), wh, True)

            if label == 'FILE':
                name = i.split('/')[-1]
            elif label == 'NUM':
                name = f'{nr})'
                nr += 1
            elif label == 'ALPHA':
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


def make_vtile(tile_wh, cols, ifnames, label):
    l1 = make_img_list(tile_wh, ifnames, label)
    rows = len(l1) // cols
    l2 = cu.cv_convert_1d_to_2d(l1, rows)
    return cu.cv_vtile(l2)


def make_htile(tile_wh, cols, ifnames, label):
    l1 = make_img_list(tile_wh, ifnames, label)
    l2 = cu.cv_convert_1d_to_2d(l1, cols)
    return cu.cv_htile(l2)


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
                        default='tile.png',
                        help="set output file name")
    parser.add_argument('-l', '--label',
                        type=str,
                        choices=['NONE', 'FILE', 'NUM', 'ALPHA'],
                        default='NONE',
                        help="set label type")
    parser.add_argument('--tile_wh',
                        type=int,
                        nargs=2,
                        default=[500, 500],
                        help='set each tile size')
    parser.add_argument('-c', '--cols',
                        type=int,
                        default=2,
                        help="set columns")
    parser.add_argument('-h', '--htile',
                        action='store_true',
                        help="input files are in horizontal order")
    parser.add_argument('files',
                        type=str,
                        nargs='+',
                        help='input files')

    return parser.parse_args()


if __name__ == "__main__":
    args = parse_args()

    if args.htile:
        img = make_htile(args.tile_wh, args.cols, args.files, args.label)
    else:
        img = make_vtile(args.tile_wh, args.cols, args.files, args.label)

    cu.cv_save(args.output, img)
