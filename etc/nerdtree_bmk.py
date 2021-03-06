#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sys
sys.path.append(os.path.join(os.path.dirname(__file__), 'lib'))
import expand_path


def f_nerdtree_bmk(fname):
    try:
        with open(fname, "r") as f:
            for line in f:
                line = line.rstrip('\n')
                path = expand_path.f_expand_path("-u", line)
                print(path)
    except FileNotFoundError as e:
        #print(f"FileNotFoundError: {e}")
        pass;
    except Exception as e:
        #print(f"Exception: {e}")
        pass;


if __name__ == "__main__":
    f_nerdtree_bmk(".NERDTreeBookmarks")
    f_nerdtree_bmk("~/.my/nerdtree_bmk.txt")
