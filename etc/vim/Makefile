BUILD_DIR=build

all: vimrc install

vimrc:
	mkdir -p $(BUILD_DIR)
	./make-vimrc.sh > $(BUILD_DIR)/.vimrc

clean:
	rm -rf $(BUILD_DIR)

install:
	cp $(BUILD_DIR)/.vimrc $(HOME)/.vimrc
	cp $(BUILD_DIR)/.vimrc $(USERPROFILE)/.vimrc

log: log.clean
	vim -c "q" --startuptime $(BUILD_DIR)/log.txt
	vim -u NONE -c "q" --startuptime $(BUILD_DIR)/log.zero.txt

log.clean:
	rm -f $(BUILD_DIR)/log.txt
	rm -f $(BUILD_DIR)/log.zero.txt

