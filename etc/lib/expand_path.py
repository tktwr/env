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
        if os.getenv(env_var) != None:
            s = s.replace(matched, os.environ[env_var])
    return s


def f_expand_path_unix(path):
    path = f_expand_env(path)
    path = path.replace('C:', '/c')
    path = path.replace('\\', '/')
    return path


def f_expand_path_mix(path):
    path = f_expand_env(path)
    path = path.replace('/c/', 'C:/')
    path = path.replace('\\', '/')
    return path


def f_expand_path_win(path):
    path = f_expand_env(path)
    path = path.replace('/c/', 'C:\\')
    path = path.replace('/', '\\')
    return path


def f_expand_path_win2(path):
    path = f_expand_env(path)
    path = path.replace('/c/', 'C:\\\\')
    path = path.replace('/', '\\\\')
    return path


def f_expand_path(opt, path):
    if opt == "-u":
        path = f_expand_path_unix(path)
    elif opt == "-m":
        path = f_expand_path_mix(path)
    elif opt == "-w":
        path = f_expand_path_win(path)
    elif opt == "-w2":
        path = f_expand_path_win2(path)
    return path


if __name__ == "__main__":
    path = f_expand_path(sys.argv[1], sys.argv[2])
    print(path)
