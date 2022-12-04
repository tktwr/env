#!/usr/bin/env python
# -*- coding: utf-8 -*-


def func():
    p  = None
    bt = True
    bf = False
    i  = 1
    f  = 1.5
    s  = "hello"
    v  = [0, 1, 2]
    t  = (0, 1, 2)
    d  = {'a': 0, 'b': 1}
    # ---------- [print] ----------
    print(f'p  = {p}')
    print(f'bt = {bt}')
    print(f'bf = {bf}')
    print(f'i  = {i}')
    print(f'f  = {f}')
    print(f's  = {s}')
    print(f'v  = {v}')
    print(f't  = {t}')
    print(f'd  = {d}')
    # ---------- [if] ----------
    if True and True:
        pass

    if True or True:
        pass

    if True:
        pass
    elif True:
        pass
    else:
        pass
    # ---------- [for] ----------
    for i in v:
        print(f'{i} ', end='')
    print()


if __name__ == "__main__":
    func()
