#!/usr/bin/env python

print("256 colors")
fgbg = 48
color = 0
while color < 256:
    n = 8
    if color < 16:
        n = 8
    elif color < 232:
        n = 6
    elif color < 256:
        n = 8
    for i in range(n):
        print(f"\x1b[{fgbg};5;{color}m  {color:03d}  \x1b[0m ", end="")
        color += 1
    print("")
