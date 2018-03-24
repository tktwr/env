#!/bin/sh

wget http://openlab.jp/skk/dic/SKK-JISYO.L.gz
gzip -dc SKK-JISYO.L.gz | iconv -f EUC-JP -t UTF-8 > SKK-JISYO.L.utf-8

