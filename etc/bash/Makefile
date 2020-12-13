BUILD_DIR=build

all: bashrc install

#======================================================

bashrc:
	mkdir -p $(BUILD_DIR)
	./make.00.bashrc.env.sh > $(BUILD_DIR)/.bashrc.env
	./make.01.bashrc.sh > $(BUILD_DIR)/.bashrc

install:
	cp $(BUILD_DIR)/.bashrc.env $(HOME)
	cp $(BUILD_DIR)/.bashrc $(HOME)

clean:
	rm -rf $(BUILD_DIR)

#======================================================

install.min:
	cp bashrc.min $(HOME)/.bashrc

