#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
from PIL import Image
import numpy as np


def spec_to_metalrough(ifname, ofname):
    img = Image.open(ifname)

    if img.mode == "RGB":
        r, g, b = img.split()
    elif img.mode == "RGBA":
        r, g, b, a = img.split()

    zero = Image.new('L', img.size)
    one = Image.new('L', img.size, 255)

    ar = np.asarray(r, 'f')
    ar = 255 - ar
    rough = Image.fromarray(np.uint8(ar))

    o = Image.merge("RGBA", (zero, rough, zero, one))
    o.save(ofname)


if __name__ == "__main__":
    spec_to_metalrough(sys.argv[1], sys.argv[2])
