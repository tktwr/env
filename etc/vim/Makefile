all:
	./make.sh

min:
	./make_min.sh

log: log.clean
	vim -c "q" --startuptime $(HOME)/vim_log.txt
	vim -u NONE -c "q" --startuptime $(HOME)/vim_log_zero.txt

log.clean:
	rm -f $(HOME)/vim_log.txt
	rm -f $(HOME)/vim_log_zero.txt

