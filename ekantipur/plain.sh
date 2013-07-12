#!/bin/bash

WD="$PWD"
NAME=$(basename $PWD)

rm -fr final
mkdir -p final
cd final

function extract_meta {
    title=$(sed -n '1s/<h2.\(.*\)..h2>/\1/p' /tmp/data | sed -f ../plain.pattern)
    author="NULL"
    date=$(echo $i | cut -b 14-23)
    alpha_date=$(date -d "$date" "+%Y %b %d")
    miti=$(sed 's/.*&#2350;&#2367;&#2340;&#2367;:.*b.\(.*\) *<.--News Details-->/\1/p' -n  /tmp/data | sed -f "$WD/../ehtml_nepali.pattern")
    url="http://ekantipur.com/kantipur/news/news-detail.php?news_id=$(echo $name| cut -b 3-9)"
}

function extract_data {
    sed -n '/<h2>/,/img src.*ekantipur.*complain-np/p' $i > /tmp/data
    extract_meta
    sed 's/\r//' -i /tmp/data
}

for i in ../downloads/*/*/*; do
#for i in ../downloads/2010/05/09_216738.html; do
    sub=$(echo $i | cut -b 14-20)
    name="`echo $i | sed -n 's/.*\/\(.*\)\..*/\1/p'`"
    mkdir -p $sub

    extract_data

    if [ "$title" == "" ] || [ "$date" == "" ]; then echo $i fail; continue; fi
    echo -e "# TITLE@$title\n# DATE@$alpha_date\n# MITI@$miti\n# URL@$url" > $sub/$name.txt

    sed '/<.--News Details-->/,/<.--News Details-->/s/<[^>]*>//gp' -n /tmp/data >> $sub/$name.txt
    sed -f "$WD/../ehtml_nepali.pattern" $sub/$name.txt -i
    sed 's/\(.*\)प्रकाशित मिति:.*/\1/g' $sub/$name.txt -i

    # kinda buggy for some cases
    sed -i -f ../plain.pattern $sub/$name.txt
    echo -e "$title\t$author\t$date\t$name" >> "$NAME.csv"

    #echo -e "$title\t$author\t$date\t$name"
    #cat  $sub/$name.txt
    echo $i success
    #exit
done

# special case
sed 's/\t\t/\t/g' -i "$NAME.csv"
