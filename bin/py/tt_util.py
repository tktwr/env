#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sys
import time
import subprocess
import json
import argparse
import numpy as np


# -----------------------------------------------------
# log
# -----------------------------------------------------
def log(s):
    print(f'{s}', file=sys.stderr)


def log_sep(s):
    print(f'--- {s} --------------------', file=sys.stderr)


def log_sep_0(s):
    print(f'=== {s} ====================', file=sys.stderr)


def log_title(title, sep='-', sep_n=55, place='center'):
    separator = sep * sep_n
    n = len(title)
    out = separator
    if place == 'left':
        out = title + separator[n:]
    elif place == 'right':
        out = separator[:-n] + title
    elif place == 'center':
        nn = len(separator) - n
        r = nn % 2
        nl = int(nn / 2)
        nr = int(nn / 2) + r
        sepl = separator[:nl]
        sepr = separator[-nr:]
        out = sepl + title + sepr
    print(f'{out}', flush=True, file=sys.stderr)


# -----------------------------------------------------
def print_args(args):
    print(f"--- args ---")
    print(f"{args}")


# -----------------------------------------------------
# list
# -----------------------------------------------------
def lst_split_sublists(lst, mx):
    '''
    Split the list into sublists, each of length mx
    '''
    return [lst[i:i+mx] for i in range(0, len(lst), mx)]


def lst_prefix_match(lst, start_str):
    return [i for i in lst if i.startswith(start_str)]


def get_all_funcs(lst):
    if len(sys.argv) == 1:
        func_lst = lst_prefix_match(lst, 'f_')
    else:
        func_lst = sys.argv[1:]
    log(f'func_lst: {func_lst}')
    return func_lst


def tile_fill(nelm, nx, ny):
    mod = 0
    fill = 0
    if nx > 0 and ny > 0:
        fill = nx * ny - nelm
    elif nx == 0 and ny > 0:
        nx, mod = divmod(nelm, ny)
        if mod > 0:
            nx += 1
            fill = ny - mod
    elif ny == 0 and nx > 0:
        ny, mod = divmod(nelm, nx)
        if mod > 0:
            ny += 1
            fill = nx - mod
    return (nx, ny, fill)


# -----------------------------------------------------
# MyHelpFormatter
# -----------------------------------------------------
class MyHelpFormatter(argparse.RawDescriptionHelpFormatter,
                      argparse.ArgumentDefaultsHelpFormatter,
                      argparse.MetavarTypeHelpFormatter):
    pass


# -----------------------------------------------------
# file name
# -----------------------------------------------------
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


# -----------------------------------------------------
# image size
# -----------------------------------------------------
def fix_size(src_wh: tuple[int, int], dst_wh: tuple[int, int]):
    '''
    Args:
        src_wh: src size
        dst_wh: dst size

    Note:
        dst_wh:
            (0, 0): source size
            (w, 0): set width, keep aspect ratio
            (0, h): set height, keep aspect ratio
            (w, h): set width and height, not keep aspect ratio
    '''
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


# -----------------------------------------------------
# timeit
# -----------------------------------------------------
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


# -----------------------------------------------------
# text
# -----------------------------------------------------
def read_text(fname):
    with open(fname, "r") as f:
        return f.readlines()


def write_text(fname, lines):
    with open(fname, "w") as f:
        for i in lines:
            f.write(i)


# -----------------------------------------------------
# json
# -----------------------------------------------------
def read_json(fname):
    with open(fname, "r") as f:
        return json.load(f)


def write_json(fname, data):
    with open(fname, "w") as f:
        f.write(json.dumps(data, sort_keys=True, indent=4))


# -----------------------------------------------------
def run(command):
    proc = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

    while True:
        line = proc.stdout.readline().decode('utf-8', 'replace')
        if line:
            sys.stdout.write(line)
        if not line and proc.poll() is not None:
            break
