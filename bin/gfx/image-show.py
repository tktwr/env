#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import cv2


def img_show(fname):
    img = cv2.imread(fname)
    cv2.imshow(f"{fname}", img)


if __name__ == "__main__":
    for fname in sys.argv[1:]:
        img_show(fname)
    cv2.waitKey()

