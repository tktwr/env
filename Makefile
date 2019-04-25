DIR=$(shell basename $(shell pwd))
DATE=`LC_TIME=C date '+%Y%m%d'`
TIME=`LC_TIME=C date '+%H%M%S'`
BRANCH=`git rev-parse --abbrev-ref HEAD 2>/dev/null`
COMMIT=`git rev-parse --short HEAD 2>/dev/null`

fname=$(DIR)-$(DATE)-$(TIME)-$(BRANCH)-$(COMMIT)

all:
	@echo "DIR=$(DIR)"
	@echo "DATE=$(DATE)"
	@echo "TIME=$(TIME)"
	@echo "BRANCH=$(BRANCH)"
	@echo "COMMIT=$(COMMIT)"
	@echo "fname=$(fname)"

min-tar:
	git archive HEAD bin etc --prefix=$(DIR)/ --output=min-$(fname).tar.gz

tar:
	git archive HEAD --prefix=$(DIR)/ --output=$(fname).tar.gz

zip:
	git archive HEAD --prefix=$(DIR)/ --output=$(fname).zip

