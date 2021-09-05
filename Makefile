all: help

snap:
	git-tar.sh $(MY_SNAP)

.PHONY: tags
tags:
	ctags -f tags.bin.sh  bin/*.sh
	ctags -f tags.bin.py  bin/py/*.py
	ctags -f tags.etc.sh  etc/bash/*.sh
	ctags -f tags.etc.vim etc/vim/*.vim etc/vim/plugin/*.vim etc/vim/vim-plug/*.vim

help:
	@echo "all     ... help"
	@echo "snap    ... make a snapshot"
	@echo "help    ... print help"
