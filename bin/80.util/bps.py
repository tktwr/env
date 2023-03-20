#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import parse


def str_to_byte(size_str):
    res = parse.parse("{:f}{:w}", size_str)
    f = res[0]
    w = res[1]
    if w == 'T':
        size_byte = f * 1024 * 1024 * 1024 * 1024
    elif w == 'G':
        size_byte = f * 1024 * 1024 * 1024
    elif w == 'M':
        size_byte = f * 1024 * 1024
    elif w == 'K':
        size_byte = f * 1024
    else:
        size_byte = f
    return size_byte


def sec_to_str(sec):
    one_min = 60
    one_hour = 60 * 60
    one_day = 60 * 60 * 24

    if sec < one_min:
        s = str(sec) + " sec"
    elif sec < one_hour:
        s = str(sec / one_min) + " min"
    elif sec < one_day:
        s = str(sec / one_hour) + " hour"
    else:
        s = str(sec / one_day) + " day"
    return s


def main(argv):
    print(f"{argv[0]} / {argv[1]} bps")
    file_byte = str_to_byte(argv[0])
    byte_per_sec = str_to_byte(argv[1]) / 8
    time_sec = file_byte / byte_per_sec
    print(f"estimated download time: {sec_to_str(time_sec)}")


# bps.py 10.0G 10.0M
if __name__ == "__main__":
    main(sys.argv[1:])

