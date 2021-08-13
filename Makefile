all: help

min-tar:
	git-tar.sh bin etc

tar:
	git-tar.sh

zip:
	git-zip.sh

.PHONY: tags
tags:
	ctags -f tags.bin.sh  bin/*.sh
	ctags -f tags.bin.py  bin/py/*.py
	ctags -f tags.etc.sh  etc/bash/*.sh
	ctags -f tags.etc.vim etc/vim/*.vim etc/vim/plugin/*.vim etc/vim/vim-plug/*.vim

help:
	@echo "all     ... help"
	@echo "min-tar ... tar bin etc directories"
	@echo "tar     ... tar the current directories"
	@echo "zip     ... zip the current directories"
	@echo "help    ... print help"
