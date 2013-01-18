#!/bin/bash

while read line; do
    echo $line | grep -e "^#" -e"^$"    
    if [ $? = "1" ]; then
	i=($(echo $line | sed 's/\&/\\&/g; s/\;/\\&/g'))
	echo s/${i[1]}/\\${i[0]}/g
	echo s/${i[2]}/\\${i[0]}/g
    fi
done < htmlentity

echo
echo '# stuff which were missing'
echo 's/\&amp\;/\&/g'
echo 's/\&#38\;/\&/g'
echo 's/\&nbsp\;/ /g'
echo 's/\&#160\;/ /g'
