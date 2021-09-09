#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import argparse
import img_util as iu


def parse_args(argv):
    parser = argparse.ArgumentParser(description='description')
    parser.add_argument('-v', '--verbose',
                        action='store_true',
                        help='show verbose message')
    parser.add_argument('-a', '--action',
                        choices=['create_color', 'create_nml', 'create_metalroughness', 'query', 'info'],
                        type=str,
                        default="create_color",
                        help='set action')
    parser.add_argument('-i', '--ifname',
                        type=str,
                        default="input.png",
                        help='set input filename')
    parser.add_argument('-o', '--ofname',
                        type=str,
                        default="output.png",
                        help='set output filename')
    parser.add_argument('-s', '--size',
                        nargs='+',
                        type=int,
                        default=[256, 256],
                        help='set image size')
    parser.add_argument('-p', '--pos',
                        nargs='+',
                        type=int,
                        default=[0, 0],
                        help='set position')
    parser.add_argument('-c', '--color',
                        nargs='+',
                        type=float,
                        default=[1.0, 1.0, 1.0],
                        help='set color')

    args = parser.parse_args()
    return args


if __name__ == "__main__":
    args = parse_args(sys.argv)
    if args.verbose:
        print(f"args.verbose: {args.verbose}")
        print(f"args.action: {args.action}")
        print(f"args.ifname: {args.ifname}")
        print(f"args.ofname: {args.ofname}")
        print(f"args.size: {args.size}")
        print(f"args.pos: {args.pos}")
        print(f"args.color: {args.color}")
        print();

    if args.action == 'create_color':
        iu.img_create_color(args.ofname, args.size, "RGB", args.color)
    elif args.action == 'create_nml':
        iu.img_create_nml(args.ofname, args.size, args.color)
    elif args.action == 'query':
        iu.img_query(args.ifname, args.pos)
    elif args.action == 'info':
        iu.img_info(args.ifname)

