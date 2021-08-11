BUILD_DIR=build

all:
	./make.sh --all

all.min:
	./make.sh --min

clean:
	./make.sh --clean

log: log.clean
	vim -c "q" --startuptime $(BUILD_DIR)/log.txt
	vim -u NONE -c "q" --startuptime $(BUILD_DIR)/log.zero.txt

log.clean:
	rm -f $(BUILD_DIR)/log.txt
	rm -f $(BUILD_DIR)/log.zero.txt

.PHONY: tags
tags:
	ctags *.vim plugin/*.vim vim-plug/*.vim

