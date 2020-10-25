all: all.install

ifdef USERPROFILE
all.install: subdir.all install install.win
all.clean: subdir.clean clean clean.win
cmp.all: cmp cmp.win
vimdiff.all: vimdiff vimdiff.win
else
all.install: subdir.all install
all.clean: subdir.clean clean
cmp.all: cmp
vimdiff.all: vimdiff
endif

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

install.win:
	./dot.sh --common-files --cp $(USERPROFILE)

clean.win:

cmp.win:
	./dot.sh --all-files --cmp $(USERPROFILE)

vimdiff.win:
	./dot.sh --all-files --vimdiff $(USERPROFILE)

vimdirdiff.win:
	./dot.sh --all-files --vimdirdiff $(USERPROFILE)

#======================================================

help:
	@echo "all         ... all.install"
	@echo "all.install ... subdir, install"
	@echo "all.clean   ... subdir, clean"
	@echo "backup"
	@echo "init"
	@echo "install"
	@echo "install.win"
	@echo "clean"
	@echo "clean.win"
	@echo "cmp            ... compare"
	@echo "cmp.win        ... compare for win"
	@echo "cmp.all        ... compare for all"
	@echo "vimdiff        ... vimdiff"
	@echo "vimdiff.win    ... vimdiff for win"
	@echo "vimdiff.all    ... vimdiff for all"
	@echo "vimdirdiff     ... vimdirdiff"
	@echo "vimdirdiff.win ... vimdirdiff for win"
	@echo "help           ... print help"

