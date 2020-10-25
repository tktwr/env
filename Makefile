all: help

min-tar:
	git-tar.sh bin etc

tar:
	git-tar.sh

zip:
	git-zip.sh

help:
	@echo "all     ... help"
	@echo "min-tar ... tar bin etc directories"
	@echo "tar     ... tar the current directories"
	@echo "zip     ... zip the current directories"
	@echo "help    ... print help"
