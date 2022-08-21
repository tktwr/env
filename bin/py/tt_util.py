#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import re
import time
import json
import argparse
import numpy as np


#------------------------------------------------------
# MyHelpFormatter
#------------------------------------------------------
class MyHelpFormatter(
    argparse.RawDescriptionHelpFormatter,
    argparse.ArgumentDefaultsHelpFormatter,
    argparse.MetavarTypeHelpFormatter,
    ):
    pass


#------------------------------------------------------
# file name
#------------------------------------------------------
class FileName():
    def __init__(self, orig_path):
        self._orig_path = orig_path
        self._dirname = os.path.dirname(self._orig_path)
        self._filename = os.path.basename(self._orig_path)

    def origname(self):
        return self._orig_path

    def dirname(self):
        return self._dirname

    def filename(self):
        return self._filename

    def name(self):
        name, ext = os.path.splitext(self._filename)
        return name

    def ext(self):
        name, ext = os.path.splitext(self._filename)
        return ext


#------------------------------------------------------
# image size
#------------------------------------------------------
# dst_wh:
#   (0, 0) : source size
#   (w, 0) : set width, keep aspect ratio
#   (0, h) : set height, keep aspect ratio
#   (w, h) : set width and height, not keep aspect ratio
def fix_size(src_wh, dst_wh):
    sw, sh = src_wh
    w, h = dst_wh

    if w == 0 and h == 0:
        return (sw, sh)
    elif w > 0 and h == 0:
        return (w, int(w * (sh / sw)))
    elif w == 0 and h > 0:
        return (int(h * (sw / sh)), h)
    else:
        return (w, h)


# compute the maximized size
def fit_size(src_wh, max_wh):
    w, h = src_wh
    w_max, h_max = max_wh

    if h >= w and h > h_max:
        dst_wh = (0, h_max)
    elif w >= h and w > w_max:
        dst_wh = (w_max, 0)
    else:
        dst_wh = (0, 0)

    return fix_size(src_wh, dst_wh)


#------------------------------------------------------
# timeit
#------------------------------------------------------
def timeit(func):
    def wrapper(*args, **kargs):
        time_list = []
        for i in range(5):
            start = time.time()
            func(*args, **kargs)
            end = time.time()
            time_list.append(end - start)
        avg = np.mean(time_list)
        median = np.median(time_list)
        print(f"{func.__name__}: avg={avg:.3f} sec, median={median:.3f} sec")
    return wrapper


#------------------------------------------------------
# text
#------------------------------------------------------
def read_text(fname):
    with open(fname, "r") as f:
        return f.readlines()


def write_text(fname, lines):
    with open(fname, "w") as f:
        for i in lines:
            f.write(i)


#------------------------------------------------------
# json
#------------------------------------------------------
def read_json(fname):
    with open(fname, "r") as f:
        return json.load(f)


def write_json(fname, data):
    with open(fname, "w") as f:
        f.write(json.dumps(data, sort_keys=True, indent=4))
