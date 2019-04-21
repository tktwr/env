
all: install

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

install:
	./dot.sh --common-files --cp
	./dot.sh --common-files --cp $(USERPROFILE)

help:
	@echo "all"
	@echo "cmp"
	@echo "vimdiff"
	@echo "vimdirdiff"
	@echo "vimdirdiff-win"
	@echo "install"

