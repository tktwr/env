#!/usr/bin/env python
# -*- coding: utf-8 -*-

import re
import argparse


def drive_unix(match):
    return f'/{match.group(1).lower()}'


def drive_windows(match):
    return f'{match.group(1).upper()}:/'


def path_unix(fname, prefix=''):
    fname = re.sub(f'^{prefix}', '', fname)
    fname = re.sub(f'^([c-zC-Z]):', drive_unix, fname)
    fname = prefix + fname
    fname = fname.replace('\\', '/')
    return fname


def path_mixed(fname, prefix=''):
    fname = re.sub(f'^{prefix}', '', fname)
    fname = re.sub(f'^/([c-zC-Z])/', drive_windows, fname)
    fname = fname.replace('\\', '/')
    return fname


def path_windows(fname, prefix=''):
    fname = re.sub(f'^{prefix}', '', fname)
    fname = re.sub(f'^/([c-zC-Z])/', drive_windows, fname)
    fname = fname.replace('/', '\\')
    return fname


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
                        default='',
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


def test(fname, prefix):
    print('--- test ---')
    fname_unix = path_unix(fname, prefix)
    fname_mix  = path_mixed(fname, prefix)
    fname_win  = path_windows(fname, prefix)
    print(f'orig : {fname}')
    print(f'unix : {fname_unix}')
    print(f'mix  : {fname_mix}')
    print(f'win  : {fname_win}')


if __name__ == "__main__":
    args = parse_args()
    if args.verbose:
        print_args(args)

        test(*['D:/aa\\bb/cc.txt', '/mnt'])
        test(*['/d/aa\\bb/cc.txt', '/mnt'])
        test(*['/mnt/d/aa\\bb/mnt/cc.txt', '/mnt'])
        quit()

    otype  = args.type
    fname  = args.files[0]
    prefix = args.prefix

    p = eval(f"path_{otype}('{fname}', '{prefix}')")
    print(p)

