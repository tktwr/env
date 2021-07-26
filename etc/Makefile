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

bmk_rm_local:
	./bmk_rm_local.sh $(MY_DOTMY_COMMON)/bmk.txt > out/bmk.txt
	./bmk_rm_local.sh $(MY_DOTMY_COMMON)/cmd.txt > out/cmd.txt

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

