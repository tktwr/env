all: clean
	vim -c "q" --startuptime log.txt
	grep '/home/' log.txt | grep -v 'neobundle' > log2.txt

clean:
	rm -f log.txt log2.txt

