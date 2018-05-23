#!/usr/bin/env python3

print("256 colors");
fgbg = 48;
color = 0;
while color < 256:
    if color < 16:
        n = 8;
    elif color < 232:
        n = 6;
    elif color < 256:
        n = 8;
    for i in range(n):
        print("\x1b[{0};5;{1}m  {1:03d}  \x1b[0m ".format(fgbg, color), end="");
        color += 1;
    print("");

