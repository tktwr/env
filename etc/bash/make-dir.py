#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import os


def f_expand_path_unix(fname):
    fname = fname.replace('$USERPROFILE', os.environ['USERPROFILE'])
    fname = fname.replace('$USERNAME', os.environ['USERNAME'])
    fname = fname.replace('C:', '/c')
    fname = fname.replace('\\', '/')
    return fname


def f_expand_path_win(fname):
    fname = fname.replace('$USERPROFILE', os.environ['USERPROFILE'])
    fname = fname.replace('$USERNAME', os.environ['USERNAME'])
    fname = fname.replace('/c', 'C:')
    fname = fname.replace('/', '\\')
    return fname


def f_make_dir(fname):
    try:
        with open(fname, "r") as f:
            for line in f:
                if line[0] == "#":
                    continue
                line = line.rstrip('\n')
                lst = line.split('|')

                name = lst[0].strip()
                env_name = lst[1].strip()
                dir_name = f_expand_path_unix(lst[2].strip())
                dir_name_win = f_expand_path_win(lst[2].strip())

                print(f"export {env_name}={dir_name}")
                print(f"export {env_name}_WIN={dir_name_win}")
                print(f"alias cd.{name}='cd {dir_name}'")
                print(f"alias .{name}='pushd {dir_name}'")
    except FileNotFoundError as e:
        pass;
    except Exception as e:
        pass;


def main(argv):
    print(f"#!/bin/bash")
    for i in argv:
        f_make_dir(i)


if __name__ == "__main__":
    main(sys.argv[1:])

