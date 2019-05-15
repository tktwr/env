all: all.install

ifdef USERPROFILE
all.install: subdir.install install install.win
all.clean: subdir.clean clean clean.win
cmp.all: cmp cmp.win
vimdiff.all: vimdiff vimdiff.win
else
all.install: subdir.install install
all.clean: subdir.clean clean
cmp.all: cmp
vimdiff.all: vimdiff
endif

subdir.install:
	cd bash && make
	cd vim && make

subdir.clean:
	cd bash && make clean
	cd vim && make clean

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
	@echo "install[.win]"
	@echo "clean[.win]"
	@echo "=== compare ==="
	@echo "cmp[.win|.all]"
	@echo "vimdiff[.win|.all]"
	@echo "vimdirdiff[.win]"

