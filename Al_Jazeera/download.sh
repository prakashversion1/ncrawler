#!/bin/bash

if [ -e LISTING ]; then
    grep "html" LISTING > /tmp/dlink
else
    ./list.sh | grep "html" > /tmp/dlink
fi

echo "No of articles found: " `wc -l /tmp/dlink`

mkdir downloads -p
cd downloads

while read i; do
    modi=`basename $i`
    if [ ! -e "$modi" ]; then
	wget -c  http://www.aljazeera.com"$i";
    fi
done < /tmp/dlink
