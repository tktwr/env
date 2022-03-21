#!/usr/bin/env python
# -*- coding: utf-8 -*-

import argparse
import tt_util as tu
import app


def parse_args():
    parser = argparse.ArgumentParser(
        formatter_class=tu.MyHelpFormatter,
        description='show images')

    parser.add_argument('-xy',
                        type=int,
                        nargs=2,
                        default=[0, 0],
                        help='set position [x, y]')
    parser.add_argument('-s', '--size',
                        type=int,
                        nargs=2,
                        default=[500, 500],
                        help='set display size [w, h]')
    parser.add_argument('-cs', '--crop_size',
                        type=int,
                        nargs=2,
                        default=[500, 500],
                        help='set crop size [w, h]')
    parser.add_argument('files',
                        type=str,
                        nargs='*',
                        help='input files')

    return parser.parse_args()


if __name__ == "__main__":
    args = parse_args()
    app = app.App(args, "image-viewer.py", 500, 500)
    app.run()

