BUILD_DIR=build

ifdef USERPROFILE
all: all.unix.MINGW64 all.unix.gitbash all.win.gitbash
else
all: all.unix.bash
endif

all.unix.bash: vimrc.unix.bash install.unix.bash
all.unix.termux: vimrc.unix.termux install.unix.termux
all.unix.MINGW64: vimrc.unix.MINGW64 install.unix.MINGW64
all.unix.gitbash: vimrc.unix.gitbash install.unix.gitbash
all.win.gitbash: vimrc.win.gitbash install.win.gitbash

#======================================================

vimrc.unix.bash:
	mkdir -p $(BUILD_DIR)
	./make-vimrc.sh unix bash > $(BUILD_DIR)/.vimrc.unix.bash

vimrc.unix.termux:
	mkdir -p $(BUILD_DIR)
	./make-vimrc.sh unix termux > $(BUILD_DIR)/.vimrc.unix.termux

vimrc.unix.MINGW64:
	mkdir -p $(BUILD_DIR)
	./make-vimrc.sh unix MINGW64 > $(BUILD_DIR)/.vimrc.unix.MINGW64

vimrc.unix.gitbash:
	mkdir -p $(BUILD_DIR)
	./make-vimrc.sh unix gitbash > $(BUILD_DIR)/.vimrc.unix.gitbash

vimrc.win.gitbash:
	mkdir -p $(BUILD_DIR)
	./make-vimrc.sh win gitbash > $(BUILD_DIR)/_vimrc.win.gitbash

#======================================================

install.unix.bash:
	cp $(BUILD_DIR)/.vimrc.unix.bash $(HOME)/.vimrc

install.unix.termux:
	cp $(BUILD_DIR)/.vimrc.unix.termux $(HOME)/.vimrc

install.unix.MINGW64:
	cp $(BUILD_DIR)/.vimrc.unix.MINGW64 $(HOME)/.vimrc

install.unix.gitbash:
	cp $(BUILD_DIR)/.vimrc.unix.gitbash $(USERPROFILE)/.vimrc

install.win.gitbash:
	cp $(BUILD_DIR)/_vimrc.win.gitbash $(USERPROFILE)/_vimrc

#======================================================

clean:
	rm -rf $(BUILD_DIR)

#======================================================

log: log.clean
	vim -c "q" --startuptime $(BUILD_DIR)/log.txt
	vim -u NONE -c "q" --startuptime $(BUILD_DIR)/log.zero.txt

log.clean:
	rm -f $(BUILD_DIR)/log.txt
	rm -f $(BUILD_DIR)/log.zero.txt

