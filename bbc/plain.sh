#!/bin/bash

WD="$PWD"
NAME=$(basename $PWD)


rm -rf final
mkdir -p final
rm -f /tmp/metatext
cd final

filename=/tmp/metatext

function extract_meta {
    author=`sed -n '/vcard.author/s/.*.>\(.*\)<.a>.*/\1/p' $filename`
    alpha_date=`sed -n "/vcard/s/.*, \([0-9]\{2\}\).*\([A-Z][a-z]\{2\}\).*\([0-9]\{4\}\).*/\3 \2 \1/p" $filename`
    link=`sed -n "/bookmark/s/.*href=.\(.*\)..rel.*/\1/p" $filename`
    title=`sed -n '/bookmark/s/.*.>\(.*\)<.a><.h2>.*/\1/p' $filename`
    date=`sed -n "/title/s/.*=.\([0-9]\{4\}\)-\([0-9]\{2\}\)-\([0-9]\{2\}\)T[0-9]\{2\}.*/\1\/\2\/\3/p" $filename`
}

function extract_content {
    name=`echo $link | sed 's/.*[0-9]\{4\}\/[0-9]\{2\}\/\(.*\).htm.*/\1/g'`
    echo -e "# TITLE@$title\n# AUTHOR@$author\n# DATE@$alpha_date\n# URL@$link\n" > $sub/$name.txt
    
    sed -n "/post_content/,/<\/div>/p" $filename | sed -n -f ../plain.pattern | sed /^$/d >> $sub/$name.txt
    sed -i -f ../plain.pattern $sub/$name.txt
}

function extract_article {
    echo Year/Month/ $sub
    while read line; do
	line_post=`echo $line | grep 'class="post"'`
	if [[ $? == "0" ]]; then
	    article_count=$((article_count+1))
	    echo $i Article-$article_count
	    extract_meta
	    if [ "$title" == "" ]  || [ "$author" == "Host" ] || [ "$author" == "" ] || [ "$date" == "" ]; then echo fail; cat /dev/null > $filename; continue; fi
	    extract_content
	    echo -e "$title\t$author\t$date\t$name" >> "$NAME.csv"
	    cat /dev/null > $filename
	fi
	echo $line >> $filename
    done < $i
}

for i in ../downloads/*/*/*; do
#for i in ../downloads/2007/01/*; do
    sub=`echo $i | sed 's/.*\([0-9]\{4\}\/[0-9]\{2\}\).*/\1/g'`    

    mkdir -p $sub 
    
    article_count=0
    #meta-data
    extract_article
done

# special case
sed 's/\t\t/\t/g' -i "$NAME.csv"
