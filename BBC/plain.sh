#!/bin/bash

rm -f article.list article.csv
find downloads/ -name "*.html" >> article.list
sed -i 's/downloads\///g; s/.html$//g' article.list

mkdir -p plain
cd plain

while read i; do
    sub=`echo $i | sed 's/.*\([0-9]\{4\}\/[0-9]\{2\}\).*/\1/g'`    
    mkdir -p $sub 

    #meta-data
#    sed -n ' /class="bbc-st/p' ../downloads/"$i".html > "$i.txt"

    sed -n 's/\r//g; /class="post"/,/vcard/p' ../downloads/"$i".html | sed 's/^ *//g; s/\t//g; /^$/d' > /tmp/metatext
    authorpub=`sed -n '/vcard/p' /tmp/metatext | sed 's/<[^>]*>//g'`
    author=`echo $authorpub | cut -d'|' -f1`
    date=`echo $authorpub | cut -d',' -f3`
    link=`sed -n '/Comments/p' /tmp/metatext | sed -n 's/.*href="\(.*\)#.*/\1/p'`
    title=`sed '/<h1>/q' /tmp/metatext | sed -n 's/.*<h1>\(.*\)<\/h1>.*/\1/p'`
    echo $title > "$i.txt"
    echo $link >> "$i.txt"
    echo -e "$author|$date\n" >> "$i.txt"

    sed -n 's/\r//g; /class="post_content"/,/class="bbc-st/p' ../downloads/"$i".html | sed 's/<[^>]*>//g' | sed 's/^ *//g; s/\t//g; /^$/d' >> "$i.txt"
    echo "$title,$author,$date,$link" >> ../article.csv
done < ../article.list
