#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import argparse
import cv_util as cu


def f_info(files, args):
    for fname in files:
        try:
            if os.path.isfile(fname) == False:
                continue

            if args.verbose:
                cu.cv_info(fname)
            else:
                cu.cv_info_short(fname)
        except Exception as e:
            print(f'fail to get info ... {fname} {e}')


def parse_args():
    parser = argparse.ArgumentParser(description='convert images', add_help=False)
    parser.add_argument('--help',
                        action='help',
                        help="show this help message and exit")
    parser.add_argument('-v', '--verbose',
                        action='store_true',
                        help='show verbose message')
    parser.add_argument('files',
                        nargs='+',
                        type=str,
                        help='input files')
    return parser.parse_args()


if __name__ == "__main__":
    args = parse_args()
    f_info(args.files, args)

