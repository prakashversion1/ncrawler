#!/bin/bash

# the index should fresh so re-download everything
rm -fr index
mkdir index -p
cd index

count=1
while true; do
    wget "http://www.aljazeera.com/Services/IncludePart/?T=15&Id=201082874848848938&P=$count&V=2" -O "$count.html"
    grep 'Next </a>' $count.html > /dev/null
    if [ $? == "1" ]; then break; fi
    count=$((count+1))
done
