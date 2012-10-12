#!/bin/bash

rm -f ALIST
find download/ -name "*.html" -exec \
sed -f pattern -n {} \; | sort -u >> article.list

mkdir -p article
cd article
while read i; do
   sub=`echo $i | sed 's/.*\([0-9]\{4\}\/[0-9]\{2\}\).*/\1/g'`
   echo $sub
   mkdir -p $sub
   cd $sub
   wget -c "$i"
   cd -
done < ../ALIST
