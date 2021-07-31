#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
from PIL import Image


def f_image_info(fname):
    img = Image.open(fname)
    print(f"format: {img.format}")
    print(f"mode: {img.mode}")
    print(f"size: {img.size}")
    print(f"img.getextrema(): {img.getextrema()}") 
    print(f"img.getbands(): {img.getbands()}")


if __name__ == "__main__":
    f_image_info(sys.argv[1])

