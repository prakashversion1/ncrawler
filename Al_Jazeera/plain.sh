#!/bin/bash

mkdir -p articles

for i in download/*; do
    name="`echo $i | sed -n 's/.*\/\(.*\)\..*/\1/p'`"
    grep '<p[^>]*>' "$i" | sed 's/<[^>]*>//g' > articles/$name.txt
done
