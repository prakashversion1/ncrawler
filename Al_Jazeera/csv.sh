#!/bin/bash

sed 's/^Last.*: \(.*\) [0-9][0-9]:.*/\1/; s/"/\\"/g' LISTING  > /tmp/list.tmp
rm -f  LISTING.csv


while read i; do    
    if [  "$i" == "" ]; then
	echo $tmp >> LISTING.csv
	unset tmp
	continue
    fi
    tmp="$tmp, \"$i\""
done < /tmp/list.tmp


	
	
