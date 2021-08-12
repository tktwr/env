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

#bmk-push:
#	./make.sh --bmk-push

bmk-pull:
	./make.sh --bmk-pull

#------------------------------------------------------

cmp:
	./dot.sh --all-files --cmp

vimdiff:
	./dot.sh --all-files --vimdiff

vimdirdiff:
	./dot.sh --all-files --vimdirdiff

.PHONY: tags
tags:
	ctags bash/*.sh vim/*.vim vim/plugin/*.vim vim/vim-plug/*.vim

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

