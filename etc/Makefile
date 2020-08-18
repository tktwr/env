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
	./dot.sh --common-files --diff-files

vimdiff:
	./dot.sh --common-files --diff-files --vimdiff

vimdirdiff:
	./dot.sh --common-files --diff-files --vimdirdiff

#======================================================

install.win:
	./dot.sh --common-files --cp $(USERPROFILE)

clean.win:

cmp.win:
	./dot.sh --common-files --diff-files $(USERPROFILE)

vimdiff.win:
	./dot.sh --common-files --diff-files --vimdiff $(USERPROFILE)

vimdirdiff.win:
	./dot.sh --common-files --diff-files --vimdirdiff $(USERPROFILE)

#======================================================

help:
	@echo "=== all ==="
	@echo "all"
	@echo "all.install"
	@echo "all.clean"
	@echo "=== command ==="
	@echo "backup"
	@echo "init"
	@echo "install[.win]"
	@echo "clean[.win]"
	@echo "=== compare ==="
	@echo "cmp[.win|.all]"
	@echo "vimdiff[.win|.all]"
	@echo "vimdirdiff[.win]"

