#!/bin/bash

./list.sh | grep "html" > /tmp/dlink

mkdir download -p
cd download

while read i; do 
    wget -c  http://www.aljazeera.com"$i";
done < /tmp/dlink
