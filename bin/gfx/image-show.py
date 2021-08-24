#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import cv2


def img_show(fname):
    img = cv2.imread(fname)
    cv2.imshow(f"{fname}", img)
    cv2.waitKey()


if __name__ == "__main__":
    img_show(sys.argv[1])

