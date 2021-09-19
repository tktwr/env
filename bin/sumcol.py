#!/usr/bin/env python
# -*- coding: utf-8 -*-

import argparse
import fileinput


def str_to_val(s):
    s = s.replace(',', '')
    return int(s)


def sumcol(fp, col):
    total = 0
    for line in fp:
        l = line.strip().split('|')
        total += str_to_val(l[col])
    print(total)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('filenames', nargs='*')
    args = parser.parse_args()

    with fileinput.input(args.filenames) as f:
        sumcol(f, 1)


if __name__ == "__main__":
    main()
