#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys


def print_column(list_str, width):
    max_ssize = 0
    lsize = len(list_str)
    for i in list_str:
        ssize = len(i)
        max_ssize = max(ssize, max_ssize)
    max_ssize = max_ssize + 1

    column = int(width / max_ssize)
    offset = int((lsize + column - 0.1) / column)

    for i in range(offset):
        for j in range(column):
            idx = i + j * offset
            if idx < lsize:
                tag_name = list_str[idx]
                print(f"{tag_name:<{max_ssize}s}", end='')
        print()


def print_tags(fname, width, types):
    list_tag = {}
    for i in types.keys():
        list_tag[i] = []

    with open(fname, mode="r") as tags_file:
        lines = tags_file.readlines()
        for line in lines:
            cell = line.strip().split("\t")
            tag_name = cell[0]

            if tag_name[0] == "!":
                continue

            if len(cell) >= 4:
                tag_type = cell[3]
            else:
                tag_type = '*'

            if not (tag_type in types.keys()):
                continue

            if tag_name in list_tag[tag_type]:
                continue
            else:
                list_tag[tag_type].append(tag_name)

    separator = "-" * width
    for i in types.keys():
        print(f"{separator}")
        print(f"# {i} {types[i]}")
        print(f"{separator}")
        print_column(list_tag[i], width)
    print()


def print_cpp_tags(fname, width):
    cpp_types = {
        'n': "namespaces",
        'd': "macro definitions",
        'v': "variable definitions",
        't': "typedefs",
        'c': "classes",
        's': "structure names",
        'u': "union names",
        'g': "enumeration names",
        'e': "enumerators (values inside an enumeration)",
        'h': "included header files",
        'f': "function definitions",
        'm': "class, struct, and union members",
        'l': "local variables [off]",
        'p': "function prototypes [off]",
        'x': "external and forward variable declarations [off]",
        'z': "function parameters inside function definitions [off]",
        'L': "goto labels [off]",
        'D': "parameters inside macro definitions [off]",
        'A': "namespace aliases [off]",
        'N': "names imported via using scope::symbol [off]",
        'U': "using namespace statements [off]",
        'Z': "template parameters [off]",
    }
    print_tags(fname, width, cpp_types)

def print_vim_tags(fname, width):
    vim_types = {
        'a': "autocommand groups",
        'c': "user-defined commands",
        'f': "function definitions",
        'm': "maps",
        'v': "variable definitions",
        'n': "vimball filename",
    }
    print_tags(fname, width, vim_types)

def print_sh_tags(fname, width):
    sh_types = {
        'a': "aliases",
        'f': "functions",
        's': "script files",
        'h': "label for here document",
    }
    print_tags(fname, width, sh_types)


def print_memo_tags(fname, width):
    memo_types = {
        '*': "tag",
    }
    print_tags(fname, width, memo_types)


def main(argv):
    fname = argv[1]
    width = int(argv[2])
    type = argv[3]

    if type == "cpp":
        print_cpp_tags(fname, width)
    elif type == "vim":
        print_vim_tags(fname, width)
    elif type == "sh":
        print_sh_tags(fname, width)
    elif type == "memo":
        print_memo_tags(fname, width)


if __name__ == "__main__":
    main(sys.argv)

