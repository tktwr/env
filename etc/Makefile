all:
	./dot.sh --common-files --cp
	cd bash && make all
	cd vim && make all

all.min:
	./dot.sh --common-files --cp
	cd bash && make all.min
	cd vim && make all.min

clean:
	cd bash && make clean
	cd vim && make clean

#------------------------------------------------------

backup:
	./dot.sh --backup

init:
	./dot.sh --init

#------------------------------------------------------

cmp:
	./dot.sh --all-files --cmp

vimdiff:
	./dot.sh --all-files --vimdiff

vimdirdiff:
	./dot.sh --all-files --vimdirdiff

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

