#!/bin/bash

function job_count {

       echo no of jobs running
       ps -aux| grep wget.*ekantipur| wc
}

function downloaded_count {
       echo no of list in download.list
       wc download.list.tmp
}

echo ----------------------------
job_count
echo ----------------------------
downloaded_count
echo ----------------------------

for i in /tmp/wget*.log; do
    tail -1 $i
    echo
done
