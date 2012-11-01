#!/bin/bash

mkdir -p index
wget -c http://www.bbc.co.uk/blogs/theeditors/archives.html -O index/archives.html

sed -n '/<div class=\"archives\">/,/<\/div>/p' index/archives.html | sed 's/\r//g;' | sed -n '/<li>/s/.*<a href="\(.*\)"[^>]*>.*/\n\1\n/p' | sed '/^ *$/d; /^$/d' > allarchive.list

sort allarchive.list -r | sed '/2007\/01/q' > index.list

mkdir -p downloads
cd downloads
while read i; do
   sub=`echo $i | sed 's/.*\([0-9]\{4\}\/[0-9]\{2\}\)/\1/g'`
   mkdir -p $sub
   cd $sub
   wget -c "$i"
   cd -
done < ../index.list










