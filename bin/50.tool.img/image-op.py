#!/usr/bin/env python
# -*- coding: utf-8 -*-

import argparse
import tt_util as tu
import cv_util as cu


# =====================================================
def f_imgf_split(ifname):
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


# -----------------------------------------------------
def f_imgf_merge(ofname, ifnames):
    img_list = []
    for i in ifnames:
        img = cu.cv_load(i)
        img_list.append(img)

    oimg = cu.cv_merge_img(img_list)
    cu.cv_save(ofname, oimg)


# -----------------------------------------------------
def f_imgf_diff(ofname, ifname1, ifname2):
    img1 = cu.cv_load(ifname1)
    img2 = cu.cv_load(ifname2)
    oimg = cu.cv_diff_img(img1, img2)
    cu.cv_save(ofname, oimg)


# -----------------------------------------------------
def f_imgf_compare(ofname, ifname1, ifname2):
    img1 = cu.cv_load(ifname1)
    img2 = cu.cv_load(ifname2)
    oimg = cu.cv_compare_img(img1, img2)
    cu.cv_save(ofname, oimg)


# =====================================================
def parse_args():
    parser = argparse.ArgumentParser(
        formatter_class=tu.MyHelpFormatter,
        description='operate images')

    parser.add_argument('files' , nargs='+'   , help='input files'          , type=str            , )
    parser.add_argument('-o'    , '--output'  , help='set output file name' , type=str            , default='output.png' , )
    parser.add_argument('-s'    , '--split'   , help='split'                , action='store_true' , )
    parser.add_argument('-m'    , '--merge'   , help='merge'                , action='store_true' , )
    parser.add_argument('-d'    , '--diff'    , help='diff'                 , action='store_true' , )
    parser.add_argument('-c'    , '--compare' , help='compare'              , action='store_true' , )

    return parser.parse_args()


# -----------------------------------------------------
if __name__ == "__main__":
    args = parse_args()

    if args.split:
        f_imgf_split(args.files[0])
    elif args.merge:
        f_imgf_merge(args.output, args.files)
    elif args.diff:
        f_imgf_diff(args.output, args.files[0], args.files[1])
    elif args.compare:
        f_imgf_compare(args.output, args.files[0], args.files[1])

