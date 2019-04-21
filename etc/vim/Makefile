BUILD_DIR=build

all: vimrc install

vimrc:
	mkdir -p $(BUILD_DIR)
	./make-vimrc.sh > $(BUILD_DIR)/.vimrc
	./make-gvimrc.sh > $(BUILD_DIR)/_vimrc

clean:
	rm -rf $(BUILD_DIR)

install:
	cp $(BUILD_DIR)/.vimrc $(HOME)/.vimrc
	cp $(BUILD_DIR)/.vimrc $(USERPROFILE)/.vimrc
	cp $(BUILD_DIR)/_vimrc $(USERPROFILE)/_vimrc

log: log.clean
	vim -c "q" --startuptime $(BUILD_DIR)/log.txt
	grep '/home/' $(BUILD_DIR)/log.txt | grep -v 'neobundle' > $(BUILD_DIR)/log-home.txt

log.zero: log.clean
	vim -u NONE -c "q" --startuptime $(BUILD_DIR)/log.txt
	grep '/home/' $(BUILD_DIR)/log.txt | grep -v 'neobundle' > $(BUILD_DIR)/log-home.txt

log.clean:
	rm -f $(BUILD_DIR)/log.txt
	rm -f $(BUILD_DIR)/log-home.txt

