#!/usr/bin/env python
# -*- coding: utf-8 -*-

import argparse
import tt_util as tu


def vimapi_exec(cmd):
    print(f'\e]51;["call","Tapi_Exec","{cmd}"]\x07')


def vimapi_exec_in_prev_win(cmd):
    print(f'\e]51;["call","Tapi_ExecInPrevWin","{cmd}"]\x07')


def vimapi_exec_in_above_win(cmd):
    print(f'\e]51;["call","Tapi_ExecInAboveWin","{cmd}"]\x07')


def vimapi_exec_in_new_tab(cmd):
    print(f'\e]51;["call","Tapi_ExecInNewTab","{cmd}"]\x07')


def parse_args():
    parser = argparse.ArgumentParser(
        formatter_class=tu.MyHelpFormatter,
        description='vimapi',
        add_help=False)

    parser.add_argument('--help',
                        action='help',
                        help="show this help message and exit")
    parser.add_argument('-v', '--verbose',
                        action='store_true',
                        help='show verbose message')
    parser.add_argument('cmd',
                        type=str,
                        nargs='+',
                        help='commands')

    return parser.parse_args()


if __name__ == "__main__":
    args = parse_args()
    vimapi_exec(args.cmd)

