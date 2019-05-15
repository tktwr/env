BUILD_DIR=build

ifdef USERPROFILE
all: bashrc install install.win
else
all: bashrc install
endif

bashrc:
	mkdir -p $(BUILD_DIR)
	./make-bashrc.sh > $(BUILD_DIR)/.bashrc

clean:
	rm -rf $(BUILD_DIR)

#======================================================

install: clean.cache
	cp $(BUILD_DIR)/.bashrc $(HOME)/.bashrc

clean.cache:
	rm -f $(HOME)/.bashrc_cached

#======================================================

install.win: clean.cache.win
	cp $(BUILD_DIR)/.bashrc $(USERPROFILE)/.bashrc

clean.cache.win:
	rm -f $(USERPROFILE)/.bashrc_cached

