BUILD_DIR=build

all: init bashrc install

#======================================================

init:
	mkdir -p $(BUILD_DIR)
	./init.sh > $(BUILD_DIR)/.bashrc.env

bashrc:
	mkdir -p $(BUILD_DIR)
	./make-bashrc.sh > $(BUILD_DIR)/.bashrc

install:
	cp $(BUILD_DIR)/.bashrc.env $(HOME)
	cp $(BUILD_DIR)/.bashrc $(HOME)

clean:
	rm -rf $(BUILD_DIR)

#======================================================

install.min:
	cp bashrc.min $(HOME)/.bashrc

