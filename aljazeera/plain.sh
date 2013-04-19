#!/bin/bash

WD="$PWD"
NAME=$(basename $PWD)

rm -fr final
mkdir -p final
cd final

function extract_meta {
    sed -n '/meta.*"\(title\|author\)/p; /_CreateDate.*value/p; s/\(\r\|\t\)//g' $i >/tmp/metatext
    sed -e 's/\/>/&\n/g' -f "$WD/../ehtml.pattern"  -f "$WD/../alien.pattern" -i /tmp/metatext

    title=$(sed -n 's/.*"title".*="\(.*\)".*/\1/p' /tmp/metatext)
    author=$(sed -n 's/.*"author".*="\(.*\)".*/\1/p' /tmp/metatext)
    date="$sub/$(sed -n 's/.*_CreateDate.*=\"\(.*\) [[:alpha:]]\{3\} [0-9]\{4\}.*/\1/p' /tmp/metatext)"
}

for i in ../downloads/*/*/*; do
    sub=`echo $i | sed 's/.*\([0-9]\{4\}\/[0-9]\{2\}\).*/\1/g'`

    name="`echo $i | sed -n 's/.*\/\(.*\)\..*/\1/p'`"
    mkdir -p $sub

    #meta-data
    extract_meta
    if [ "$title" == "" ] || [ "$author" == "" ] || [ "$date" == "" ]; then continue; echo fail; fi
    echo $i
    echo -e "# TITLE@$title\n# AUTHOR@$author\n# DATE@$date\n# URL@http://www.aljazeera.com/indepth/opinion/$sub/$name.html\n" > $sub/$name.txt
    sed -n -f ../plain.pattern $i | sed -f "$WD/../ehtml.pattern" >> $sub/$name.txt
    echo -e "$title\t$author\t$date\t$name" >> "$NAME.csv"
done

# special case
sed 's/\t\t/\t/g' -i "$NAME.csv"
