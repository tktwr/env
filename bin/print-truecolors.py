#!/usr/bin/env python3

print("true colors");
fgbg = 48;
for r in range(0, 255, 64):
    for g in range(0, 255, 64):
        for b in range(0, 255, 64):
            print("\x1b[{0};2;{1};{2};{3}m  {1:03d},{2:03d},{3:03d}  \x1b[0m ".format(fgbg, r, g, b), end="");
        print("");
