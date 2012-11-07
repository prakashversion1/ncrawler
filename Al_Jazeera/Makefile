DIR = `pwd`
NAME = `basename $DIR`

none:
	echo "Try $ make <stuff>"

csv:
	./csv.sh

all:
	download

download:
	./download.sh

plain:	
	./plain.sh

dist:
	7z a "`basename $(PWD)`" plain/

clean:
	rm -f LISTING list

list:
	./list.sh > LISTING

