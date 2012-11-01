#!/bin/bash


wget -c http://blogs.reuters.com/us/ 

sed -n '/BLOGS, COLUMNISTS/p' index.html | sed 's/<li/\n&/g' | sed -n 's|.*<a href="\(.*\)">\(.*\)</a>.*|\2, \1|p' > authors.list

rm -f index.html
