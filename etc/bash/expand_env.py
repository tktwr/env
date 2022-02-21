#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import re
import tt_util as tu


def f_make_dir(fname):
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
                    dir_name = tu.expand_env(dir_name)

                dir_name = tu.unix_path(dir_name)
                dir_name_win = tu.win_path(dir_name)

                print(f"export {env_name}=\"{dir_name}\"")
                print(f"export {env_name}_WIN=\"{dir_name_win}\"")
                print(f"alias cd.{name}='cd \"{dir_name}\"'")
                print(f"alias .{name}='pushd \"{dir_name}\"'")
    except FileNotFoundError as e:
        #print(f"FileNotFoundError: {e}")
        pass;
    except Exception as e:
        #print(f"Exception: {e}")
        pass;


def main(argv):
    print(f"#!/bin/bash")
    for i in argv:
        f_make_dir(i)


if __name__ == "__main__":
    main(sys.argv[1:])

