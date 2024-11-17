#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sys
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '../../bin/py'))
import re
import argparse
import tt_util as tu


def f_expand_env(fname, args):
    try:
        with open(fname, "r") as f:
            for line in f:
                line = line.rstrip('\n')
                if line == "" or line[0] == "#":
                    continue

                lst = line.split('|')

                name = lst[0].strip()
                env_name = lst[1].strip()
                dir_name = lst[2].strip()

                # expand env except MY_XXX
                r = re.search(r'^\$MY_', dir_name)
                if r is None:
                    dir_name = tu.expand_env(dir_name)

                dir_name = tu.path_unix(dir_name, args.prefix)
                dir_name_win = re.sub(r'(\$\w+)', r'\1_WIN', dir_name)
                dir_name_win = tu.path_mixed(dir_name_win, args.prefix)

                print(f'export {env_name}="{dir_name}"')
                print(f'export {env_name}_WIN="{dir_name_win}"')
                print(f'alias cd.{name}=\'cd "${env_name}"\'')
                print(f'alias .{name}=\'pushd "${env_name}"\'')
    except FileNotFoundError as e:
        # print(f"FileNotFoundError: {e}")
        pass
    except Exception as e:
        # print(f"Exception: {e}")
        pass


def main(files, args):
    print(f"#!/bin/bash")
    for i in files:
        f_expand_env(i, args)


# =====================================================
def parse_args():
    parser = tu.parser('make env variables')
    A = parser.add_argument

    A('files' , nargs='+'   , help='input files'          , type=str)
    A('-v'    , '--verbose' , help='show verbose message' , action='store_true')
    A('-p'    , '--prefix'  , help='set prefix'           , type=str             , default='')

    return parser.parse_args()


# -----------------------------------------------------
if __name__ == "__main__":
    args = parse_args()
    if args.verbose:
        tu.print_args(args)

    main(args.files, args)
