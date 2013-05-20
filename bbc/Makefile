NAME=`basename $(PWD)`

all:
	@echo "make [index|download|fina|dist|clean|reset]"
index:
	./index.sh
	echo -e "`date`\tindex" >> $(NAME).log 

download: downloads index
	./download.sh
	echo -e "`date`\tdownload" >> $(NAME).log 

fina: downloads
	./plain.sh
	echo -e "`date`\tplain" >> $(NAME).log

dist: final
	echo -e "`date`\tcompressed" >> $(NAME).log
	rm -f "$(NAME).7z"
	cp "$(NAME).log" final/
	7z a "$(NAME)" final/

clean: final
	rm -rf final

reset:
	rm -rf *.list *.7z final downloads index *.log	
