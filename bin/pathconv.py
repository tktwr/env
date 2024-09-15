#!/usr/bin/env python
# -*- coding: utf-8 -*-

import argparse
import tt_util as tu


def parse_args():
    parser = argparse.ArgumentParser(description='path conversion')
    parser.add_argument('-v', '--verbose',
                        action='store_true',
                        help='show verbose message')
    parser.add_argument('-t', '--type',
                        type=str,
                        choices=['unix', 'mixed', 'windows'],
                        default='unix',
                        help='set output type')
    parser.add_argument('-p', '--prefix',
                        type=str,
                        default='/mnt',
                        help='set prefix')
    parser.add_argument('files',
                        type=str,
                        nargs='*',
                        help='input files')
    return parser.parse_args()


def print_args(args):
    print(f"--- args ---")
    print(f"args.type   : {args.type}")
    print(f"args.prefix : {args.prefix}")
    print(f"args.files  : {args.files}")


if __name__ == "__main__":
    args = parse_args()
    if args.verbose:
        print_args(args)

    otype  = args.type
    prefix = args.prefix
    fname  = ' '.join(args.files)

    p = eval(f"tu.path_{otype}('{fname}', '{prefix}')")
    print(p)
