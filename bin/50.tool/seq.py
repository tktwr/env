#!/usr/bin/env python
# -*- coding: utf-8 -*-

import tt_util as tu


def f_seq(args):
    nr = args.start
    for i in args.files:
        FN = tu.FileName(i)
        ext = FN.ext()
        dst_fname = f'{args.prefix}{nr:05d}{ext}'
        nr += 1

        print(f'{args.action} "{i}" "{dst_fname}"')

        if args.noexec:
            continue

        if args.action == 'cp':
            tu.sh_cp(i, dst_fname)
        elif args.action == 'mv':
            tu.sh_mv(i, dst_fname)


# =====================================================
def parse_args():
    parser = tu.parser('rename files to the sequential numbers')
    A = parser.add_argument

    A('files' , nargs='+'  , help='input files'      , type=str            , )
    A('-n'    , '--noexec' , help='no execute'       , action='store_true' , )
    A('-s'    , '--start'  , help='set start number' , type=int            , default=1      , )
    A('-p'    , '--prefix' , help='set prefix'       , type=str            , default='seq_' , )
    A('-a'    , '--action' , help="cp / mv"          , type=str            , default='cp'   , choices=['cp' , 'mv'] , )

    return parser.parse_args()


# -----------------------------------------------------
if __name__ == "__main__":
    args = parse_args()
    f_seq(args)
