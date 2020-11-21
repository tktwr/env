all: all.install

all.install: install subdir.all
all.clean: clean subdir.clean

install.min:
	cd bash && make install.min
	cd vim && make install.min

subdir.all:
	cd bash && make all
	cd vim && make all

subdir.clean:
	cd bash && make clean
	cd vim && make clean

#======================================================

backup:
	./dot.sh --backup

init:
	./dot.sh --init

#======================================================

install:
	./dot.sh --common-files --cp

clean:

cmp:
	./dot.sh --all-files --cmp

vimdiff:
	./dot.sh --all-files --vimdiff

vimdirdiff:
	./dot.sh --all-files --vimdirdiff

#======================================================

help:
	@echo "all         ... all.install"
	@echo "all.install ... install, subdir"
	@echo "all.clean   ... clean, subdir"
	@echo "backup      ... backup"
	@echo "init        ... init"
	@echo "install     ... install"
	@echo "clean       ... clean"
	@echo "cmp         ... compare"
	@echo "vimdiff     ... vimdiff"
	@echo "vimdirdiff  ... vimdirdiff"
	@echo "help        ... print help"

