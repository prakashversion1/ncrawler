#!/bin/bash

WD="$PWD"
NAME=$(basename $PWD)

rm -fr final
mkdir -p final
cd final

function extract_data {

    sed '/<h2>/,/img src="http:..ekantipur.com.images.btn-complain-np.gif"/p'  -n $i > /tmp/data

    title=$(sed -n 's/.h2.\(.*\)..h2./\1/p' /tmp/data)
    # alpha_date="$(sed -n 's/.*_CreateDate.*=\"\(.*\) \([[:alpha:]]\{3\}\) \([0-9]\{4\}\).*/\3 \2 \1/p' /tmp/metatext)"
    date=$(echo $i | cut -b 14-23)
    alpha_date=$(date -d "$date" "+%Y %b %d")
    miti=$(sed 's/.*&#2346;&#2381;&#2352;&#2325;&#2366;&#2358;&#2367;&#2340; &#2350;&#2367;&#2340;&#2367;:.*b.\(.*\) *<.--News Details-->/\1/p' -n  /tmp/data |  sed -f "$WD/../ehtml_nepali.pattern")
 url="http://ekantipur.com/kantipur/news/news-detail.php?news_id=$(echo $name| cut -b 3-9)"
}

for i in ../downloads/*/*/*; do
    sub=$(echo $i | cut -b 14-20)
    name="`echo $i | sed -n 's/.*\/\(.*\)\..*/\1/p'`"
    mkdir -p $sub

    # extract-data
    extract_data

    if [ "$title" == "" ] || [ "$date" == "" ]; then echo $i fail; continue; fi
    echo -e "# TITLE@$title\n# DATE@$alpha_date\n# Miti=$mitiURL@$url" > $sub/$name.txt

    sed '/<.--News Details-->/,/<.--News Details-->/s/<[^>]*>//gp'  -n /tmp/data|  sed -f "$WD/../ehtml_nepali.pattern" >> $sub/$name.txt
    sed 's/\(.*\)प्रकाशित मिति:.*/\1/g' $sub/$name.txt -i
    # kinda buggy for some cases
    sed -i -f ../plain.pattern $sub/$name.txt
    echo -e "$title\t$author\t$date\t$name" >> "$NAME.csv"
    echo $i success
done

# special case
sed 's/\t\t/\t/g' -i "$NAME.csv"
