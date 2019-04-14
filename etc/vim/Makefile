all: clean
	vim -c "q" --startuptime log.txt
	grep '/home/' log.txt | grep -v 'neobundle' > log-home.txt

zero: clean
	vim -u NONE -c "q" --startuptime log.txt
	grep '/home/' log.txt | grep -v 'neobundle' > log-home.txt

clean:
	rm -f log.txt log-home.txt

