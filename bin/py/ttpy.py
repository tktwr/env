#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os


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


class ImageSize():
    def __init__(self, size):
        self.size = size

    def getSize(self, dst_size):
        sw, sh = self.size
        w, h = dst_size

        if w == 0 and h == 0:
            return (sw, sh)
        elif w > 0 and h == 0:
            return (w, int(w * (sh / sw)))
        elif w == 0 and h > 0:
            return (int(h * (sw / sh)), h)
        else:
            return (w, h)


