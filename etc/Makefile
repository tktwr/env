all:
	./make.sh --all

all.min:
	./make.sh --min

clean:
	./make.sh --clean

#------------------------------------------------------

backup:
	./dot.sh --backup

init:
	./make.sh --init

.PHONY: bmk
bmk:
	./make.sh --bmk

#------------------------------------------------------

cmp:
	./dot.sh --all-files --cmp

vimdiff:
	./dot.sh --all-files --vimdiff

vimdirdiff:
	./dot.sh --all-files --vimdirdiff

.PHONY: tags
tags:
	ctags bash/*.sh vim/*.vim vim/plugin/*.vim

#------------------------------------------------------

help:
	@echo "all        ... all"
	@echo "all.min    ... all.min"
	@echo "clean      ... clean"
	@echo "backup     ... backup"
	@echo "init       ... init"
	@echo "cmp        ... compare"
	@echo "vimdiff    ... vimdiff"
	@echo "vimdirdiff ... vimdirdiff"
	@echo "help       ... print help"

