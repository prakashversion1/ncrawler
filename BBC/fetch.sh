#!/bin/bash

mkdir -p download
wget -c http://www.bbc.co.uk/blogs/theeditors/archives.html -O download/archives.html

sed -n '/<div class=\"archives\">/,/<\/div>/p' archives.html | sed 's/\r//g;' | sed -n '/<li>/s/.*<a href="\(.*\)"[^>]*>.*/\n\1\n/p' | sed '/^ *$/d; /^$/d' > allarchive.list

sort allarchive.list -r | sed '/2007\/01/q' > index.list

mkdir -p download
cd download
while read i; do
   sub=`echo $i | sed 's/.*\([0-9]\{4\}\/[0-9]\{2\}\)/\1/g'`
   mkdir -p $sub
   cd $sub
   wget -c "$i"
   cd -
done < ../index.list










