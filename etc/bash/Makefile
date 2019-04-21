BUILD_DIR=build

all: bashrc install

bashrc:
	mkdir -p $(BUILD_DIR)
	./make-bashrc.sh > $(BUILD_DIR)/.bashrc

clean:
	rm -rf $(BUILD_DIR)

install: clean.cache
	cp $(BUILD_DIR)/.bashrc $(HOME)/.bashrc
	cp $(BUILD_DIR)/.bashrc $(USERPROFILE)/.bashrc

clean.cache:
	rm -f $(HOME)/.bashrc_cached
	rm -f $(USERPROFILE)/.bashrc_cached

