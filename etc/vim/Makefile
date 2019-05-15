BUILD_DIR=build

ifdef USERPROFILE
all: vimrc install install.win
else
all: vimrc install
endif

vimrc:
	mkdir -p $(BUILD_DIR)
	./make-vimrc.sh unix > $(BUILD_DIR)/.vimrc
	./make-vimrc.sh win > $(BUILD_DIR)/_vimrc

clean:
	rm -rf $(BUILD_DIR)

#======================================================

install:
	cp $(BUILD_DIR)/.vimrc $(HOME)/.vimrc

#======================================================

install.win:
	cp $(BUILD_DIR)/.vimrc $(USERPROFILE)/.vimrc
	cp $(BUILD_DIR)/_vimrc $(USERPROFILE)/_vimrc

#======================================================

log: log.clean
	vim -c "q" --startuptime $(BUILD_DIR)/log.txt
	vim -u NONE -c "q" --startuptime $(BUILD_DIR)/log.zero.txt

log.clean:
	rm -f $(BUILD_DIR)/log.txt
	rm -f $(BUILD_DIR)/log.zero.txt

