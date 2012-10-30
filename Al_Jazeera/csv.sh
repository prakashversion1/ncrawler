#!/bin/bash

rm -f  LISTING.csv
sed 's/^Last.*: \(.*\) [0-9][0-9]:.*/\1/; s/"/\\"/g' LISTING  > /tmp/list.tmp



while read i; do    
    if [  "$i" == "" ]; then
	echo $tmp >> LISTING.csv
	unset tmp
	continue
    fi
    tmp="$tmp, \"$i\""
done < /tmp/list.tmp


	
	
