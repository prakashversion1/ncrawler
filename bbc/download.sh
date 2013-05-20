#!/bin/bash

rm -f download.list
find index/ -name "*.html" -exec \
      sed -f download.pattern -n {} \; | sort -ur >> download.list

mkdir -p downloads
cd downloads

while read i; do
    sub=`echo $i | sed 's/.*\([0-9]\{4\}\/[0-9]\{2\}\).*/\1/g'`
    name=`basename $i`

    mkdir -p $sub

    cd $sub
    echo $PWD
    if [ ! -e "$name" ]; then
    	wget $i
    fi
    cd - > /dev/null
done < ../download.list
