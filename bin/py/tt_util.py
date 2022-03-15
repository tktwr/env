#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import re


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


def max_size(src_wh, max_wh):
    w, h = src_wh
    w_max, h_max = max_wh

    if h >= w and h > h_max:
        dst_wh = (0, h_max)
    elif w >= h and w > w_max:
        dst_wh = (w_max, 0)
    else:
        dst_wh = (0, 0)

    return fix_size(src_wh, dst_wh)


def expand_env(s):
    r = re.search('\$\w+', s)
    if r != None:
        matched = r.group()
        env_var = matched[1:]
        if os.getenv(env_var) != None:
            s = s.replace(matched, os.environ[env_var])
    return s


def unix_path(fname):
    fname = re.sub('^C:', '/c', fname)
    fname = fname.replace('\\', '/')
    return fname


def win_path(fname):
    fname = re.sub('(\$[^/]*)', '\\1_WIN', fname)
    fname = re.sub('^/c', 'C:', fname)
    #fname = fname.replace('/', '\\')
    fname = fname.replace('\\', '/')
    return fname

