#!/bin/bash

mkdir -p index
wget -c http://www.bbc.co.uk/blogs/theeditors/archives.html -O index/archives.html

sed -n 's/\r//g;/<div class=\"archives\">/,/<\/div>/p' index/archives.html | sed -n '/<li>/s/.*<a href="\(.*\)"[^>]*>.*/\1/p' | sort -rn > index.list

# Date Range from 2007 Jan to 2012 Dec 
sed -i '/2007\/01/q' index.list

cd index
while read i; do
    sub=`echo $i | sed 's/.*\([0-9]\{4\}\/[0-9]\{2\}\)/\1/g'`
    mkdir -p $sub
    cd $sub
    wget -c "$i"
    #TODO: if already exist don't update last one and stop.
    cd -
done < ../index.list
