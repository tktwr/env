#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import re

ESC = "\x1b"

patterns = [
    # [xxx] の xxx だけ紫
    (re.compile(r"\[([^]]+)\]"),
     lambda m: f"[{ESC}[35m{m.group(1)}{ESC}[0m]"),

    # キーワード色付け
    (re.compile(r"OK"),   f"{ESC}[32mOK{ESC}[0m"),
    (re.compile(r"FAIL"), f"{ESC}[31mFAIL{ESC}[0m"),
    (re.compile(r"TODO"), f"{ESC}[37mTODO{ESC}[0m"),
    (re.compile(r"DONE"), f"{ESC}[32mDONE{ESC}[0m"),
]

for line in sys.stdin:
    for pat, repl in patterns:
        line = pat.sub(repl, line)
    sys.stdout.write(line)
