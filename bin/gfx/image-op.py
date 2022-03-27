#!/usr/bin/env python
# -*- coding: utf-8 -*-

import argparse
import tt_util as tu
import cv_util as cu


def f_image_split(ifname):
    fname = tu.FileName(ifname)
    name = fname.name()
    ext = fname.ext()
    #ext = ".png"

    img = cu.cv_load(ifname)

    img_list = cu.cv_split_img(img)
    idx = 0
    for i in img_list:
        ofname = f"{name}_{idx}{ext}"
        cu.cv_save(ofname, i)
        idx += 1


def f_image_merge(ofname, ifnames):
    img_list = []
    for i in ifnames:
        img = cu.cv_load(i)
        img_list.append(img)

    img_out = cu.cv_merge_img(img_list)
    cu.cv_save(ofname, img_out)


def parse_args():
    parser = argparse.ArgumentParser(
        formatter_class=tu.MyHelpFormatter,
        description='operate images')

    parser.add_argument('--split',
                        action='store_true',
                        help='split')
    parser.add_argument('--merge',
                        action='store_true',
                        help='merge')
    parser.add_argument('-o', '--ofname',
                        type=str,
                        default='output.png',
                        help='set output file name')
    parser.add_argument('files',
                        type=str,
                        nargs='+',
                        help='input files')

    return parser.parse_args()


if __name__ == "__main__":
    args = parse_args()

    if args.split:
        f_image_split(args.files[0])
    elif args.merge:
        f_image_merge(args.ofname, args.files)

