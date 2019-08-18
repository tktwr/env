#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import json

def read_json(fname):
    f = open(fname, "r")
    json_data = json.load(f)
    print(json_data)
    f.close()
    return json_data

def write_json(fname, data):
    f = open(fname, "w")
    f.write(json.dumps(data))
    f.close()

def read_text(fname):
    f = open(fname, "r")
    text = ""
    for line in f:
        text += line
    f.close()
    return text

def write_text(fname, text):
    f = open(fname, "w")
    f.write(text)
    f.close()

json_data = read_json("test.json")
write_json("test2.json", json_data)

text = read_text("test.txt")
write_text("test2.txt", text)

