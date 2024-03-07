#!/usr/bin/env python
# -*- coding: utf-8 -*-

import argparse
import fileinput


def str_to_val(s):
    s = s.replace(',', '')
    return int(s)


def sumcol(fp, col, sep):
    total = 0
    for line in fp:
        l = line.strip().split(sep)
        total += str_to_val(l[col])
    return total


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('file', nargs='*')
    parser.add_argument('-c', '--column',    type=int, default=2,   help="set column (default=2)")
    parser.add_argument('-s', '--separator', type=str, default='|', help="set separator (default='|')")
    args = parser.parse_args()

    with fileinput.input(args.file) as f:
        total = sumcol(f, args.column, args.separator)
        print(f"{total:,d}")


if __name__ == "__main__":
    main()
