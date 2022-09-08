#!/usr/bin/env python3

print("true colors")
fgbg = 48
for r in range(0, 255, 64):
    for g in range(0, 255, 64):
        for b in range(0, 255, 64):
            print(f"\x1b[{fgbg};2;{r};{g};{b}m  {r:03d},{g:03d},{b:03d}  \x1b[0m ", end="")
        print("")
