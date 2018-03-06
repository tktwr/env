DIR=$(shell basename $(shell pwd))
DATE=`LC_TIME=C date '+%Y%m%d'`
TIME=`LC_TIME=C date '+%H%M%S'`

fname=$(DIR)-$(DATE)-$(TIME)

all:
	@echo "DIR=$(DIR)"
	@echo "DATE=$(DATE)"
	@echo "TIME=$(TIME)"
	@echo "fname=$(fname)"

min-tar:
	git archive HEAD bin etc --prefix=$(DIR)/ --output=min-$(fname).tar.gz

tar:
	git archive HEAD --prefix=$(DIR)/ --output=$(fname).tar.gz

zip:
	git archive HEAD --prefix=$(DIR)/ --output=$(fname).zip

