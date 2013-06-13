#!/bin/bash

rm -rf downloads

mkdir downloads


function download {
    wget $link -O downloads/$sub'_'$name -o /tmp/wget_download_$name'.log'
    rm  /tmp/wget_download_$name'.log'
    echo download$sub'_'$name
}
while read i; do
    sub=`echo $i|  sed "s/\(....\)-\(..\)-\(..\).*/\1\/\2\/\3/g"`
    link=`echo $i| grep -o http://ekantipur.com.*`
    mkdir -p downloads/$(dirname $sub)
    name=`echo $link| cut -b 60-66`'.html'
    download &
done < download.list

while [ `jobs | wc -l` -gt 1 ]
do
    sleep 5
done
echo 'Download complete'
