#!/usr/bin/env python
# -*- coding: utf-8 -*-

import tt_util as tu
import cv_util as cu


# =====================================================
def f_imgfile_split(ifname):
    fname = tu.FileName(ifname)
    name = fname.name()
    ext = fname.ext()
    #ext = ".png"

    img = cu.imgfile_load(ifname)

    img_list = cu.img_split(img)
    idx = 0
    for i in img_list:
        ofname = f"{name}_{idx}{ext}"
        cu.imgfile_save(ofname, i)
        idx += 1


# -----------------------------------------------------
def f_imgfile_merge(ofname, ifnames):
    img_list = []
    for i in ifnames:
        img = cu.imgfile_load(i)
        img_list.append(img)

    oimg = cu.img_merge(img_list)
    cu.imgfile_save(ofname, oimg)


# -----------------------------------------------------
def f_imgfile_diff(ofname, ifname1, ifname2, scale):
    img1 = cu.imgfile_load(ifname1)
    img2 = cu.imgfile_load(ifname2)
    oimg = cu.img_diff(img1, img2, scale)
    cu.imgfile_save(ofname, oimg)


# -----------------------------------------------------
def f_imgfile_compare(ofname, ifname1, ifname2):
    img1 = cu.imgfile_load(ifname1)
    img2 = cu.imgfile_load(ifname2)
    oimg = cu.img_compare(img1, img2)
    cu.imgfile_save(ofname, oimg)


# =====================================================
def parse_args():
    parser = tu.parser('operate images')
    A = parser.add_argument

    A('files' , nargs='+'   , help='input files'          , type=str            , )
    A('-o'    , '--output'  , help='set output file name' , type=str            , default='output.png' , )
    A('-s'    , '--split'   , help='split'                , action='store_true' , )
    A('-m'    , '--merge'   , help='merge'                , action='store_true' , )
    A('-d'    , '--diff'    , help='diff'                 , action='store_true' , )
    A('-c'    , '--compare' , help='compare'              , action='store_true' , )
    A('-sc'   , '--scale'   , help='set scale'            , type=float          , default=1.0          , )

    return parser.parse_args()


# -----------------------------------------------------
if __name__ == "__main__":
    args = parse_args()

    if args.split:
        f_imgfile_split(args.files[0])
    elif args.merge:
        f_imgfile_merge(args.output, args.files)
    elif args.diff:
        f_imgfile_diff(args.output, args.files[0], args.files[1], args.scale)
    elif args.compare:
        f_imgfile_compare(args.output, args.files[0], args.files[1])

