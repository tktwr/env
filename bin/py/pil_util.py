#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import numpy as np
from PIL import Image, ImageDraw
import ttpy as tu


def img_info(fname):
    img = Image.open(fname)
    print(f"format: {img.format}")
    print(f"mode: {img.mode}")
    print(f"size: {img.size}")
    print(f"getextrema(): {img.getextrema()}") 
    print(f"getbands(): {img.getbands()}")


def img_query(fname, pos):
    x, y = pos
    img = Image.open(fname)
    ar = np.asarray(img, 'f')
    print(ar[x, y])


def img_create_color(fname, size, mode, color):
    color = np.array(color)
    color *= 255
    color = tuple(color.astype(int))

    img = Image.new(mode, size, color)
    img.save(fname)


def img_create_nml(fname, size, nml):
    nml = np.array(nml)
    nml = nml * 0.5 + np.array([0.5, 0.5, 0.5])
    nml *= 255
    color = tuple(nml.astype(int))

    img = Image.new("RGB", size, color)
    img.save(fname)


def img_create_tile(fname, size, colors):
    w, h = size
    w2 = w / 2
    h2 = h / 2

    img = Image.new("RGB", size, (0, 0, 0))
    draw = ImageDraw.Draw(img)
    draw.rectangle((0  , 0  , w2-1 , h2-1) , fill=colors[0])
    draw.rectangle((w2 , 0  , w-1  , h2-1) , fill=colors[1])
    draw.rectangle((0  , h2 , w2-1 , h-1)  , fill=colors[2])
    draw.rectangle((w2 , h2 , w-1  , h-1)  , fill=colors[3])
    img.save(fname)


def img_resize(ifname, ofname, dst_wh):
    img = Image.open(ifname)
    new_wh = tu.fix_size(img.size, dst_wh)
    oimg = img.resize(new_wh)
    oimg.save(ofname)

    print(f"img_resize {ifname} {ofname} {new_size}")


