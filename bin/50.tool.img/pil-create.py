#!/usr/bin/env python
# -*- coding: utf-8 -*-

import argparse
import tt_util as tu
import pil_util as pu


# =====================================================
def parse_args():
    parser = argparse.ArgumentParser(description='create an image')

    A = parser.add_argument

    A('-i' , '--input'   , help='set input filename'   , type=str            , default="input.png"    , )
    A('-o' , '--output'  , help='set output filename'  , type=str            , default="output.png"   , )
    A('-v' , '--verbose' , help='show verbose message' , action='store_true' , )
    A('-a' , '--action'  , help='set action'           , type=str            , default="create_color" , choices=['create_color' , 'create_nml' , 'create_metalroughness' , 'query' , 'info'] , )
    A('-s' , '--size'    , help='set image size'       , nargs='+'           , type=int               , default=[256            , 256]         , )
    A('-p' , '--pos'     , help='set position'         , nargs='+'           , type=int               , default=[0              , 0]           , )
    A('-c' , '--color'   , help='set color'            , nargs='+'           , type=float             , default=[1.0            , 1.0          , 1.0]                    , )

    return parser.parse_args()


# -----------------------------------------------------
if __name__ == "__main__":
    args = parse_args()
    if args.verbose:
        tu.print_args(args)

    if args.action == 'create_color':
        pu.img_create_color(args.output, args.size, "RGB", args.color)
    elif args.action == 'create_nml':
        pu.img_create_nml(args.output, args.size, args.color)
    elif args.action == 'query':
        pu.img_query(args.input, args.pos)
    elif args.action == 'info':
        pu.img_info(args.input)
