#!/usr/bin/env python
# -*- coding: utf-8 -*-

import tt_util as tu


def parse_args():
    parser = tu.parser('path conversion')
    A = parser.add_argument

    A('files' , nargs='*'   , help='input files'          , type=str            , )
    A('-v'    , '--verbose' , help='show verbose message' , action='store_true' , )
    A('-t'    , '--type'    , help='set output type'      , type=str            , default='unix'  , choices=['unix' , 'mixed' , 'windows'])
    A('-p'    , '--prefix'  , help='set prefix'           , type=str            , default='/mnt')

    return parser.parse_args()


if __name__ == "__main__":
    args = parse_args()
    if args.verbose:
        tu.print_args(args)

    otype  = args.type
    prefix = args.prefix
    fname  = ' '.join(args.files)

    p = eval(f"tu.path_{otype}('{fname}', '{prefix}')")
    print(p)
