
all: install.all

install.all: install
	cd bash && make
	cd vim && make

clean.all: clean
	cd bash && make clean
	cd vim && make clean

install:
	./dot.sh --common-files --cp
	./dot.sh --common-files --cp $(USERPROFILE)

clean:

cmp:
	./dot.sh --common-files --diff-files
	./dot.sh --common-files --diff-files $(USERPROFILE)

vimdiff:
	./dot.sh --common-files --diff-files --vimdiff
	./dot.sh --common-files --diff-files --vimdiff $(USERPROFILE)

vimdirdiff:
	./dot.sh --common-files --diff-files --vimdirdiff

vimdirdiff-win:
	./dot.sh --common-files --diff-files --vimdirdiff $(USERPROFILE)

help:
	@echo "=== all ==="
	@echo "all"
	@echo "install.all"
	@echo "clean.all"
	@echo "=== command ==="
	@echo "install"
	@echo "clean"
	@echo "=== compare ==="
	@echo "cmp"
	@echo "vimdiff"
	@echo "vimdirdiff"
	@echo "vimdirdiff-win"

