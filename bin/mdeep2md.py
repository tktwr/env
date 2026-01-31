#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import re
from pathlib import Path

PATTERNS = [
    r'<link.*>',
    r'<style.*>.*</style>',
    r'<script.*>.*</script>',
    r'<meta name=.*>',
    r'^\s*\*\*[^*]*\*\*\s*$',
]

regex = re.compile('|'.join(PATTERNS))

def process_file(path: Path):
    text = path.read_text(encoding='utf-8')
    lines = text.splitlines(keepends=True)

    filtered = [line for line in lines if not regex.search(line)]

    path.write_text(''.join(filtered), encoding='utf-8')

def main():
    if len(sys.argv) < 2:
        print("Usage: mdeep2md.py file1 file2 ...")
        sys.exit(1)

    for fname in sys.argv[1:]:
        path = Path(fname)
        if not path.is_file():
            print(f"skip: {fname} (not a file)")
            continue

        process_file(path)
        print(f"processed: {fname}")

if __name__ == "__main__":
    main()

