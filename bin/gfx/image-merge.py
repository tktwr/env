#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import cv2
import cv_util as cu


def f_image_merge(ofname, ifnames):
    img_list = []
    for i in ifnames:
        img = cu.cv_load(i)
        img_list.append(img)

    img_out = cv2.merge(img_list)
    cu.cv_save(ofname, img_out)


if __name__ == "__main__":
    ofname = sys.argv[1]
    ifnames = sys.argv[2:]

    print(f"ofname  = {ofname}")
    print(f"ifnames = {ifnames}")

    f_image_merge(ofname, ifnames)

