none:
	echo "Try $ make <stuff>"

all:
	plain

index:
	./index.sh
	echo "index.list $(date)" > crawl.log 

download:
	./download.sh
	echo "download.list $(date)" >> crawl.log 

plain:	
	./plain.sh
	echo "article.list $(date)" >> crawl.log

dist:
	7z a "`basename $(PWD)`" plain/
