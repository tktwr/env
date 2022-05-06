#!/usr/bin/env python
# -*- coding: utf-8 -*-

import re
import os
import argparse


def expand_env(s):
    r = re.search('\$\w+', s)
    if r != None:
        matched = r.group()
        env_var = matched[1:]
        if os.getenv(env_var) != None:
            s = s.replace(matched, os.environ[env_var])
    return s


def unix_path(fname, prefix=''):
    fname = re.sub('^C:', f'{prefix}/c', fname)
    fname = re.sub('^D:', f'{prefix}/d', fname)
    fname = fname.replace('\\', '/')
    return fname


def win_path(fname, prefix=''):
    fname = re.sub('(\$[^/]*)', '\\1_WIN', fname)
    fname = re.sub(f'^{prefix}/c', 'C:', fname)
    fname = re.sub(f'^{prefix}/d', 'D:', fname)
    #fname = fname.replace('/', '\\')
    fname = fname.replace('\\', '/')
    return fname


def f_print_env(fname, args):
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
                r = re.search('^\$MY_', dir_name)
                if r == None:
                    dir_name = expand_env(dir_name)

                dir_name = unix_path(dir_name, args.prefix)
                dir_name_win = win_path(dir_name, args.prefix)

                print(f"export {env_name}=\"{dir_name}\"")
                print(f"export {env_name}_WIN=\"{dir_name_win}\"")
                print(f"alias cd.{name}='cd \"{dir_name}\"'")
                print(f"alias .{name}='pushd \"{dir_name}\"'")
    except FileNotFoundError as e:
        #print(f"FileNotFoundError: {e}")
        pass
    except Exception as e:
        #print(f"Exception: {e}")
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
        f_print_env(i, args)


if __name__ == "__main__":
    args = parse_args()
    if args.verbose:
        print_args(args)

    main(args.files, args)


