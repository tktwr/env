#!/bin/sh

cd $MY_DICT

#TERM=cygwin
#PAGER='lv -Ou8'

case $MY_OS_NAME in
  gitbash|msys)
    PAGER='iconv -f CP932 -t UTF-8'
    EBLOOK=./eblook.exe
    ;;
  wsl)
    EBLOOK=eblook
    ;;
esac

bin_name=`basename $0`

dict=""
appendix=""
subbook=1
word=""
entry=1

f_help() {
	echo "NAME"
	echo "  $bin_name - lookup a word in a dictionary"
	echo
	echo "SYNOPSIS"
	echo "  $bin_name -d=<dictionary> [-e=<number>] <word>"
  echo
  echo "OPTIONS"
  echo "  -d, --dictionary=<dictionary> set dictionary"
  echo "  -e, --entry=<number>          show contents of the entry"
  echo "  -h, --help                    print help"
  echo
  echo "DICTIONARIES"
	echo "  crown       german-japanese"
	echo "  daily       english-japanese"
	echo "  wordnet     english-english"
}

f_eblook() {
  $EBLOOK $dict $appendix << END | sed -e 's/eblook> //g' -e 's/[0-9a-zA-Z:]*	//'
select $subbook
search "$word"
content $entry
quit
END
}

f_filter() {
  sed -e 's+<prev>.*</prev>++' \
      -e 's+<next>.*</next>++' \
      -e "s/<gaiji=[^>]*>//g" \
      -e 's/・//g'
}

#==========================================================================
# dictionaries
#==========================================================================
f_crown() {
  dict="crown"
  appendix="crown-appendix"
  f_eblook | f_filter | $PAGER
}

f_daily() {
  dict="daily"
  f_eblook | f_filter | $PAGER
}

f_wordnet() {
  dict="wordnet"
  f_eblook | f_filter | $PAGER
}

#==========================================================================
# main
#==========================================================================

f_main() {
  dicid=""

	for i in $*; do
		case $i in
		-h|--help)
      f_help
      exit
      ;;
		-d=*|--dictionary=*)
      dicid=`echo $i | sed 's/-.*=//'`
      ;;
		-e=*|--entry=*)
      entry=`echo $i | sed 's/-.*=//'`
      ;;
		*)
      word="$word $i"
      ;;
		esac
	done

	if [ "x$dicid" = "x" -o "x$word" = "x" ]; then
		f_help
    exit
	fi

  word=`echo $word | sed 's/^ *//'`
}

f_main $*

case $dicid in
  crown)    f_crown ;;
  daily)    f_daily ;;
  wordnet)  f_wordnet ;;
  *)        echo "$bin_name: $dicid: No such dictionary"; exit ;;
esac

