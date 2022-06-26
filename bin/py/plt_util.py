#!/usr/bin/env python
# -*- coding: utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt


#------------------------------------------------------
def make_data(func, xrange=(0, 1, 100)):
    x = np.linspace(*xrange)
    y = []
    for i in x:
        y.append(func(i))

    return (x, y)


#------------------------------------------------------
def plot_data(x, y, ofname=''):
    fig, ax = plt.subplots()
    ax.plot(x, y, color='r', marker='.')
    ax.set_xlabel('x axis')
    ax.set_ylabel('y axis')
    if ofname != '':
        plt.savefig(ofname)
    plt.show()


def plot_rgb_data(x, y, ofname=''):
    Y = np.asarray(y)
    r = Y[:,0]
    g = Y[:,1]
    b = Y[:,2]
    fig, ax = plt.subplots()
    ax.plot(x, r, color='r', marker='.')
    ax.plot(x, g, color='g', marker='.')
    ax.plot(x, b, color='b', marker='.')
    ax.set_xlabel('x axis')
    ax.set_ylabel('y axis')
    if ofname != '':
        plt.savefig(ofname)
    plt.show()


#------------------------------------------------------
def read_data(fname):
    with open(fname, 'r') as f:
        lines = f.readlines()

    x = []
    r = []
    g = []
    b = []

    for line in lines:
        v = line.split(" ")
        x.append(float(v[0]))
        r.append(float(v[1]))
        g.append(float(v[2]))
        b.append(float(v[3]))

    return (x, r, g, b)


def write_data(fname, x, y):
    with open(fname, "w") as f:
        l = list(zip(x, y))
        for ix, iy in l:
            try:
                s = " ".join([str(i) for i in iy])
            except TypeError as te:
                s = str(iy)
            f.write(f'{ix} {s}\n')


