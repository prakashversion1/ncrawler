#!/bin/bash

mkdir -p blogs

while read i; do
    name=`echo "$i" | cut -d ',' -f1`
    link=`echo "$i" | cut -d ',' -f2 | tr -d " "`
#   echo $link
    mkdir -p "blogs/$name"
    cd "blogs/$name"
    i=1
    wget -c "$link" -O "$i"
    #fetching next    
    next=`sed -n "s|pageNext|&|p" $i | sed "s|.*$link\(.*\)\".*Next</a>.*|\1|"`
    while true; do
	i=$(($i+1))
	wget -c $link$next -O $i
	sed -n "s|pageNext|&|p" $i | grep "nav-link-not-active" > /dev/null
	if [ "$?" == 0 ]; then
	    break;
	fi     
    done
    cd -
done < authors.list
