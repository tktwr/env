#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import tt_util as tu
import cv_util as cu
import cv2


def f_show(fname, size):
    img = cu.imgfile_load(fname)
    oimg = cu.img_fit(img, size)
    cv2.imshow(f"{fname}, {img.shape} {img.dtype}", oimg)

    key = cv2.waitKey()
    if key == 115: # 's'
        fn = tu.FileName(fname)
        ofname = f"small_{fn.name()}.png"
        cu.imgfile_save(ofname, oimg)


def f_show_all(args):
    for fname in args.files:
        try:
            if os.path.isfile(fname) == False:
                continue
            f_show(fname, args.size)
        except Exception as e:
            print(f'{e}: {fname}')


# =====================================================
def parse_args():
    parser = tu.parser('show images')
    A = parser.add_argument

    A('files' , nargs='+' , help='input files'      , type=str , )
    A('-s'    , '--size'  , help='set display size' , type=int , nargs=2 , default=[500 , 500] , )

    return parser.parse_args()


# -----------------------------------------------------
if __name__ == "__main__":
    args = parse_args()
    f_show_all(args)
