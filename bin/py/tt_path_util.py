#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import re


#------------------------------------------------------
# path
#------------------------------------------------------
def expand_env(s):
    r = re.search('\$\w+', s)
    if r != None:
        matched = r.group()
        env_var = matched[1:]
        if os.getenv(env_var) != None:
            s = s.replace(matched, os.environ[env_var])
    return s


def drive_unix(match):
    return f'/{match.group(1).lower()}'


def drive_windows(match):
    return f'{match.group(1).upper()}:/'


def path_unix(fname, prefix='', realpath=True):
    fname = fname.replace('\\', '/')
    fname = re.sub(f'^{prefix}', '', fname)
    fname = re.sub(f'^([c-zC-Z]):', drive_unix, fname)
    fname = re.sub(f'^(/[c-z]/)', f'{prefix}\\1', fname)
    if realpath and os.path.islink(fname):
        fname = os.path.realpath(fname)
    return fname


def path_mixed(fname, prefix='', realpath=True):
    fname = re.sub(f'^{prefix}', '', fname)
    fname = re.sub(f'^/([c-zC-Z])/', drive_windows, fname)
    fname = fname.replace('\\', '/')
    if realpath and os.path.islink(fname):
        fname = os.path.realpath(fname)
    return fname


def path_windows(fname, prefix='', realpath=True):
    fname = re.sub(f'^{prefix}', '', fname)
    fname = re.sub(f'^/([c-zC-Z])/', drive_windows, fname)
    fname = fname.replace('/', '\\')
    if realpath and os.path.islink(fname):
        fname = os.path.realpath(fname)
    return fname


