BUILD_DIR=build

ifdef USERPROFILE
all: vimrc install vimrc.win install.win
else
all: vimrc.termux install.termux
endif

#======================================================

vimrc:
	mkdir -p $(BUILD_DIR)
	./make-vimrc.sh unix MINGW64 > $(BUILD_DIR)/.vimrc.unix.MINGW64

vimrc.win:
	mkdir -p $(BUILD_DIR)
	./make-vimrc.sh unix gitbash > $(BUILD_DIR)/.vimrc.unix.gitbash
	./make-vimrc.sh win  MINGW64 > $(BUILD_DIR)/_vimrc.win.MINGW64

vimrc.termux:
	mkdir -p $(BUILD_DIR)
	./make-vimrc.sh unix termux > $(BUILD_DIR)/.vimrc.unix.termux

#======================================================

install:
	cp $(BUILD_DIR)/.vimrc.unix.MINGW64 $(HOME)/.vimrc

install.win:
	cp $(BUILD_DIR)/.vimrc.unix.gitbash $(USERPROFILE)/.vimrc
	cp $(BUILD_DIR)/_vimrc.win.MINGW64 $(USERPROFILE)/_vimrc

install.termux:
	cp $(BUILD_DIR)/.vimrc.unix.termux $(HOME)/.vimrc

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

