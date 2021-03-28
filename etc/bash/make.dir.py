#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import os
import re


def f_expand_env(s):
    r = re.search('\$\w+', s)
    if r != None:
        matched = r.group()
        env_var = matched[1:]
        if env_var[:3] != "MY_":
            if os.getenv(env_var) != None:
                s = s.replace(matched, os.environ[env_var])
    return s


def f_expand_env2(fname):
    if os.getenv('USERPROFILE') != None:
        fname = fname.replace('$USERPROFILE', os.environ['USERPROFILE'])
    if os.getenv('USERNAME') != None:
        fname = fname.replace('$USERNAME', os.environ['USERNAME'])
    if os.getenv('HOME') != None:
        fname = fname.replace('$HOME', os.environ['HOME'])
    if os.getenv('VULKAN_SDK') != None:
        fname = fname.replace('$VULKAN_SDK', os.environ['VULKAN_SDK'])
    return fname


def f_expand_path_unix(fname):
    fname = f_expand_env(fname)
    fname = re.sub('^C:', '/c', fname)
    fname = fname.replace('\\', '/')
    return fname


def f_expand_path_win(fname):
    fname = f_expand_env(fname)
    fname = re.sub('(\$[^/]*)', '\\1_WIN', fname)
    fname = re.sub('^/c', 'C:', fname)
    #fname = fname.replace('/', '\\')
    fname = fname.replace('\\', '/')
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

                print(f"export {env_name}=\"{dir_name}\"")
                print(f"export {env_name}_WIN=\"{dir_name_win}\"")
                print(f"alias cd.{name}='cd \"{dir_name}\"'")
                print(f"alias .{name}='pushd \"{dir_name}\"'")
                print(f"alias d.{name}=',cd \"{dir_name}\"'")
                print(f"alias D.{name}=',nt \"{dir_name}\"'")
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

