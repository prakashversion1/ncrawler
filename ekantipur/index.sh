#!/bin/bash

start_date='2010-01-01'
end_date='2012-12-31'

function download {
    local loc_date=$date
    wget $site --post-data "keyword_news_date=$date" -O index/$date'_index.html' -o /tmp/wget_index_$date'.log'
    rm  /tmp/wget_index_$date'.log'
    link=$(sed -n '/सम्पादकीय.*<\/h3>/,/.*<div class=.heading.*/s/.*href="\(.*\)">.*/\1/p' index/$date'_index.html' | uniq)
    if [[ -n $link ]]; then
	echo $loc_date, $link >> download.list.tmp
    fi
    echo $date
}

function start_download {
    rm -f download.list
    rm -f download.list.tmp

    rm -fr index/
    mkdir -p index

    date=$start_date
    days=$(($(($(date -d $end_date "+%s") - $(date -d $start_date "+%s"))) / 86400))
    site='http://ekantipur.com/kantipur/archive.php'
    for ((i=0 ; i<=days; i++ )); do
# for ((i=0 ; i<5; i++ )); do
	download &

	date=$(date -d "$date +1 days" +%Y-%m-%d)
    done
    while [ `jobs | wc -l` -gt 1 ]
    do
	sleep 10
    done
    sort download.list.tmp > download.list
    rm download.list.tmp
    echo 'Download complete'
}

function resume_download {

    date=$start_date
    days=$(($(($(date -d $end_date "+%s") - $(date -d $start_date "+%s"))) / 86400))
    site='http://ekantipur.com/kantipur/archive.php'
    for ((i=0 ; i<=days; i++ )); do
# for ((i=0 ; i<5; i++ )); do
	if [[ -z $(grep $date download.list.tmp) ]]; then
	    rm -f index/$date'_index.html'
	    download &
	    echo $date >> resuming
	fi
	date=$(date -d "$date +1 days" +%Y-%m-%d)
    done
    while [ `jobs | wc -l` -gt 1 ]
    do
	sleep 10
    done
    echo 'Download complete'
}


#checking arguments
if [ $# -eq 0 ]; then
    echo 'starting ...'
    start_download
    exit 1;
elif [ "$1" = "c" ]; then
    echo 'resuming ...'
    if [ -e download.list ]; then
	resume_download
    else
	start_download
    fi
else
    echo 'invalid arguments'
fi
