#!/bin/bash

rm -f index.list
find index/ -name "*.html" -exec \
sed -f index.pattern -n {} \; | sort -u >> index.list

mkdir -p downloads/
cd downloads/
while read i; do
   sub=`echo $i | sed 's/.*\([0-9]\{4\}\/[0-9]\{2\}\).*/\1/g'`
   echo $sub
   mkdir -p $sub
   cd $sub
   wget -c "$i"
   cd -
done < ../index.list
