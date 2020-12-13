BUILD_DIR=build

all:
	./make.sh

all.min:
	cp min_vimrc.vim $(HOME)/.vimrc

clean:
	rm -rf $(BUILD_DIR)

log: log.clean
	vim -c "q" --startuptime $(BUILD_DIR)/log.txt
	vim -u NONE -c "q" --startuptime $(BUILD_DIR)/log.zero.txt

log.clean:
	rm -f $(BUILD_DIR)/log.txt
	rm -f $(BUILD_DIR)/log.zero.txt

