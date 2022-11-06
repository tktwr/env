#!/usr/bin/env python
# -*- coding: utf-8 -*-

import re
import argparse
import tt_path_util as ttp


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
                    dir_name = ttp.expand_env(dir_name)

                dir_name = ttp.path_unix(dir_name, args.prefix)
                dir_name_win = re.sub(r'(\$\w+)', r'\1_WIN', dir_name)
                dir_name_win = ttp.path_mixed(dir_name_win, args.prefix)

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


def parse_args():
    parser = argparse.ArgumentParser(description='make env variables')
    parser.add_argument('-v', '--verbose',
                        action='store_true',
                        help='show verbose message')
    parser.add_argument('-p', '--prefix',
                        type=str,
                        default='',
                        help='set prefix')
    parser.add_argument('files',
                        type=str,
                        nargs='+',
                        help='input files')
    return parser.parse_args()


def print_args(args):
    print(f"--- args ---")
    print(f"args.prefix : {args.prefix}")
    print(f"args.files  : {args.files}")


def main(files, args):
    print(f"#!/bin/bash")
    for i in files:
        f_expand_env(i, args)


if __name__ == "__main__":
    args = parse_args()
    if args.verbose:
        print_args(args)

    main(args.files, args)
