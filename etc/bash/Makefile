BUILD_DIR=build

ifdef USERPROFILE
all: bashrc install install.win
else
all: bashrc install
endif

bashrc:
	mkdir -p $(BUILD_DIR)
	./make-bashrc.sh unix > $(BUILD_DIR)/.bashrc

clean:
	rm -rf $(BUILD_DIR)

#======================================================

install:
	cp $(BUILD_DIR)/.bashrc $(HOME)/.bashrc

#======================================================

install.win:
	cp $(BUILD_DIR)/.bashrc $(USERPROFILE)/.bashrc

